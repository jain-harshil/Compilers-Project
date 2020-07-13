%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>  
#include "calc.h"  /* Contains definition of `symrec'        */
int  yylex(void);
void yyerror (char  *);
int whileStart=0,nextJump=0; /*two separate variables not necessary for this application*/
int count=0;
int labelCount=0;
FILE *fp;
struct StmtsNode *final;
void StmtsTrav(stmtsptr ptr);
void StmtTrav(stmtptr ptr);
%}
%union {
int   val;  /* For returning numbers.                   */
struct symrec  *tptr;   /* For returning symbol-table pointers      */
char c[1000];
char nData[100];
struct StmtNode *stmtptr;
struct StmtsNode *stmtsptr;
}


/* The above will cause a #line directive to come in calc.tab.h.  The #line directive is typically used by program generators to cause error messages to refer to the original source file instead of to the generated program. */

%token  <val> NUM        /* Integer */
%token <val> RELOP
%token  WHILE FOR SEMIC
%token <tptr> VAR   
%type  <c>  exp
%type <nData> x
%type <stmtsptr> stmts 
%type <stmtptr> stmt a_stat

%right '='
%left '-' '+'
%left '*' '/'


/* Grammar follows */

%%
prog: stmts {final=$1; printf("at line 45\n");}
stmts: stmt {$$=(struct StmtsNode *) malloc(sizeof(struct StmtsNode));
   $$->singl=1;$$->left=$1,$$->right=NULL; printf("at line 47\n");}
| stmt stmts {$$=(struct StmtsNode *) malloc(sizeof(struct StmtsNode));
   $$->singl=0;$$->left=$1,$$->right=$2; printf("at line 49\n");}
     ;

stmt:
          '\n' {$$=NULL; printf("line 53 null statement\n");}
        | WHILE '(' VAR RELOP VAR ')' '{' stmts '}' '\n' {$$=(struct StmtNode *) malloc(sizeof(struct StmtNode));
	    $$->isWhileOrFor=1;
	    sprintf($$->initCode,"lw $t0, %s($t8)\nlw $t1, %s($t8)\n", $3->addr,$5->addr);
	    sprintf($$->initJumpCode,"bge $t0, $t1,");
	    $$->down=$8; printf("at line 58\n");}
      | FOR '(' a_stat SEMIC VAR RELOP VAR SEMIC a_stat ')' '{' stmts '}' '\n' 
{$$=(struct StmtNode *) malloc(sizeof(struct StmtNode));
	    $$->isWhileOrFor=2;
	    sprintf($$->initCode,"lw $t0, %s($t8)\nlw $t1, %s($t8)\n", $5->addr,$7->addr);
	    sprintf($$->initJumpCode,"bge $t0, $t1,");
	    $$->down=$12; $$->forinit=$3; $$->forincre=$9;  printf("at line 64\n");}
      | a_stat {$$=$1; printf("at line 60 stmt to assign\n");};

a_stat: VAR '=' exp    {printf("Test1");$$=(struct StmtNode *) malloc(sizeof(struct StmtNode));
	    $$->isWhileOrFor=0;
	    sprintf($$->bodyCode,"%s\nsw $t0,%s($t8)\n", $3, $1->addr);
	    $$->down=NULL; printf("at line 65\n");}
        | error '\n' { yyerrok; printf("at line 66\n");};
/* Invariant: we store the result of an expression in R0 */

exp:      x                { sprintf($$,"%s",$1);count=(count+1)%2;}
        | x '+' x  { sprintf($$,"%s\n%s\nadd $t0, $t0, $t1",$1,$3);}
        | x '-' x        { sprintf($$,"%s\n%s\nsub $t0, $t0, $t1",$1,$3);}
        | x '*' x        { sprintf($$,"%s\n%s\nmul $t0, $t0, $t1",$1,$3);}
        | x '/' x        { sprintf($$,"%s\n%s\ndiv $t0, $t0, $t1",$1,$3);}
;
x:   NUM {sprintf($$,"li $t%d, %d",count,$1);count=(count+1)%2; printf("at line 75\n");}
| VAR {sprintf($$, "lw $t%d, %s($t8)",count,$1->addr);count=(count+1)%2; printf("at line 76\n");};
/* End of grammar */
%%

void StmtsTrav(stmtsptr ptr){
  printf("stmts\n");
  if(ptr==NULL) return;
	  if(ptr->singl==1)StmtTrav(ptr->left);
	  else{
	  StmtTrav(ptr->left);
	  StmtsTrav(ptr->right);
	  }
	  }
 void StmtTrav(stmtptr ptr){
   int ws,nj;
   printf("stmt\n");
   if(ptr==NULL) return;
   if(ptr->isWhileOrFor==0){fprintf(fp,"%s\n",ptr->bodyCode);}
   if(ptr->isWhileOrFor==1){ws=whileStart; whileStart++;nj=nextJump;nextJump++;
     fprintf(fp,"LabStartWhile%d:%s\n%s NextPart%d\n",ws,ptr->initCode,ptr->initJumpCode,nj);StmtsTrav(ptr->down);
     fprintf(fp,"j LabStartWhile%d\nNextPart%d:\n",ws,nj);}
    if(ptr->isWhileOrFor==2){ws=whileStart; whileStart++;nj=nextJump;nextJump++;
    // fprintf(fp,"writing init \n");
     StmtTrav(ptr->forinit);
    //  fprintf(fp,"writen init \n");
     fprintf(fp,"LabStartWhile%d:%s\n%s NextPart%d\n",ws,ptr->initCode,ptr->initJumpCode,nj);StmtsTrav(ptr->down);
    //  fprintf(fp,"writing forincr \n");
     StmtTrav(ptr->forincre);
    //  fprintf(fp,"writt incr \n");
     fprintf(fp,"j LabStartWhile%d\nNextPart%d:\n",ws,nj);}
}
   


int main ()
{
   fp=fopen("asmb.asm","w");
   fprintf(fp,".data\n\n.text\nli $t8,268500992\n");
   yyparse ();
   StmtsTrav(final);
   fprintf(fp,"\nli $v0,1\nmove $a0,$t0\nsyscall\n");
   fclose(fp);
}

void yyerror (char *s)  /* Called by yyparse on error */
{
  printf ("%s\n", s);
}
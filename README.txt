#How to compile:

rm lex.yy.c calc.tab.c calc.tab.h a.out
bison --debug -d calc.y
flex --debug tok.l
gcc calc.tab.c lex.yy.c -lfl


.prog file syntax

if-else syntax:

e.g.
condition should be only of this form: a<b

if(a<b){
t = t+1
}else{
j = j+1
}


For loop syntax:
for(i=0;i<j;i=i+1){   
k = k+1
}

Break statement syntax:
if(a<b)break


---------------------
How to run:
./a.out<strln.prog

The output will be asmb.asm. Load asmb.asm in Mars, assemble and run.
---------------------

1. What is the output? The last expression is the output.

2. Put a nextline character at the end of the last statement. 

3. The condition inside the while loop needs to of atomic nature (var relop var).

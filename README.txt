#Team Members
	Rohit Patil   17110126
	Anubhav Jain  17110021
	Chandan Maji  17110037
	Harshil Jain  17110060


#How to compile:

	rm lex.yy.c calc.tab.c calc.tab.h a.out
	bison --debug -d calc.y
	flex --debug tok.l
	gcc calc.tab.c lex.yy.c -lfl

#How to run:
	./a.out<strln.prog


#Features : 
	if-else (nested support)
	While loop (nested support)
	For loop (nested support)
	break statement


# .prog file syntax

	if-else syntax:

		e.g.
		condition should be only of this form: a<b

		if(a<b){
		t = t+1
		}else{
		j = j+1
		}

	while loop syntax:
		
		e.g
		while(a<b){
		a=a+1
		}

	for loop syntax:

		e.g
		for(i=0;i<j;i=i+1){   
		k = k+1
		}

	Break statement syntax:
		
		e.g
		if(a<b)break


---------------------
How to run:
	./a.out<[program_name]

	e.g
	./a.out<strln.prog


#Sample programs

	We have provided these example programs:
		double.prog
		double_while_example.prog
		while_break_example.prog
		for_break_example.prog
		while_for_example.prog
		nested_for_example.prog
		nested_if_example.prog
		for_if_example.prog
		strln.prog


The output will be asmb.asm. Load asmb.asm in Mars, assemble and run.
---------------------

1. What is the output? The last expression is the output.

2. Put a nextline character at the end of the last statement. 

3. The condition inside the while loop needs to of atomic nature (var relop var).

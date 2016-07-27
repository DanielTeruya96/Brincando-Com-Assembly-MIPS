.data
	msg_menu : .asciiz ""
	msg_op_incorreta: .asciiz ""
	msg_espaco: .asciiz " "
	msg_n: .asciiz "Digite o N"
	txt_enter: .asciiz "\n"
	msg_v: .asciiz "digite o numero do vetor"
	msg_no: .asciiz "O seu vetor nao ordenado sera "
	vetor: .word 5,12,15,2,5,6,14,23,25,39,23,14,22
	
.text
	#$t7 é uma variavel globa que terá o tamaho do vetor
	#imprimir o "digite n"
	li $v0,4
	 la $a0,msg_n
	  syscall
	  
	li $v0,4	#quebra de linha
	 la $a0,txt_enter
	  syscall
	
	#ler o n
	li $v0, 5
	syscall

	move $t7,$v0
	
	li $v0,4	
	 la $a0,msg_no
	  syscall
	  
	  li $v0,4	#quebra de linha
	 la $a0,txt_enter
	  syscall

	move $t6,$t7
	la $s0,0
loop: 
	
	
	lw $t1,vetor($s0)
	
	li $v0,1
	move $a0,$t1
	syscall
	
	li $v0,4	
	 la $a0,msg_espaco
	  syscall
	
incrementar:
	addi $s0,$s0,4
	addi $t6,$t6,-1
	bgtz $t6,loop
	
	

	
	
	
	
	

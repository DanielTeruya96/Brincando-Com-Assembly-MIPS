.data
	vetor: .word 45,8,2,5,12,13,14,15,16,17,18,19,20
	lenght: .word 5
	stacp:.word 0
	abre: .asciiz "["
	fecha: .asciiz "] "
	quebraDeLinha: .asciiz"\n"

.text
	lw $t7,lenght($zero)
	
	move $t6,$t7
repeat:
	beq $t6,0,bubbleFinal
	subi $t6,$t6,1 #t6--
	
	addi $t5,$zero,0
srepeat:
	bge $t5,$t6,repeat
	
	mul $a2,$t5,4
	lw $a1,vetor($a2)
	addi $t5,$t5,1
	mul $a3,$t5,4
	lw $a0,vetor($a3)
	
	bgt $a0,$a1,srepeat
	sw $ra,stacp($zero)
	jal troca
	lw $ra,stacp($zero)
	
	j srepeat
	
	
	
	

bubbleFinal:
	move $a1, $zero
	move $a3,$t7
	sw $ra,stacp($zero)
	jal exibiir
	lw $ra,stacp($zero)
	li $v0,10
	syscall




troca:
	sw $a0,vetor($a2)
	sw $a1,vetor($a3)
	jr $ra

exibiir:
	
	mul $t2,$a1,4 #multiplica o indice
	lw $t1, vetor($t2) #pega o valor do vetor
	
	li $v0,4 #exibi a mensagem de abrir 
	la $a0,abre
	syscall
	
	li $v0,1 #exibi o numero que ta no $t1
	move $a0,$t1
	syscall
	
	li $v0,4 #exibi a mensagem de fechar
	la $a0,fecha
	syscall
	
	addi $a1,$a1,1  #i++
	blt $a1,$a3,exibiir
	
	li $v0,4
	la $a0,quebraDeLinha
	syscall
	jr $ra #Fim exibiiir


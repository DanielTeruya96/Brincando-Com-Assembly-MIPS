.data
	vetor: .word 6,15,8,2,5,12,13,14,15,16,17,18,19,20
	lenght: .word 5
	stacp:.word 0
	abre: .asciiz "["
	fecha: .asciiz "] "
	quebraDeLinha: .asciiz"\n"

.text

	lw $t7,lenght($zero)
	subi $t7,$t7,1
	add $t6,$zero,$zero
	
primeiroLoop:
	bge $t6,$t7,selectionFinal
	addi $a2,$zero,0
	mul $t5,$t6,4
	lw $t4,vetor($t5)
	addi $t3,$t6,1

	mul $t2,$t3,4
	lw $t1,vetor($t2)
	
segundoLoop:
	beq $t3,$t7,primeiroFim
	addi $t3,$t3,1 #t3++
	mul $a0,$t3,4
	lw $a1,vetor($a0)

	ble $t1,$a1,segundoLoop
	#comparacao
	move $t2,$a0
	move $t1,$a1
	addi $a2,$zero,1
	j segundoLoop
	
primeiroFim:
	addi $t6,$t6,1
	
	
	bge $t1,$t4,primeiroLoop
	move $a0,$t1
	move $a1,$t4
	move $a2,$t5
	move $a3,$t2
	sw $ra,stacp($zero)
	jal troca
	lw $ra,stacp($zero)
	j primeiroLoop
	
	
	
	
	
	
	
selectionFinal:
	sw $ra,stacp($zero)
	move $a1, $zero
	addi $t7,$t7,1
	move $a3, $t7
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


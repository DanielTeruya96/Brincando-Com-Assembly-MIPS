.data
	vetor: .word 5,4,3,2,1
	lenght: .word 5
	trocado: .word 0
	stacp:.word 0
	abre: .asciiz "["
	fecha: .asciiz "] "
	quebraDeLinha: .asciiz"\n"
	
.text
	lw $t7,lenght($zero) #carrega o tamnho do vetor em $t7
	
	addi $t6,$zero,0
for:	
	addi $t6,$t6,1
	beq $t6,$t7,finaliza
	add $t5,$t6,$zero
	move $t0,$t6
while:
	subi $t5,$t5,1
	bltz $t5,for
	
	mul $t4,$t0,4
	mul $t3,$t5,4
	
	lw $t2,vetor($t4)
	lw $t1,vetor($t3)
	
	bge $t2,$t1,for #se t2 for maior que t1 entao volta pro for se nao troca
	sw $ra, stacp($zero) #salva o valor do registrador ra
	add $a0,$t2,$zero
	add $a1,$t1,$zero
	add $a2,$t3,$zero
	add $a3,$t4,$zero
	
	jal troca
	lw $ra,stacp($zero) #devolve o valor do registrador ra
	move $t0,$t5
	j while

troca:
	sw $a0,vetor($a2)
	sw $a1,vetor($a3)
	jr $ra
	
	
	
	
	
finaliza:
	add $a1,$zero,$zero
	add $a3,$zero,$t7
	sw $ra, stacp($zero) #salva o valor do registrador ra
	jal exibiir
	lw $ra,stacp($zero) #devolve o valor do registrador ra
	
	li $v0,10
	syscall
	
	

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
	jr $ra

	
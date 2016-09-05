.data
	m_inicial: .asciiz "Bem vindo ao Sort digite o tamanho do vetor que deseja criar\n"
	quebraDeLinha: .asciiz"\n"
	um: .asciiz "digite o [ "
	dois: .asciiz " ] do vetor\n"
	abre: .asciiz "["
	fecha: .asciiz "] "
	menu: .asciiz "seu vetor \n"
	vetor: .word 1,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20
	lenght: .word 5
	nemu: .asciiz "1-Insertion Sort\n2-Selection Sort\n3-Bubble Sort\n4-MergeSort\n"
	stacp:.word 0
.text
	main:
	#apresenta a mensagem
	li $v0,4
	la $a0,m_inicial
	syscall
	
	#le o numero
	li $v0,5 #seil a
	syscall
	
	#salva no lenght o tamanho do vetor
	move $s0,$v0
	sw $s0, lenght($zero)
	
	#comeca o while aqui
	addi $t0,$zero,0
	addi $t7,$zero,4
	
	
loop:	
	
	
	li $v0,4 #apresenta a mensagem 
	la $a0,um
	syscall
	
	
	li $v0,1 #mostra o numero 
	move $a0,$t0
	syscall
	
	li $v0,4 #apresenta a segunda parte da mensagem
	la $a0,dois
	syscall
	
	li $v0,5 #le o valor digitado pelo usuario
	syscall
	move $t1,$v0
	
	
	mul $t2,$t0,$t7 #multiplica o indice
	
	sw $t1,vetor($t2)#guarda o valor no vetor
	
	
	
	
	addi $t0,$t0,1  #i++
	blt $t0,$s0,loop
	
	li $v0,4
	la $a0,menu
	syscall
	
	addi $t0,$zero,0 #seta o indice para zero
	
	#comeca a exibir o vetor
exibir:
	mul $t2,$t0,$t7 #multiplica o indice
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
	
	addi $t0,$t0,1  #i++
	blt $t0,$s0,exibir
	
	li $v0,4
	la $a0,quebraDeLinha
	syscall
	
	li $v0,4	#aparece o menu
	la $a0,nemu
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0
	
	subi $t1,$t1,1
	beq $t1,$zero,insertion
	subi $t1,$t1,1
	beq $t1,$zero,selection
	subi $t1,$t1,1
	beq $t1,$zero,bubble
	subi $t1,$t1,1
	beq $t1,$zero,merge
	subi $t1,$t1,1
	beq $t1,$zero,escolhaerrada
	
fimEscolha:
	li $v0,10
	syscall
	
insertion:
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
	jr $ra #Fim exibiiir

	
	j fimEscolha
	
selection:
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
	
	j fimEscolha
bubble:
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
	


	j fimEscolha
merge: 
	addi $t1,$t1,4
	li $v0,1
	move $a0,$t1
	syscall
	j fimEscolha
	
escolhaerrada:
	addi $t1,$t1,5
	li $v0,1
	move $a0,$t1
	syscall
	j fimEscolha
	
	
	
	
	
	
	
	
	

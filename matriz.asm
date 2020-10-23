#####################################################################
#Disciplina: Arquitetura e Organiza��o de Processadores II
#Atividade: Avalia��o 03 � Hierarquia de Mem�ria
#Exerc�cio 03
#Aluna: Ana Clara Pr�sse e Sabrina dos Passos Tortelli
#C�digo em Assembly
####################################################################
# SEGMENTO DE DADOS                                                            
####################################################################

   .data                            # Informa o in�cio do segmento de 
                                    # dados, onde declaramos todas as 
                                    # vari�veis envolvidas.

MatrizA: .space 400                #declara��o da matriz

msgEntrada:.asciiz "\nComo deseja percorrer a matriz?"  # mensagem
                                                         # de chamada                                                
               
linhaColuna:.asciiz "\nLinha-coluna = 0"# mensagem para entrada dos
                                          # elementos da matriz_A 
                                          
colunaLinha:.asciiz "\nColuna-linha = 1"# mensagem para entrada dos
                                          # elementos da matriz_A 

msgSaida:.asciiz "\nSoma dos elementos da matriz:" # mensagem
                                                          # sa�da 

msgInvalido:.asciiz "\nValor Invalido" # mensagem de valor invalido
                                                    
####################################################################
# SEGMENTO DE C�DIGO                                                           
####################################################################

    .text                  # Informa o in�cio do segmento de c�digo, 
                           # onde fica o programa.


main:                         # O in�cio do programa

	la $s1, MatrizA		# carrega a matriz para $s1
       
        addi $s4, $zero, 0	# declara��o da vari�vel $s4(i=0)
        addi $s2, $zero, 10	# declara��o da vari�vel $s2(n=10)
        addi $s3, $zero, 100	# declara��o da vari�vel $s3(n� elem = 100)
       
input:
	
	li $v0, 4		# carrega o servi�o 4 (print string)
	la $a0, msgEntrada     	# carrega ptr para string msgEntrada         
       	syscall                	# chama o servi�o
       	li $v0, 4              	# carrega o servi�o 4 (print string)
	la $a0, linhaColuna   	# carrega ptr para string linhaColuna         
       	syscall               	# chama o servi�o
       	li $v0, 4              	# carrega o servi�o 4 (print string)
	la $a0, colunaLinha    	# carrega ptr para string colunaLinha         
       	syscall                	# chama o servi�o
       	
       	li $v0, 5              	# carrega o servi�o 5 (l� inteiro)
      	syscall                	# chama o servi�o
       	
       	ble $v0, -1, invalid    # Se $v0 < 0, ent�o chama invalid
     	bgt $v0, 1, invalid     # Se $v0 > 1, ent�o chama invalid

     	j saveInput		# Se passar pelos testes ent�o vai para
   	                        # a label saveInput

invalid:  
      
    	li $v0, 4              	# carrega o servi�o 4 (print string)
     	la $a0, msgInvalido    	# carrega ptr para string msgInvalido         
     	syscall                	# chama o servi�o

   	j input                	# volta para a label input

saveInput:

     	add $s5, $v0, $0       	# carrega leitura em $s5
       
loopMatrix: 

       	slt $t0, $s4, $s3       # se i($s4)<$s3 ent�o $t0=1 sen�o $t0=0
       	beq $t0, $zero, exitMatrix   # se $t0=0 ent�o goto exitMatrix
       
       	add $t1, $s4, $s4      # $t1 = 2*1
       	add $t1, $t1, $t1      # $t1 = 4*1
       	add $t1, $t1, $s1      # $t1 = end. Base + 4*i = end. absoluto
       	lw $t2, 0($t1)         # $t2 = A[0]
       
       	add $t2, $s4, $0       # incrementa $t2 de 0 a 99

       	sw $t2, 0($t1)         # A[i] = $t2

       	addi $s4, $s4, 1       # i++ (do la�o for)
       	j    loopMatrix        # goto loopMatrix

exitMatrix:  nop
	
	addi $s7, $zero, 0	#declara��o da vari�vel sum($s7=0)
	addi $s6, $zero, 0	#declara��o da vari�vel cont($s6=0)
	addi $s4, $zero, 0    	#declara��o da vari�vel $s4 (i=0)
	addi $t4, $zero, 0	# declara��o da vari�vel de endere�o
	addi $t5, $zero, 1	#declara��o da vari�vel $t5=1
	beq $s5, $t5, loopColLin 	# if($s5 == 1) vai para loopColLin  
	
	
loopLinCol:

	slt $t0, $s4, $s3       # se i($s4)<$s3 ent�o $t0=1 sen�o $t0=0
       	beq $t0, $zero, exitLoops   # se $t0=0 ent�o goto exitLoops
       
       	add $t1, $s4, $s4      	# $t1 = 2*1
       	add $t1, $t1, $t1      	# $t1 = 4*1
       	add $t1, $t1, $s1      	# $t1 = end. Base + 4*i = end. absoluto
       	lw $t2, 0($t1)         	# $t2 = A[0]
       
       	add $s7, $s7, $t2       # soma os elementos da matriz 
       	
       	addi $s4, $s4, 1        # i++ (do la�o for)
      
       	j    loopLinCol		# goto loopLinCol
       	
loopColLin:

	slt $t0, $s4, $s3       # se i($s2)<$s3 ent�o $t0=1 sen�o $t0=0
       	beq $t0, $zero, exitLoops   # se $t0=0 ent�o goto exitLoops
       
       	add $t1, $t4, $t4      # $t1 = 2*1
       	add $t1, $t1, $t1      # $t1 = 4*1
       	add $t1, $t1, $s1      # $t1 = end. Base + 4*i = end. absoluto
       	lw $t2, 0($t1)         # $t2 = A[0]
       
       	add $s7, $s7, $t2       # soma os elementos da matriz 
       	
       	addi $s4, $s4, 1        # i++ (do la�o for)
       	addi $s6, $s6, 1        # incrementa em 1
       	addi $t4, $t4, 10	# incrementa 10
       	
       	beq $s6, $s2, increment #se $t3==10 vai para incremento
       	j    loopColLin         # goto loopColLin
       	
       	
increment:
	
	addi $s6, $zero, 0	#zera a vari�vel $s6
	addi $t4, $t4, -99 	#diminiu 99 posi��es para nova coluna
	
	j    loopColLin         # goto loopColLin
	
exitLoops:	

	li $v0, 4              	# carrega o servi�o 4 (print string)
       	la $a0, msgSaida	# carrega ptr para string msg_saida         
       	syscall               	# chama o servi�o

       	addi $v0, $0, 1        	# carrega o servi�o 1 (print inteiro)
       	add $a0, $0, $s7       	# carrega o servi�o em $a0
       	syscall                	# chama o servi�o
       

 ####################################################################

.data

.macro read_num(%int)  #Macro para ler numero inteiro
	li $v0, 5 
	syscall
	move %int, $v0
.end_macro 

.macro print(%str)  #Macro para apresentar mensagem ao usu�rio
	.data
		msg: .asciiz %str
	.text
		li $v0, 4
		la $a0, msg
		syscall
.end_macro

.macro print_int(%int)  #Macro para print em numero inteiro
	li $v0, 1
	la $a0, (%int)
	syscall
.end_macro 

.text
princ:
	print("-----BEM VINDO-----\n")  #Apresenta as op��es ao usu�rio
	print("1- Inserir item\n")
	print("2- Remover item\n")
	print("3- Consultar item\n")
	print("4- Encerrar programa\n")
	print("Escolha uma op��o: ")
	read_num($t1)  #Recebe a op��o
	
	beq $t1, 1, inserir   #Se a op��o for a primeira redireciona a inserir
	beq $t1, 2, remover   #Se a op��o for a segunda redireciona a remover
	beq $t1, 3, consulta  #Se a op��o for a terceira redireciona a consulta
	beq $t1, 4, fim	      #Se o usu�rio quiser encerrar o programa
	
	j erro                #Caso haja algum numero n�o listado nas op��es
	
	inserir:
		print("Quantos valores voc� deseja inserir? ")
		read_num($t2)    #Recebe os valores que o usu�rio deseja inserir
		
		add $t3, $t2, $t3  #Soma os valores com os que haviam sido adicionado antes
		j princ     #Volta ao inicio, para escolher outra op��o
		
	remover:
		print("Quantos itens deseja remover? ")    #Solicita e recebe os itens que deseja remover
		read_num($t2)
		
		sub $t3, $t3, $t2    #Subtrai os valores adicionados com os que que ser�o removidos
		ble $t3, 0, fim     #Caso o resultado d� 0, ele finaliza o programa
		j princ             #Caso n�o seja 0, ele volta as op��es 
		
		
		
	consulta:
		print("Voc� possui: ")    #Apresenta ao usu�rio os itens
		print_int($t3)
		j princ
	erro:
		print("Op��o invalida\n")  #Caso a op��o seja invalida, ele da um erro e apresenta ao usu�rio, e volta as op��es
		j princ
	
	fim:
		print("Realizar compra")  #Encerramento do programa
		li $v0, 10
		syscall
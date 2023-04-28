.data

.macro read_num(%int)  #Macro para ler numero inteiro
	li $v0, 5 
	syscall
	move %int, $v0
.end_macro 

.macro print(%str)  #Macro para apresentar mensagem ao usuário
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
	print("-----BEM VINDO-----\n")  #Apresenta as opções ao usuário
	print("1- Inserir item\n")
	print("2- Remover item\n")
	print("3- Consultar item\n")
	print("4- Encerrar programa\n")
	print("Escolha uma opção: ")
	read_num($t1)  #Recebe a opção
	
	beq $t1, 1, inserir   #Se a opção for a primeira redireciona a inserir
	beq $t1, 2, remover   #Se a opção for a segunda redireciona a remover
	beq $t1, 3, consulta  #Se a opção for a terceira redireciona a consulta
	beq $t1, 4, fim	      #Se o usuário quiser encerrar o programa
	
	j erro                #Caso haja algum numero não listado nas opções
	
	inserir:
		print("Quantos valores você deseja inserir? ")
		read_num($t2)    #Recebe os valores que o usuário deseja inserir
		
		add $t3, $t2, $t3  #Soma os valores com os que haviam sido adicionado antes
		j princ     #Volta ao inicio, para escolher outra opção
		
	remover:
		print("Quantos itens deseja remover? ")    #Solicita e recebe os itens que deseja remover
		read_num($t2)
		
		sub $t3, $t3, $t2    #Subtrai os valores adicionados com os que que serão removidos
		ble $t3, 0, fim     #Caso o resultado dê 0, ele finaliza o programa
		j princ             #Caso não seja 0, ele volta as opções 
		
		
		
	consulta:
		print("Você possui: ")    #Apresenta ao usuário os itens
		print_int($t3)
		j princ
	erro:
		print("Opção invalida\n")  #Caso a opção seja invalida, ele da um erro e apresenta ao usuário, e volta as opções
		j princ
	
	fim:
		print("Realizar compra")  #Encerramento do programa
		li $v0, 10
		syscall
.data
z: .float 0.0  #Define 0, em uma variavel z



.macro read_numf(%float)   	#Macro para ler numero float
	li $v0, 6 #Por definição o valor digitado fica guardado em $f0
	syscall
	mov.s  %float, $f0
.end_macro 

.macro print_result(%result)	#Macro para print numero float
	li $v0, 2
	mov.s $f12, %result
	syscall 
.end_macro 

.macro print(%str)		#Macro para aprensentar mensagens ao usuário
	.data
		msg: .asciiz %str
	.text
		li $v0, 4
		la $a0, msg
		syscall
.end_macro

.text

	print("Digite 1 para iniciar o programa: ")	#Para iniciar o programa digita 1
	read_numf($f9)
	
	lwc1 $f1, z					#Recebe o valor 0 em z, e move para $f2
	mov.s $f2, $f1
	
	Main:
		print("Quantos valores você vai digitar? ")  #Quantos valores serão recebidos pelo usuário
		read_numf($f3)
		c.le.s $f3, $f2  			    #Caso o valor digitado a cima seja menor ou igual a 0, ele apresenta um erro
		bc1t erro
	
	num:
		print("Digite o numero: ")		#Looping que vai receber os numeros do usuário
		read_numf($f4)
		
		add.s $f5, $f5, $f4			#Soma os valores digitados pelo usuário, para fazer a média no final
		
		add.s $f7, $f7, $f9			#Contador para fazer a média no final
		
		sub.s $f3, $f3, $f9			#O usuário digitou quantos numeros ele digitaria
		c.eq.s $f3, $f2				#Será subtraido -1 esse valor, até dar 0, quando o numero der 0, ele encerra o looping, e pula para o fim do código
		bc1t fim
		
		j num					#Caso o numero a cima não deu 0 ainda, ele volta a solicitar outro numero ao usuário

	erro:
		print("Digite um valor valido\n")	#Print do Erro, caso o usuário deseja digitar 0 ou menos valores
		j Main
	fim:
		div.s $f6, $f5, $f7			#Será calculado a média com a soma dos valores e o contador 
		print("A média dos numeros digitados é: ")
		print_result($f6)			#Apresenta ao usuário a média de todos os numeros digitador
		
		li $a0, 10				#Encerra o código
		syscall
		li $v0, 1
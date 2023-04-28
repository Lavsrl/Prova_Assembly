.data
z: .float 0.0  #Define 0, em uma variavel z



.macro read_numf(%float)   	#Macro para ler numero float
	li $v0, 6 #Por defini��o o valor digitado fica guardado em $f0
	syscall
	mov.s  %float, $f0
.end_macro 

.macro print_result(%result)	#Macro para print numero float
	li $v0, 2
	mov.s $f12, %result
	syscall 
.end_macro 

.macro print(%str)		#Macro para aprensentar mensagens ao usu�rio
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
		print("Quantos valores voc� vai digitar? ")  #Quantos valores ser�o recebidos pelo usu�rio
		read_numf($f3)
		c.le.s $f3, $f2  			    #Caso o valor digitado a cima seja menor ou igual a 0, ele apresenta um erro
		bc1t erro
	
	num:
		print("Digite o numero: ")		#Looping que vai receber os numeros do usu�rio
		read_numf($f4)
		
		add.s $f5, $f5, $f4			#Soma os valores digitados pelo usu�rio, para fazer a m�dia no final
		
		add.s $f7, $f7, $f9			#Contador para fazer a m�dia no final
		
		sub.s $f3, $f3, $f9			#O usu�rio digitou quantos numeros ele digitaria
		c.eq.s $f3, $f2				#Ser� subtraido -1 esse valor, at� dar 0, quando o numero der 0, ele encerra o looping, e pula para o fim do c�digo
		bc1t fim
		
		j num					#Caso o numero a cima n�o deu 0 ainda, ele volta a solicitar outro numero ao usu�rio

	erro:
		print("Digite um valor valido\n")	#Print do Erro, caso o usu�rio deseja digitar 0 ou menos valores
		j Main
	fim:
		div.s $f6, $f5, $f7			#Ser� calculado a m�dia com a soma dos valores e o contador 
		print("A m�dia dos numeros digitados �: ")
		print_result($f6)			#Apresenta ao usu�rio a m�dia de todos os numeros digitador
		
		li $a0, 10				#Encerra o c�digo
		syscall
		li $v0, 1
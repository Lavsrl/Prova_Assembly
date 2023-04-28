.data 

.macro print(%str)  #Macro para apresentar mensagens
	.data
		msg: .asciiz %str
	.text
		li $v0, 4
		la $a0, msg
		syscall
.end_macro

.macro read_num(%int) #Macro para ler numero inteiro
	li $v0, 5 
	syscall
	move %int, $v0
.end_macro 


.text
	print("Digite seu ano de nascimento: ")  #Solicita e recebe ano de nascimento do usu�rio
	read_num($t2)
	
	bgt $t2, 2005, reprovado   #Se o ano de nascimento do usu�rio � maior que 2005, ele est� reprovado.
	#Caso seja menor ou igual, ele � aprovado
	aprovado:  
		print("Voc� j� pode ter uma carteira nacional de habilita��o (CNH)") 
		j fim #Pula para o fim do codigo para n�o rodar o reprovado
	reprovado:
		print("Voc� ainda n�o pode ter uma carteira nacional de habilita��o (CNH)")
		
	fim:
		li $v0, 10
		syscall
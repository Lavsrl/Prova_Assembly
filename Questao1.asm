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
	print("Digite seu ano de nascimento: ")  #Solicita e recebe ano de nascimento do usuário
	read_num($t2)
	
	bgt $t2, 2005, reprovado   #Se o ano de nascimento do usuário é maior que 2005, ele está reprovado.
	#Caso seja menor ou igual, ele é aprovado
	aprovado:  
		print("Você já pode ter uma carteira nacional de habilitação (CNH)") 
		j fim #Pula para o fim do codigo para não rodar o reprovado
	reprovado:
		print("Você ainda não pode ter uma carteira nacional de habilitação (CNH)")
		
	fim:
		li $v0, 10
		syscall
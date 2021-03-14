#rechteck.asm
#Rechteck zeichnen und berechnen. Handelt es sich um Rechteck oder Quadrat

.data
	a: .byte 0
	b: .byte 0
	
	nl: .asciiz "\n"
	stern: .asciiz "*  "
	quadrat: .asciiz "Quadrat"
	rechteck: .asciiz "Rechteck"
.text
main:
	li, $v0, 5
	syscall
	sb $v0, a		#einlesen der Variable a
	
	lb $t1, a		#speichert a in $t1
	
	li, $v0, 5
	syscall
	sb $v0, b		#einlesen der Variable b
	
	lb $t2, b		#speichert b in $t2
	
	mul $t3, $t1,$t2	#berechnet Fläche
	
	move $a0, $t3		#ausgeben des berechneten wertes
	li, $v0, 1
	syscall
	
	la $a0, nl		#macht neue Zeile
	li $v0, 4
	syscall
	
	beq $t1, $t2, then	#überprüft ob a=b ist
else:
	la $a0,rechteck		#gibt rechtck aus
	li $v0,4
	syscall
	j endif			#hüpt nach endif
then:
	la $a0,quadrat		#gibt quadrat aus
	li $v0,4
	syscall
endif:

	la $a0,nl		#gibt \n aus
	li $v0,4
	syscall

	lb $t2, a					#leadt a (Spalten) auf $t2
	lb $t3, b					#leadt b (Zeilen) auf $t3

Zeile:
	bge $t0, $t3, endZeile
	sub $t1, $t1, $t1				#$t1 wird auf 0 gesetzt
	
	Spalte:
		bge $t1, $t2, endSpalte
		la $a0, stern			#gibt Stern aus
		la $v0, 4
		syscall			
		addi $t1, $t1, 1
	j Spalte
	endSpalte:
	
	la $a0, nl			#gibt Stern aus
	la $v0, 4
	syscall	
	addi $t0, $t0, 1
	j Zeile
endZeile:

	li $v0, 10		#Exitroutine
	syscall
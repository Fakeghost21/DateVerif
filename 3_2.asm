ASSUME cs:text_,ds:data_

data_ SEGMENT

luni db 'Luni$'
marti db 'Marti$'
miercuri db 'Miercuri$'
joi db 'Joi$'
vineri db 'Vineri$'
sambata db 'Sambata$'
duminica db 'Duminica$'
LinieNoua db 10,13,'$'
dayOfTheWeek db ?
year dw ?
cifra db 10
cifra2 db 100

data_ ENDS

text_ SEGMENT

start:
mov ax, data_
mov ds, ax
; Evaluarea propriu-zisa a expresiei
mov ah, 2Ah     ; ziua lunii in dl,luna in dh si anul in cx,ziua saptamanii in al
int 21h         ;intreruperea de care tine

mov dayOfTheWeek,al

;-----------------------------Ziua------------------------------
mov al,dl
mov ah,0
idiv cifra   ; al catul(prima cifra),ah restul(ultima cifra)
mov bh,ah
add al,48   ; pentru a obtine caracterul ASCII al primei cifre
mov dl,al
mov ah,02h    ; print prima cifra din ziua lunii
int 21h

add bh,48
mov dl,bh
mov ah,02h    ; print a doua cifra din ziua lunii
int 21h

mov dl, '/'     ; print /
mov ah, 02h
int 21h

;-------------------------Luna-----------------------------
mov al,dh   ; luna in dh
mov ah,0
idiv cifra     ;   catul in al(prima cifra),iar restul in ah(ultima cifra)
mov bh,ah

add al,48
mov dl,al
mov ah,02h   ; print prima cifra a lunii
int 21h

add bh,48
mov dl,bh
mov ah,02h  ; print a doua cifra a lunii
int 21h

mov dl, '/'     ; print /
mov ah, 02h
int 21h

;-------------------------Anul-----------------------------
mov ax, cx
idiv cifra2   ;   ah restul(20),al catul(20)
mov bh,ah    ; bl = 20
mov ah,0
idiv cifra     ; al = 2,ah = 0
mov ch,ah;ch = 0
add al,48
mov dl,al
mov ah,02h
int 21h

add ch,48
mov dl,ch
mov ah,02h
int 21h

mov al,bh
mov ah,0
idiv cifra;al = 2,ah = 0
mov bh,ah;bh = 0
add al,48
mov dl,al
mov ah,02h
int 21h

add bh,48
mov dl,bh
mov ah,02h
int 21h

mov ah, 09h 
mov dx, offset LinieNoua 
int 21h 

cmp dayOfTheWeek,1
je l
jne m

l:
	mov ah, 09h 
	mov dx, offset luni 
	int 21h 
	jmp continua

m:
	cmp dayOfTheWeek,2
	je m_2
	jne Mier

m_2: 
	mov ah, 09h 
	mov dx, offset marti 
	int 21h 
	jmp continua

Mier: 
	cmp dayOfTheWeek,3
	je Mier_2
	jne J
	
Mier_2:
	mov ah, 09h 
	mov dx, offset miercuri 
	int 21h 
	jmp continua

J: 
	cmp dayOfTheWeek,4
	je J_2
	jne V
	
J_2:
	mov ah, 09h 
	mov dx, offset joi 
	int 21h 
	jmp continua
	
V: 
	cmp dayOfTheWeek,5
	je V_2
	jne S
	
V_2:
	mov ah, 09h 
	mov dx, offset vineri 
	int 21h 
	jmp continua
	
S: 
	cmp dayOfTheWeek,6
	je S_2
	jne D
	
S_2:
	mov ah, 09h 
	mov dx, offset sambata 
	int 21h 
	jmp continua

D:
	mov ah, 09h 
	mov dx, offset duminica 
	int 21h 	

continua:

mov ah, 4ch     ; For ending program with return code
int 21h  
text_ ENDS

END start
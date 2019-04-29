; Name: Anthony Chavez
; Course: CSC 35
; Semester: Spring 2019
; Instructor: Dr Ghansah
; Lab Day: Wednesday, 4-15-2019, 9:00AM
; Lab Section: 07
; Program Lab 6

; THIS PROGRAM takes in two 4 digit numbers and performs
; arithmetic on those number and outputs the result.
.model small
.stack 100h

.data
inputX db "InputX=",'$'
inputY db "InputY=",'$'
outputW db "OutputW=",'$' 
wMessage db "Calculating W",'$'
message db "Enter q if you wish to quit, otherwise press any key: ",'$'
nextLine db 0ah,0dh,"$"
X dw 0
Y dw 0
loc dw	0
W   dw	0
Sum dw	0
Count dw 0

.code
;---------------------------getInput method-----------------------------
getInput proc
; print message
mov ah,9h
mov dx,si
int 21h
; collect 4 digit number    
mov CX,4     ; Loop to collect 4 decimal digits
mov ax,0     ; zero out ax
top:         ; start of loop
mov ax,10    ; ax = 10
mul bx
mov bx,ax    ; X = ax
mov ah,1     
int 21h      ; read in single digit
sub al,30h   ; convert digit from ASCII to decimal
mov ah,0     ; zero out ah
add bx,ax    ; X += ax
loop top     ; end of loop
ret          ; return to caller
getInput ENDP

;----------------------------print nextLine-----------------------------
printNextLine proc
mov ah, 9h
mov dx, offset nextLine
int 21h
ret	     ; return to caller
printNextLine ENDP

;--------------------------Calculate W method---------------------------
calcW proc
; loc = Y * 160 + X * 2
mov ax, 160  ; ax = 160
mul di	     ; Y * 160
mov bx, ax   ; loc = Y * 160
mov ax, 2    ; ax = 2
mul si	     ; ax * x
add bx, ax   ; loc = ax
push bx      ; add loc to the stack

; Y = 1000
mov di, 1000

; Y = Y - 1
sub di, 1

; Sum = loc/16 + Y + Y/4 + Y/200
mov dx,0	    ; dx = 0
pop si
mov ax,si	    ; ax = loc, si = loc
mov cx,16	    ; cx = 16
div cx		    ; ax = loc / 16
mov bx,ax	    ; Sum = bx

mov ax,di	    ; ax = 999
add bx,ax	    ; Sum = Sum + 999

mov dx,0	    ; dx = 0
mov ax,di	    ; ax = 999
mov cx, 4	    ; cx = 4
div cx		    ; ax = Y / 4
add bx,ax	    ; Sum = Sum + Y / 4

mov dx,0	    ; dx = 0
mov ax,di
mov cx,200	    ; cx = 200
div cx		    ; ax = Y / 200
add bx,ax	    ; Sum = Sum + Y / 200
push bx         ; push bx to stack

; W = Sum % 7 + 5
mov dx,0	    ; dx = 0
mov bx,0        ; bx = 0
pop cx
mov ax,cx	    ; ax = sum
mov bx,7	    ; bx = 7
div bx
mov ax,dx	    ; W = dx
add ax,5 	    ; W = W + 5
ret
calcW ENDP

;----------------------------Print W method---------------------------
printW	proc
; print outputW
mov ah, 9h
mov dx, si
int 21h

mov ax,bx               ; ax = W
L1:
mov dx,0 
mov bx,10
div bx                  ; ax / 10
add dx,30h              ; convert to ASCII
push dx                 ; push converted remainder to stack
inc di                  ; increment count by 1
mov dx,0                ; zero remainder
cmp ax,0                ; check if quotient equals 0
    jne L1

mov cx,di               ; number of digit needed to pop off the stack
L2:
pop ax                  ; pop digit off the stack
mov dx,ax               
; DOS code for output or input
mov AH, 06h
Int 21h
loop L2
ret		                ; return to caller
printW ENDP
;---------------------------Main method-------------------------------
Main proc
Mov ax, @data
Mov ds, ax

Start:
mov X,0                 ; reset X
mov Y,0                 ; reset Y
mov W,0                 ; reset W
mov loc,0               ; reset loc
mov Sum,0               ; reset Sum

mov bx,X                ; pass X into bx
mov si,offset InputX    ; si = InputX string
call getInput
mov X,bx                ; store X
call printNextLine
mov bx,Y                ; pass Y into bx
mov si,offset InputY    ; si = InputY string
call getInput
mov Y,bx                ; store Y
call printNextLine
mov ah,9h      
mov dx,offset wMessage  ; dx = wMessage string
int 21h                 ; print wMessage string to screen
mov dx,0
mov ah,0
call printNextLine
mov si,X                ; pass X
mov di,Y                ; pass Y
call calcW              ; perform calculations for W
mov W,ax                ; store W
mov bx,W                ; pass W
mov di,Count            ; pass Count
mov dx,0                ; zero dx 
mov si,offset outputW   ; 
call printW             ; print W to the screen
call printNextLine
mov ah,9h
mov dx,offset message   ; print message to screen
int 21h
mov ax,0 
mov ah,1
int 21h
mov ah,0
cmp ax,71h              ; if user doesn't enter 'q', restart program
    call printNextLine
    JNE Start   
     
; exit
mov ax, 4c00h
Int 21h
Main endp
End main

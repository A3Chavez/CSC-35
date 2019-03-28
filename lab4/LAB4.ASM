; Name: Anthony Chavez
; Course: CSC 35
; Semester: Spring 2019
; Instructor: Dr Ghansah
; Lab Day: Wednesday, 3-6-2019, 9:00AM
; Lab Section: 07
; Program Lab 4

; THIS PROGRAM takes in two 4 digit numbers and performs
; arithmetic on those number and outputs the result.
.model small
.stack 100h

.data
inputX db "InputX=",'$'
inputY db "InputY=",'$'
outputW db "OutputW=",'$'
nextLine db 0ah,0dh,"$"
X dw 0
Y dw 0
loc dw	0
W   dw	0
Sum dw	0

.code
Main proc
Mov ax, @data
Mov ds, ax

; print Xinput
mov ah, 9h
mov dx, offset inputX
int 21h

; input X from the keyboard
mov CX,4     ; Loop to collect 4 decimal digits
mov ax,0
top:
mov ax,10    ; ax = 10
mul X	     ; ax * X
mov AH,1    ; Function to read a char from keyboard
int 21h      ; the char saved in AL
add X,ax
sub AL,30h
loop top
mov ah,0
mov X,ax     ; X = final ax digit

; print nextLine
mov ah, 9h
mov dx, offset nextLine
int 21h

; print Yinput
mov ah, 9h
mov dx, offset inputY
int 21h

; input Y from the keyboard
mov ax, 0    ; zero out ax
mov CX,4     ; Loop to collect 4 decimal digits
topY:
mov ax,10    ; ax * 10
mul Y	     ; ax * Y
mov AH,1    ; Function to read a char from keyboard
int 21h      ; the char saved in AL
add Y,ax
sub AL,30h
loop topY
mov ah,0
mov Y,ax     ; Y = final ax digit

; loc = Y * 160 + X * 2
mov ax,160	    ; ax = 160
mul Y		    ; Y * 160
mov loc,ax	    ; loc = Y * 160
mov ax,2	    ; ax = 2
mul X		    ; ax * X
add loc,ax	    ; loc = loc + (x*2)

; Y = 1000
mov Y, 1000

; Y = Y - 1
sub Y, 1

; Sum = loc / 16 + Y + Y / 4 + Y / 200
mov dx,0	    ; dx = 0
mov ax,loc	    ; ax = loc
mov cx,16	    ; cx = 16
div cx		    ; ax = loc / 16
mov loc,ax	    ; loc = ax
mov Sum,ax	    ; Sum = 245

mov ax,Y	    ; ax = 999
add Sum,ax	    ; Sum = Sum + 999

mov dx,0	    ; dx = 0
mov ax,Y	    ; ax = 999
mov cx, 4	    ; cx = 4
div cx		    ; ax = Y / 4
add Sum,ax	    ; Sum = Sum + Y / 4

mov dx,0	    ; dx = 0
mov ax,Y	    ; ax =
mov cx,200	    ; cx = 200
div cx		    ; ax = Y / 200
add Sum,ax	    ; Sum = Sum + Y / 200

; W = Sum % 7 + 5
mov dx,0	    ; dx = 0
mov ax,Sum	    ; ax = sum
mov bx,7	    ; bx = 7
div bx
mov W,dx	    ; W = dx
add W,5 	    ; W = W + 5

; print nextLine
mov ah, 9h
mov dx, offset nextLine
int 21h

; print outputW
mov ah, 9h
mov dx, offset outputW
int 21h

add W, 30h
mov dx,W
; DOS code for output or input
mov AH, 06h
Int 21h
; exit
mov ax, 4c00h
Int 21h
Main endp
End main

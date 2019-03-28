;Anthony Chavez
;CSC 35
;Spring 2019
;Dr Ghansah
;Wednesday, 2/20/19, 9:00am
;Lab section 07
;Program#4
;
;This program prints the number in variable 'W' on
;the screen in decimal form.
.model small
.stack 100h
.data
loc dw ?
X dw ?
Y dw ?
W dw ?
Sum dw ?
.code
Main proc
Mov ax, @data  ;set up data segment register
Mov ds,ax

;X = 40
mov X, 40

;Y = 24
mov Y, 24

;loc = Y * 160 + X * 2
mov ax, 160        ;ax = 160
mul Y              ;Y * 160
mov loc, ax        ;loc = Y * 160
mov ax, 2          ;ax = 2
mul x              ;ax * x
add loc, ax        ;loc = loc + (x*2)

;Y = 2000
mov Y, 2000

;Y = Y - 2000
sub Y, 1 

;Sum = (loc / 16) + Y + (Y / 4) + (Y / 200)
mov dx, 0	   ;dx = 0
mov ax, loc	   ;ax = loc , loc = 3920
mov cx, 16	   ;cx = 16
div cx		   ;ax = loc / 16
mov loc, ax	   ;loc = ax , ax = 245
mov Sum, ax	   ;Sum = 245

mov ax, Y	   ;ax = 1999
add Sum, ax	   ;Sum = 245 + 1999

mov dx, 0	   ;dx = 0
mov ax, Y	   ;ax = Y  , Y = 1999
mov cx, 4	   ;cx = 4
div cx		   ;ax = Y / 4
add Sum, ax	   ;Sum = 2244 + 499.75
mov Y, 1999	   ;Y = 1999

mov dx, 0	   ;dx = 0
mov ax, Y	   ;ax = 1999
mov cx, 200	   ;cx = 200
div cx		   ;ax = Y / 200
add Sum, ax	   ;Sum = 2743.75 + 9.995

;W = Sum % 7 + 5
mov dx, 0          ;dx = 0
mov ax, sum	   ;ax = sum
mov bx, 7          ;bx = 7
div bx
mov W, dx          ;W = dx
add W, 5           ;W = W + 5

add W, 30h
mov dx, W
;DOS code for ouput or input
mov ah, 06h
Int 21h
mov ax, 4c00h ;Exit
Int 21h
Main endp
     end main

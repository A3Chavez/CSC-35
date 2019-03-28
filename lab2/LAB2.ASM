;Anthony Chavez
;CSC 35
;Spring 2019
;Dr Ghansah
;Wednesday, 2/13/19, 9:00am
;Lab section 07
;Program#3
;
;This program performs basic arithmetic
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

Mov X, 40   ;X = 40
Mov Y, 24   ;Y = 24

mov ax, 160 ;ax = 160
mul Y ;Y * 160
mov loc, ax ;loc = Y * 160
mov ax, 2  ;ax = 2
mul x ;ax * x
add loc, ax  ;loc = loc + (x*2)

Mov Y, 2000 ;Y = 2000

sub Y, 1 ;Y= Y - 1

mov dx, 0 ;dx = 0
mov ax, loc ; ax = loc
mov cx, 4
div cx
mov loc, ax
mov Sum, ax  ;Sum = ax
mov ax, Y ;ax = Y
add Sum, ax ;Sum + ax

mov dx, 0 ;dx = 0
mov ax, sum ;ax = sum
mov bx, 7 ;bx = 7
div bx
mov W, dx ;W = dx
add W, 5 ;W = W + 5

;end
Mov ax, 4c00h	 ;exit to the operating system
Int 21h
Main endp
     End main

;Anthony Chavez
;CSC 35
;Semester
;Instructor: Dr Ghansah
;Wednesday, 2/6/19, 9:06
;Lab section 07
;Program 2
;
;This program displays "Hello CSC35 students".
.model small
.stack 100h
.data
message db "Hello CSC35 students", 0dh,0ah,0
	db "Anthony Chavez, CSC 35, Spring 2019****",'$'
.code
Main proc
    mov AX,@data
    mov DS,AX

    mov ah,9
    mov dx,offset message
    int 21h
    mov AX,4C00H
    int 21H
Main endp
    End main

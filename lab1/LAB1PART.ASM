;Anthony Chavez
;CSC 35
;Semester
;Instructor: Dr Ghansah
;Wednesday, 2/6/19, 9:06
;Lab section 07
;Program 2
;
;
.model small
.stack 100h
.data
.code
Main proc
    mov ax,@data   ;AX = 1C42
    mov ds, ax	   ;ds <= ax = 1C42
    mov ax,0FFFh   ;AX = 0FFF
    Add ax,1	   ;AX = 1000
    Neg ax	   ;AX = F000
    Add ax,2001h   ;AX = 1001
    mov bl, -1	   ;BX = 00FF
    Add al,bl	   ;AX = 1000
    mov ax,4C00h   ;AX = 4C00
    int 21h	   ;terminates the program
Main endp
    End main

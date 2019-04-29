; Course CSC 35
; Semester: Spring 2019
; Instructor: Dr Ghansah
; Lab Day: Wednesday, 4-29-2019, 9:00AM
; Lab Section: 07
; Program Lab 7

; This PROGRAM prompts the user to do several tasks and 
; the program outputs the results. 
;
; The program works as follows:
; 
; ** clear screen **
; "***********************************"
; "*    PROGRAM 5 TESTING PROCEDURE  *"
; "***********************************"   
; ** clear screen **
; ** clear screen ** 
; ReadChar: Type an ASCII character.....: // store in ax register
; ** clear screen **
; WriteChar: That character was.........: // print ax register
; ** clear screen **
; ** clear screen **
; ReadString: Type an ASCII String......: // read in string, store in buffer
; //only 9 character can be read in//
; ** clear screen **
; WriteDec: Number of Characters Typed..: // print ax register, contains # of chars read in
; ** clear screen **
; WriteString...........................: // print string in buffer
; ** clear screen **
; ** clear screen **
; ReadDec: Type a 16bit Decimal number..: // store in ax register
; ** clear screen **
; WriteDec: The Number was..............: // print ax register in decimal
; WriteBin: Printing a binary number....: // print ax register in binary
; ** clear screen **
; ** clear screen **
; ReadHex: Type a 16bit Hex number......: // store in ax register
; ** clear screen **
; WriteHex:The Number was...............: // print ax register in hex format

.model  small
.stack 100h

.data
TestString01	db  	"***********************************",0dh,0ah,

			    db      "*    PROGRAM 5 TESTING PROCEDURE  *",0dh,0ah,
                
			    db      "***********************************",0dh,0ah,0


TestString02	db  	"WriteBin: Printing a binary number....: ",0

TestString03	db  	"ReadChar: Type an ASCII character.....: ",0

TestString04	db  	"Writechar: That character was.........: ",0

TestString05	db  	"ReadString: Type an ASCII String......: ",0

TestString06	db  	"WriteString...........................: ",0

TestString07	db  	"ReadDec: Type a 16bit Decimal number..: ",0

TestString08	db  	"WriteDec: The Number was..............: ",0

TestString09	db  	"ReadHex: Type a 16bit Hex number......: ",0

TestString10	db  	"WriteHex:The Number was...............: ",0

TestString11	db  	"WriteDec: Number of Characters Typed..: ",0

Buffer		BYTE	10 DUP ('!')

.code
;------------------------------Part A-------------------------------------------- 

Crlf proc
; moves the cursor to a newline
    
    mov dl,10               ; dl = 10
    mov ah,02h              ; ah = 02h
    int 21h
    mov dl,13               ; dl = 13
    mov ah,02h              ; ah = 02h
    int 21h
    ret       
Crlf ENDP

WriteDec proc
; Write Decimal Digits to Screen
; Binary to ASCII 
; Integer in AX, Returns nothing
    
    mov cx,0
    L1:
        mov dx,0            ; zero out remainder
        mov bx,10           ; bx = 10
        div bx              ; ax / 10
        add dx,30h          ; convert to ASCII
        inc cx              ; inc count for popping elements later
        push dx             ; push to stack
        mov dx,0            ; zero out remainder
        cmp ax,0            ; check if quotient equals 0
            jne L1
            
    L2:
        pop ax              ; pop digit off the stack
        mov dx,ax           ; pass digit to be outputed
        mov ah,06h      
        int 21h
    loop L2
    ret                
WriteDec ENDP

WriteBin proc
; Writes Integer to screen(std output)
; in ASCII BINARY format. 
; Integer in AX
; Binary digits are displayed in groups
; of four for easy reading
         
    mov cx,0
    Calc:
        mov dx,0            ; zero out remainder
        mov bx,2            ; divisor bx = 2
        div bx              ; ax / 2
        add dx,30h          ; convert to ASCII
        inc cx              ; inc count for popping elements later
        push dx             ; push binary result onto stack
        cmp ax,0            ; check if quotient equals 0
            jne Calc   
          
    mov bx,0                ; track when to add a space          
    Print:                  ; top of Print loop                               
        pop ax              ; pop element off stack  
        inc bx
        mov dx,ax           ; pass to be outputed
        mov ah,06h
        int 21h             
        
        cmp bx,4            ; if 4 binary numbers outputed, add space
            je Space
               
    loop Print              ; end of Print loop
                             
    cmp cx,0                ; to jump over space label
        je Quit
    
    Space:
        mov bx,0
        mov dx,20h          ; load dx with ASCII code for space
        mov ah,06h
        int 21h
        dec cx              ; finish the loop in Print
        jmp Print           ; jump back to Print label
    
    Quit:
    ret
WriteBin ENDP

WriteChar proc
; Writes character to screen.
; Char in AL on entry
    
    mov ah,2
    mov dl,al
    int 21h
    ret
WriteChar ENDP

;------------------------------Part B-------------------------------------------- 

ClrScr proc         
; Scroll the whole screen window
; use coordinaes 0,0 to 24,79
; BIOS INT 10h function 06h

    mov ah,06h          ; scroll up
    mov al,0            ; entire window
    mov ch,0            ; upper left row
    mov cl,0            ; upper left col
    mov dh,24           ; lower right row
    mov dl,79           ; lower right col
    mov bh,7            ; attribute for blanked area
    int 10h             ; white: RGB = 111 = 7
    ret                  
ClrScr ENDP 

ReadChar proc
; Read single character from std
; input(keyboard).
; Char in AL on exit
    
    mov ah,1            ; read a single char
    int 21h
    mov ah,0            ; zero out ah
    ret        
ReadChar ENDP       

ReadString proc
; Read string from keyboard. 
; Entry DX = offset of bytes where 
;            data is stored. 
;       CX = max # of characters to 
;           be read. 
; Exit: count of bytes read in CX.
; Stops when user presses ENTER key(0dh) 

    mov si,dx               ; si = address of buffer
    mov bx,0                ; count of bytes read
    Read:                              
        mov ax,0            ; zero out ax
        call readChar       ; read character
        cmp al,0Dh          ; check if user hit enter key 
            JE Exit         ; if user hits enter, exit procedure
             
        mov [si],al         ; populate index with char in al                       
        inc si              ; point to next slot in buffer
        
        dec cx              ; decrement number of characters left that can be read
        inc bx              ; increment number of characters read in so far                                         
        
        cmp cx,0            ; check if anymore characters can be read
            JE Exit
        inc cx              ; consume for looping          
    Loop Read               ; if user doesn't hit enter continue reading
                      
    Exit:
    mov cx,bx               ; cx = # of chars read in
    mov [si],0              ; tell WriteString when to stop
    ret       
ReadString ENDP

WriteString proc
; Writes string to the screen.
; DX = Address of String
; returns nothing
    
    mov si,dx               ; si = address of String
    Write:   
        mov al,[si]         ; load char into al
        
        cmp al,0            ; check if string has terminated
            je END          ; if true, return to main
            
        inc si              ; inc si to point to the next char in string
        call writeChar      ; output char in al      
        
        jmp Write           ; loop again
    
    End: 
    ret
WriteString ENDP

;------------------------------Part C--------------------------------------------

ReadDec proc
; Read Decimal Digits from keyboard
; (ASCII to Binary).
; Up to 4 digits assumed
; Unsigned
         
    mov cx,4                 ; loop to collect 4 decimal digits
    mov ax,0                 ; zero out ax
    mov dx,0                 ; container to hold decimal digits
    top:                     ; start of loop
        mov ax,10            ; ax = 10
        mul dx               ; dx * ax
        mov dx,ax            
        mov ah,1
        int 21h              ; read in single digit
        sub al,30h           ; convert digit from ASCII to decimal
        mov ah,0             ; zero out ah
        add dx,ax            ; X += ax
    loop top                 ; end of loop
    mov ax,dx      
    ret                                   
ReadDec ENDP

ReadHex proc
; Read 16 bit hex integer from keyboard.
; Returns value in AX.
; Accepts both upper and lower case   
; Unsigned 

    mov cx,4                 ; loop to collect 4 hexadecimal digits
    mov ax,0                 ; zero out ax
    mov dx,0                 ; container to hold digits
    mov bx,0                 ; exponent container
    mov di,0                 ; container to hold result
    Collect:
        mov ax,16            ; ax = 16
        mov bx,cx            ; ax^bx , 16^exponent
        dec bx               ; decrement power
        jmp Exponent         ; get exponent value
        Continue:
            mov dx,ax        ; move exponent value
            mov ax,0           
            mov ah,1
            int 21h          ; read in single digit 
            mov ah,0         ; zero out ah
            jmp Convert      ; convert from ASCII
            Continue2:                  
                mul dx       ; digit read in * exponent, ax * dx 
                add di,ax    ; add to result container di
    loop Collect             ; end of loop
    
    mov ax,di                ; move result to ax
    jmp Finish
    
    Exponent: 
        cmp bx,3             ; 16^3
            mov ax,4096 
            je Continue
        cmp bx,2             ; 16^2
            mov ax,256
            je Continue
        cmp bx,1             ; 16^1
            mov ax,16
            je Continue
        cmp bx,0             ; 16^0
            mov ax,1
            je Continue                 
          
    Convert:
        ; convert capital letters 
        
        cmp ax,41h           
            je A
        cmp ax,42h
            je B
        cmp ax,43h     
            je C
        cmp ax,44h   
            je D
        cmp ax,45h     
            je E
        cmp ax,46h      
            je F
        
        ; convert lower case letters 
        
        cmp ax,61h     
            je A
         
        cmp ax,62h     
            je B
            
        cmp ax,63h     
            je C
            
        cmp ax,64h     
            je D
            
        cmp ax,65h      
            je E
            
        cmp ax,66h      
            je F         
         
        ; convert decimal numbers
        
        sub al,30h
            jmp Continue2
            
    A:
        mov ax,10            ; hexadecimal value of A
        jmp Continue2
        
    B:
        mov ax,11            ; hexadecimal value of B
        jmp Continue2
    C:
        mov ax,12            ; hexadecimal value of C
        jmp Continue2
    D:
        mov ax,13            ; hexadecimal value of D
        jmp Continue2
    E:
        mov ax,14            ; hexadecimal value of E
        jmp Continue2
    F:
        mov ax,15            ; hexadecimal value of F
        jmp Continue2    
    
          
    Finish:
    ret
ReadHex ENDP

WriteHex proc
; Writes 16 bit unsigned integer
; to screen in HEX Format (4 digits).
; Integer in AX on entry
            
    mov cx,0
    CalcHex:
        mov dx,0                ; zero out remainder
        mov bx,16               ; divisor bx = 16
        div bx                  ; ax / 16
        jmp Convert2            ; convert to ASCII
        Cont:
            inc cx              ; inc count for popping elements later
            push dx             ; push binary result onto stack
            cmp ax,0            ; check if quotient equals 0
                jne CalcHex     ; keep calculating, if quotient doesn't equal 0
            
    mov bx,cx                   ; move # elements to pop to bx
    jmp PrintZeroes
        
    Convert2:    
        ; convert letters
        
        cmp dx,10               
            je A2
        cmp dx,11
            je B2
        cmp dx,12     
            je C2
        cmp dx,13   
            je D2
        cmp dx,14     
            je E2
        cmp dx,15      
            je F2
        
        ; convert decimal numbers
        
        add dx,30h
        jmp Cont
            
    A2:
        mov dx,41h              ; hexadecimal value of A
        jmp Cont  
    B2:
        mov dx,42h              ; hexadecimal value of B
        jmp Cont
    C2:
        mov dx,43h              ; hexadecimal value of C
        jmp Cont
    D2:
        mov dx,44h              ; hexadecimal value of D
        jmp Cont
    E2:
        mov dx,45h              ; hexadecimal value of E
        jmp Cont
    F2:
        mov dx,46h              ; hexadecimal value of F
        jmp Cont
      
    PrintZeroes:  
        cmp cx,0                ; if # element need to pop = 0
            je PrintHex         ; jump to PrintHex label
               
        mov dx,30h              ; ASCII code for 0
        mov ah,06h
        int 21h                 ; print to screen
        dec bx                  ; decrement bx count 
        cmp bx,0                ; if bx doesn't = 0, repeat print zero
            jne PrintZeroes
           
                    
    PrintHex:                   ; top of Print loop                               
        pop ax                  ; pop element off stack  
        mov dx,ax               ; pass to be outputed
        mov ah,06h
        int 21h             
               
    loop PrintHex               ; end of Print loop
     
    Quit2:        
    ret
WriteHex ENDP

;------------------------------Main---------------------------------------------- 
Main proc
    mov ax,@data

    mov ds,ax
 
    call ClrScr				        ; Clear the Screen

    mov dx, offset TestString01		; First Large Prompt/Header

    call WriteString

    call Crlf
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    call Crlf

    mov dx, offset TestString03		; Prompt to Test ReadChar

    call WriteString;

    call ReadChar			        ; Reads Filtered Char into AL 
    
    push ax                         ; push char from ReadChar proc

    call Crlf

    mov dx, offset TestString04		; Prompt for WriteChar

    call WriteString
            
    pop ax                          ; restore char from ReadChar proc
            
    call WriteChar			        ; Writes ASCII char in AL to Screen

    call Crlf
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    call Crlf

    mov dx, offset TestString05		; Prompt for ReadString

    call WriteString

    mov dx, offset buffer		    ; Where to store the read-in-String

    mov cx, 9

    call ReadString			        ; Stores typed string to where DX points
    
    push cx                         ; number of chars read in

    call Crlf

    mov dx, offset TestString11		; Prompt for WriteDec, which will

    call WriteString			    ; print out the number of characters typed    
    
    pop ax                          ; pass number of chars read in from ReadString to WriteDec

    Call WriteDec

    Call Crlf

    mov dx, offset TestString06		; Print out the string that was entered

    call WriteString 			    ; uses DX register for source

    mov dx, offset buffer

    call WriteString

    call Crlf
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
    call Crlf

    mov dx, offset TestString07		; Prompt for ReadDec Test

    call WriteString;

    call ReadDec			        ; puts value in AX  
    
    push ax                         ; store decimal for binary display
    
    push ax                         ; store decimal for decimal display

    call Crlf

    mov dx, offset TestString08		; Prompt for WriteDec Test

    call WriteString;                
    
    pop ax                          ; pop stored decimal, pass to WriteDec
    
    call WriteDec			        ; Print AX register in Decimal

    call Crlf

    mov dx, offset TestString02		; Prompt for WriteBin test

    call WriteString; 
    
    pop ax                          ; pop stored decimal, pass to WriteBin

    call WriteBin			        ; Prints AX register in Binary

    call Crlf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    call Crlf

    mov dx, offset TestString09		; Prompt for READHEX

    call WriteString;

    call ReadHex                    ; Read in a hexadecimal, put value in AX
                
    push ax                         ; push hexadecimal to stack
                
    call Crlf

    mov dx, offset TestString10		; Prompt for WRITEHEX

    call WriteString;    
    
    pop ax                          ; pop hexadecimal value, pass to WriteHex for output to screen

    call WriteHex			        ; Prints AX register in Hexidecimal

         
    mov ax, 4c00h

    int 21h
 
; exit
mov ax,4C00h
int 21h 
main endp    
end main

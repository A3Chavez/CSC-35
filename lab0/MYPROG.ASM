; ANTHONY CHAVEZ
; CSC 35
; DR. GHANSAH
; 1/30/2019
; 0, 1/30/19 9:30
; LAB SECTION: 07
; PROGRAM 1
;-------------- Program starts here --------------

.model tiny ; data, code in single seg

.dosseg

.data

.code

.startup



main proc ; proc = procedure, an ASM installation

mov al, 9 ; al <-- 9

mov bl, 37 ; This is a Comment bl <-- 37

mov bh, 0 ; bh <-- 0

add bh, al ; bh <-- bh + al

add bh, bl ; bh <-- bh + bl

mov cx, 0 ; cx <-- 0

inc cx ; cx <-- cx + 1

dec cx ; cx <-- cx - 1

inc al ; al <-- al + 1

sub bl, al ; bl <-- bl - al

add bh, al ; bh <-- bh + al

add bh, cl ; bh <-- bh + cl

MOV AX,4C00h ; Exit to OS

INT 21h

main endp ; endp is an ASM instruction

end

;-------------------- Program ends here --------------------

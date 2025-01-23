[org 0x100]

jmp start
numofturns: dw 0
turn: db '1'

name: db 'MadeBy: Huzaifa Amir'
lname: dw 20

style1:db      ' ___________.__     ___________       __   ___________'            
style2:db      ' \__    ___/|__| ___\__    ___/____  |  | _\__    ___/___   ____'  
style3:db      '   |    |   |  |/ ___\|    |  \__  \ |  |/ / |    | /  _ \_/ __ \' 
style4:db      '   |    |   |  \  \___|    |   / __ \|    <  |    |(  <_> )  ___/' 
style5:db      '   |____|   |__|\___  >____|  (____  /__|_ \ |____| \____/ \___  >'
style6:db      '                    \/             \/     \/                   \/ '
ls1:dw 55
ls2:dw 64
ls3:dw 64
ls4:dw 65
ls5:dw 66
ls6:dw 66
stylei: db' ________'                       
stylej: db' /  _____/_____    _____   ____'  
stylek: db'/   \  ___\__  \  /     \_/ __ \' 
stylel: db'\    \_\  \/ __ \|  Y Y  \  ___/' 
stylem: db' \______  (____  /__|_|  /\___  >'
stylen: db'        \/     \/      \/     \/ '
ls7:dw 8
ls8:dw 31
ls9:dw 32
ls10:dw 32
ls11:dw 33
ls12:dw 33
message24:db 'CONGRATULATIONS PLAYER 1 YOU WON!'
length24: dw 33
message23:db 'CONGRATULATIONS PLAYER 0 YOU WON!'
length23: dw 33
message22:db 'GAME HAS BEEN DRAW !!!'
length22: dw 22
message21: db 'p', 0 ; 
length21: dw 1 ; length of the string
message20: db 'o', 0 ; 
length20: dw 1 ; length of the string
message19: db 'n', 0 ; 
length19: dw 1 ; length of the string
message18: db 'm', 0 ;
length18: dw 1 ; length of the string 
message17: db 'l', 0 ; 
length17: dw 1 ; length of the string
message16: db 'k', 0 ; 
length16: dw 1 ; length of the string
message15: db 'j', 0 ; 
length15: dw 1 ; length of the string
message14: db 'i', 0 ;
length14: dw 1 ; length of the string 
message13: db 'h', 0 ; 
length13: dw 1 ; length of the string
message12: db 'g', 0 ; 
length12: dw 1 ; length of the string
message11: db 'f', 0 ; 
length11: dw 1 ; length of the string
message10: db 'e', 0 ;
length10: dw 1 ; length of the string 
message9: db 'd', 0 ; 
length9: dw 1 ; length of the string
message8: db 'c', 0 ; 
length8: dw 1 ; length of the string
message7: db 'b', 0 ; 
length7: dw 1 ; length of the string
message6: db 'a', 0 ; 
length6: dw 1 ; length of the string
message5: db '                                                            ', 0 ; 
length5: dw 64 ; length of the string
message4: db '  ', 0 ; 
length4: dw 2 ; length of the string
message3: db '                                                                             ' 
length3: dw 80
message2: db 'The Game is just begain to Start--> Press any key to Enter in the game mode' 
length2: dw 75
message1: db '!!!Welcome to the Tic-Tac-Toe Game!!!' 
length1: dw 37
message: db '      ', 0 ; blank string to print a cell
length: dw 6 ; length of the string


print_string:
mov di,cx
mov al,byte[bp]
cmp al,0
jz khatam
stosw
add cx,2
inc bp
jmp print_string 
khatam:
ret

;;; Subroutine to clear the screen (Black Screen);;;
clrscr:
push es
push ax
push cx
push di
mov ax, 0xb800
mov es, ax 
xor di, di 
mov ax, 0x0720
mov cx, 2000 
cld 
rep stosw 
pop di
pop cx
pop ax
pop es
ret
;;; End of the clear code ;;;

;;; Subroutine to clear the screen (White Screen);;;
clrscr1:
push es
push ax
push cx
push di
mov ax, 0xb800
mov es, ax 
xor di, di 
mov ax, 0x7720
mov cx, 2000 
cld 
rep stosw 
pop di
pop cx
pop ax
pop es
ret
;;; End of the clear code ;;;

;;; Code to make a delay in the code ;;;
loop1:
mov ax,70
loop2:
mov bx,65535
anotherdelay:
dec bx
jnz anotherdelay
dec ax
jnz loop2
ret

delay:
call loop1
ret
;;; End of the Delay code ;;;


;;; Code for print Subroutine ;;;
printstr: 
push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov al, 80 ; load al with columns per row
mul byte [bp+10] ; multiply with y position
add ax, [bp+12] ; add x position
shl ax, 1 ; turn into byte offset
mov di,ax ; point di to required location
mov si, [bp+6] ; point si to string
mov cx, [bp+4] ; load length of string in cx
mov ah, [bp+8] ; load attribute in ah
cld ; auto increment modea

nextchar: lodsb ; load next char in al
stosw ; print char/attribute pair
loop nextchar ; repeat for the whole string
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 10
;;; End of the print subroutine ;;;
player0_win:
call clrscr
mov ax, 20
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x71 
push ax 
mov ax, message23
push ax 
push word [length23] 
call printstr 
mov ax,0x4c00
int 0x21


player1_win:
call clrscr
mov ax, 20
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x71 
push ax 
mov ax, message24
push ax 
push word [length24] 
call printstr 
mov ax,0x4c00
int 0x21

finish:
cmp byte[turn],'0'
je player1_win
jmp player0_win


terminate:
mov ax,0x4c00
int 0x21

check_rows:
push bp
mov bp,sp
pusha
mov di,[bp+4]
mov ax,0xb800
mov es,ax

mov ax,[es:di]
add di,36
mov bx,[es:di]
cmp ax,bx
jne continue
add di,36
mov cx,[es:di]
cmp bx,cx
jne continue
add di,36
mov dx,[es:di]
cmp cx,dx
jne continue

call delay
jmp finish

continue:
popa
pop bp
ret 2

check_cols:
push bp
mov bp,sp
pusha
mov di,[bp+4]
mov ax,0xb800
mov es,ax

mov ax,[es:di]
add di,800
mov bx,[es:di]
cmp ax,bx
jne continue1
add di,800
mov cx,[es:di]
cmp bx,cx
jne continue1
add di,800
mov dx,[es:di]
cmp cx,dx
jne continue1

call delay
jmp finish

continue1:
popa
pop bp
ret 2


check_dia_r:
push bp
mov bp,sp
pusha
mov di,[bp+4]
mov ax,0xb800
mov es,ax

mov ax,[es:di]
add di,836
mov bx,[es:di]
cmp ax,bx
jne continue2
add di,836
mov cx,[es:di]
cmp bx,cx
jne continue2
add di,836
mov dx,[es:di]
cmp cx,dx
jne continue2

call delay
jmp finish

continue2:
popa
pop bp
ret 2


check_dia_l:
push bp
mov bp,sp
pusha
mov di,[bp+4]
mov ax,0xb800
mov es,ax

mov ax,[es:di]
add di,764
mov bx,[es:di]
cmp ax,bx
jne continue3
add di,764
mov cx,[es:di]
cmp bx,cx
jne continue3
add di,764
mov dx,[es:di]
cmp cx,dx
jne continue3

call delay
jmp finish

continue3:
popa
pop bp
ret 2

getin:
 mov ah,0
 int 0x16
 cmp al,'a'
jne mov1
 
cmp byte[message6+1],0
jne getin
mov byte[message6+1],1
 mov ax,0xb800
 mov es,ax
 mov di,664
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne na
 mov byte[turn],'1'
 jmp sa
na:
 mov byte[turn],'0'
sa:
 add word[numofturns],1
mov ax,664
push ax
call check_rows
mov ax,664
push ax
call check_cols
mov ax,664
push ax
call check_dia_r
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov1:
cmp al,'b'
jne mov2

cmp byte[message7+1],0
jne getin
mov byte[message7+1],1
 mov ax,0xb800
 mov es,ax
 mov di,700
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nb
 mov byte[turn],'1'
 jmp sb
nb:
 mov byte[turn],'0'
sb:
 add word[numofturns],1
mov ax,664
push ax
call check_rows
mov ax,700
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov2:
 cmp al,'c'
 jne mov3

cmp byte[message8+1],0
jne getin
mov byte[message8+1],1
 mov ax,0xb800
 mov es,ax
 mov di,736
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nc
 mov byte[turn],'1'
 jmp sc
nc:
 mov byte[turn],'0'
sc:
 add word[numofturns],1
mov ax,664
push ax
call check_rows
mov ax,736
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov3:
cmp al,'d'
 jne mov4

cmp byte[message9+1],0
jne getin
mov byte[message9+1],1
 mov ax,0xb800
 mov es,ax
 mov di,772
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nd
 mov byte[turn],'1'
 jmp sd
nd:
 mov byte[turn],'0'
sd:
 add word[numofturns],1
mov ax,664
push ax
call check_rows
mov ax,772
push ax
call check_cols
mov ax,772
push ax
call check_dia_l
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov4:
cmp al,'e'
 jne mov5

cmp byte[message10+1],0
jne getin
mov byte[message10+1],1
 mov ax,0xb800
 mov es,ax
 mov di,1464
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne ne
 mov byte[turn],'1'
 jmp se
ne:
 mov byte[turn],'0'
se:
 add word[numofturns],1
mov ax,1464
push ax 
call check_rows
mov ax,664
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21



mov5:
cmp al,'f'
 jne mov6

cmp byte[message11+1],0
jne getin
mov byte[message11+1],1
 mov ax,0xb800
 mov es,ax
 mov di,1500
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nf
 mov byte[turn],'1'
 jmp sf
nf:
 mov byte[turn],'0'
sf:
 add word[numofturns],1
mov ax,1464
push ax 
call check_rows
mov ax,700
push ax
call check_cols
mov ax,664
push ax
call check_dia_r
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov6:
cmp al,'g'
 jne mov7

cmp byte[message12+1],0
jne getin
mov byte[message12+1],1
 mov ax,0xb800
 mov es,ax
 mov di,1536
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne ng
 mov byte[turn],'1'
 jmp sg
ng:
 mov byte[turn],'0'
sg:
 add word[numofturns],1
mov ax,1464
push ax 
call check_rows
mov ax,736
push ax
call check_cols
mov ax,772
push ax
call check_dia_l
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov7:
cmp al,'h'
 jne mov8

cmp byte[message13+1],0
jne getin
mov byte[message13+1],1
 mov ax,0xb800
 mov es,ax
 mov di,1572
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nh
 mov byte[turn],'1'
 jmp sh
nh:
 mov byte[turn],'0'
sh:
add word[numofturns],1
mov ax,1464
push ax 
call check_rows
mov ax,772
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov8:
cmp al,'i'
 jne mov9

cmp byte[message14+1],0
jne getin
mov byte[message14+1],1
 mov ax,0xb800
 mov es,ax
 mov di,2264
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nii
 mov byte[turn],'1'
 jmp sii
nii:
 mov byte[turn],'0'
sii:
 add word[numofturns],1
mov bx,2264
push bx
call check_rows
mov ax,664
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov9:
cmp al,'j'
 jne mov10

cmp byte[message15+1],0
jne getin
mov byte[message15+1],1
 mov ax,0xb800
 mov es,ax
 mov di,2300
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nj
 mov byte[turn],'1'
 jmp sj
nj:
 mov byte[turn],'0'
sj:
 add word[numofturns],1
mov ax,2264
push ax
call check_rows
mov ax,700
push ax
call check_cols
mov ax,772
push ax
call check_dia_l
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov10:
cmp al,'k'
 jne mov11

cmp byte[message16+1],0
jne getin
mov byte[message16+1],1
 mov ax,0xb800
 mov es,ax
 mov di,2336
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nk
 mov byte[turn],'1'
 jmp sk
nk:
 mov byte[turn],'0'
sk:
 add word[numofturns],1
mov ax,2264
push ax
call check_rows
mov ax,736
push ax
call check_cols
mov ax,664
push ax
call check_dia_r
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov11:
cmp al,'l'
 jne mov12

cmp byte[message17+1],0
jne getin
mov byte[message17+1],1
 mov ax,0xb800
 mov es,ax
 mov di,2372
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nl
 mov byte[turn],'1'
 jmp sl
nl:
 mov byte[turn],'0'
sl:
 add word[numofturns],1
mov ax,2264
push ax
call check_rows
mov ax,772
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov12:
cmp al,'m'
 jne mov13

cmp byte[message18+1],0
jne getin
mov byte[message18+1],1
 mov ax,0xb800
 mov es,ax
 mov di,3064
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nm
 mov byte[turn],'1'
 jmp sm
nm:
 mov byte[turn],'0'
sm:
 add word[numofturns],1
mov ax,3064
push ax
call check_rows
mov ax,664
push ax
call check_cols
mov ax,772
push ax
call check_dia_l
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov13:
cmp al,'n'
 jne mov14

cmp byte[message19+1],0
jne getin
mov byte[message19+1],1
 mov ax,0xb800
 mov es,ax
 mov di,3100
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne nn
 mov byte[turn],'1'
 jmp sn
nn:
 mov byte[turn],'0'
sn:
 add word[numofturns],1
mov ax,3064
push ax
call check_rows
mov ax,700
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


mov14:
cmp al,'o'
jne mov15

cmp byte[message20+1],0
jne getin
mov byte[message20+1],1
 mov ax,0xb800
 mov es,ax
 mov di,3136
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne no
 mov byte[turn],'1'
 jmp so
no:
 mov byte[turn],'0'
so:
 add word[numofturns],1
mov ax,3064
push ax
call check_rows
mov ax,736
push ax
call check_cols
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21



mov15:
cmp al,'p'
jne getin

cmp byte[message21+1],0
jne getin
mov byte[message21+1],1
 mov ax,0xb800
 mov es,ax
 mov di,3172
 mov bx,[turn]
 mov word[es:di],bx
 cmp byte[turn],'0'
 jne n33
 mov byte[turn],'1'
 jmp s33
n33:
 mov byte[turn],'0'
s33:
 add word[numofturns],1
mov ax,3064
push ax
call check_rows
mov ax,772
push ax
call check_cols
mov ax,664
push ax
call check_dia_r
cmp word[numofturns],16
jne getin
call clrscr1
mov ax, 30
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x1C 
push ax 
mov ax, message22
push ax 
push word [length22] 
call printstr 
 mov ax,0x4c00
 int 0x21


start:

call clrscr ;; Black Screen
 

;;; Border Line ka liya ;;;
mov ax,0
push ax
mov bx,1
push bx
mov ax,0x27
push ax
mov ax,message3
push ax
push word[length3]
call printstr

mov ax,0
push ax
mov bx,24
push bx
mov ax,0x47
push ax
mov ax,message3
push ax
push word[length3]
call printstr

;; left and right ka liya ;;
mov cx,2
l11:
mov ax,0
push ax
mov bx,cx
push bx
mov ax,0x67
push ax
mov ax,message4
push ax
push word[length4]
call printstr

mov ax,78
push ax
mov bx,cx
push bx
mov ax,0x17
push ax
mov ax,message4
push ax
push word[length4]
call printstr
add cx,1
cmp cx,24
jne l11
;;; end of left and right ;;;

mov ax, 4
push ax ; push x position
mov ax, 3
push ax ; push y position
mov ax, 0x07 
push ax 
mov ax, name
push ax 
push word [lname] 
call printstr 

mov ax, 5
push ax ; push x position
mov ax, 5
push ax ; push y position
mov ax, 0x0C 
push ax 
mov ax, style1
push ax 
push word [ls1] 
call printstr 

mov ax, 5
push ax ; push x position
mov ax, 6
push ax ; push y position
mov ax, 0x09 
push ax 
mov ax, style2
push ax 
push word [ls2] 
call printstr

mov ax, 5
push ax ; push x position
mov ax, 7
push ax ; push y position
mov ax, 0x03 
push ax 
mov ax, style3
push ax 
push word [ls3] 
call printstr

mov ax, 5
push ax ; push x position
mov ax, 8
push ax ; push y position
mov ax, 0x04 
push ax 
mov ax, style4
push ax 
push word [ls4] 
call printstr

mov ax, 5
push ax ; push x position
mov ax, 9
push ax ; push y position
mov ax, 0x02 
push ax 
mov ax, style5
push ax 
push word [ls5] 
call printstr

mov ax, 5
push ax ; push x position
mov ax, 10
push ax ; push y position
mov ax, 0x01 
push ax 
mov ax, style6
push ax 
push word [ls6] 
call printstr


mov ax, 18
push ax ; push x position
mov ax, 12
push ax ; push y position
mov ax, 0x0C 
push ax 
mov ax, stylei
push ax 
push word [ls7] 
call printstr


mov ax, 18
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x0B 
push ax 
mov ax, stylej
push ax 
push word [ls8] 
call printstr


mov ax, 18
push ax ; push x position
mov ax, 14
push ax ; push y position
mov ax, 0x02 
push ax 
mov ax, stylek
push ax 
push word [ls9] 
call printstr


mov ax, 18
push ax ; push x position
mov ax, 15
push ax ; push y position
mov ax, 0x03 
push ax 
mov ax, stylel
push ax 
push word [ls10] 
call printstr


mov ax, 18
push ax ; push x position
mov ax, 16
push ax ; push y position
mov ax, 0x04 
push ax 
mov ax, stylem
push ax 
push word [ls11] 
call printstr

mov ax, 18
push ax ; push x position
mov ax, 17
push ax ; push y position
mov ax, 0x07 
push ax 
mov ax, stylen
push ax 
push word [ls12] 
call printstr


mov ax, 3
push ax ; push x position
mov ax, 20
push ax ; push y position
mov ax, 0x0C 
push ax 
mov ax, message2
push ax 
push word [length2] 
call printstr ;; For Game begin to start ;;

mov ah,0
int 0x16
call clrscr1 ;; White Screen

;;; Now Printing of boxes we on Screen;;;
;;; First row boxes ka liya ;;;
;;; Ayak daba ka liya 2 baar subroutine iss liya call ki kuee ka col ki length 2 rakhi thi ;;
mov ax,10 ; x coordinate
push ax
mov bx,4 ; y coordinate
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr  ;; Boxes print karna ka lia print screen call ;;
mov ax,10
push ax
mov bx,5
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,28
push ax
mov bx,4
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,28
push ax
mov bx,5
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,46
push ax
mov bx,4
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,46
push ax
mov bx,5
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr


mov ax,64
push ax
mov bx,4
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,64
push ax
mov bx,5
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
;;; End of the first row boxes ;;;

;;; second row boxes ka liya ;;;
;;; Ayak daba ka liya 2 baar subroutine iss liya call ki kuee ka col ki length 2 rakhi thi ;;
mov ax,10
push ax
mov bx,9
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,10
push ax
mov bx,10
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,28
push ax
mov bx,9
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,28
push ax
mov bx,10
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,46
push ax
mov bx,9
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,46
push ax
mov bx,10
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr


mov ax,64
push ax
mov bx,9
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,64
push ax
mov bx,10
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
;;; End of the second row boxes ;;;

;;; Third row boxes ka liya ;;;
;;; Ayak daba ka liya 2 baar subroutine iss liya call ki kuee ka col ki length 2 rakhi thi ;;
mov ax,10
push ax
mov bx,14
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,10
push ax
mov bx,15
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,28
push ax
mov bx,14
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,28
push ax
mov bx,15
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,46
push ax
mov bx,14
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,46
push ax
mov bx,15
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr


mov ax,64
push ax
mov bx,14
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,64
push ax
mov bx,15
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
;;; End of the third row boxes ;;;


;;; Forth row boxes ka liya ;;;
;;; Ayak daba ka liya 2 baar subroutine iss liya call ki kuee ka col ki length 2 rakhi thi ;;
mov ax,10
push ax
mov bx,19
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]

call printstr
mov ax,10
push ax
mov bx,20
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,28
push ax
mov bx,19
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
mov ax,28
push ax
mov bx,20
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,46
push ax
mov bx,19
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]

call printstr
mov ax,46
push ax
mov bx,20
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr


mov ax,64
push ax
mov bx,19
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr

mov ax,64
push ax
mov bx,20
push bx
mov ax,0x34
push ax
mov ax,message
push ax
push word[length]
call printstr
;;; End of the Forth row boxes ;;;

;;; Border Line ka liya ;;;
mov ax,0
push ax
mov bx,1
push bx
mov ax,0x47
push ax
mov ax,message3
push ax
push word[length3]
call printstr

mov ax,0
push ax
mov bx,24
push bx
mov ax,0x27
push ax
mov ax,message3
push ax
push word[length3]
call printstr

;; left and right ka liya ;;
mov cx,2
l:
mov ax,0
push ax
mov bx,cx
push bx
mov ax,0x17
push ax
mov ax,message4
push ax
push word[length4]
call printstr

mov ax,78
push ax
mov bx,cx
push bx
mov ax,0x67
push ax
mov ax,message4
push ax
push word[length4]
call printstr
add cx,1
cmp cx,24
jne l
;;; end of left and right ;;;

;;; boxes ka border ;;;
mov ax,8 ; x coordinate
push ax
mov bx,3 ; y coordinate
push bx
mov ax,0x07
push ax
mov ax,message5
push ax
push word[length5]
call printstr
mov ax,8 ; x coordinate
push ax
mov bx,21 ; y coordinate
push bx
mov ax,0x07
push ax
mov ax,message5
push ax
push word[length5]
call printstr

;;; boxes ka left right border ;;;
mov cx,4
l1:
mov ax,8
push ax
mov bx,cx
push bx
mov ax,0x07
push ax
mov ax,message4
push ax
push word[length4]
call printstr

mov ax,70
push ax
mov bx,cx
push bx
mov ax,0x07
push ax
mov ax,message4
push ax
push word[length4]
call printstr
add cx,1
cmp cx,21
jne l1
;;; end of boxes border ;;

;;; alphbets rakhwana ka liya ;;;

mov ax,12
push ax
mov bx,4
push bx
mov ax,0x30
push ax
mov ax,message6
push ax
push word[length6]
call printstr



;;; b;;
mov ax,30
push ax
mov bx,4
push bx
mov ax,0x30
push ax
mov ax,message7
push ax
push word[length7]
call printstr

;;; c;;;
mov ax,48
push ax
mov bx,4
push bx
mov ax,0x30
push ax
mov ax,message8
push ax
push word[length8]
call printstr
;;; d;;;
mov ax,66
push ax
mov bx,4
push bx
mov ax,0x30
push ax
mov ax,message9
push ax
push word[length9]
call printstr

;;;e;;;
mov ax,12 ; x coordinate
push ax
mov bx,9 ; y coordinate
push bx
mov ax,0x30
push ax
mov ax,message10
push ax
push word[length10]
call printstr

mov ax,30
push ax
mov bx,9
push bx
mov ax,0x30
push ax
mov ax,message11
push ax
push word[length11]
call printstr

mov ax,48
push ax
mov bx,9
push bx
mov ax,0x30
push ax
mov ax,message12
push ax
push word[length12]
call printstr

mov ax,66
push ax
mov bx,9
push bx
mov ax,0x30
push ax
mov ax,message13
push ax
push word[length13]
call printstr


mov ax,12 ; x coordinate
push ax
mov bx,14 ; y coordinate
push bx
mov ax,0x30
push ax
mov ax,message14
push ax
push word[length14]
call printstr

mov ax,30
push ax
mov bx,14
push bx
mov ax,0x30
push ax
mov ax,message15
push ax
push word[length15]
call printstr

mov ax,48
push ax
mov bx,14
push bx
mov ax,0x30
push ax
mov ax,message16
push ax
push word[length16]
call printstr

mov ax,66
push ax
mov bx,14
push bx
mov ax,0x30
push ax
mov ax,message17
push ax
push word[length17]
call printstr



mov ax,12 ; x coordinate
push ax
mov bx,19 ; y coordinate
push bx
mov ax,0x30
push ax
mov ax,message18
push ax
push word[length18]
call printstr

mov ax,30
push ax
mov bx,19
push bx
mov ax,0x30
push ax
mov ax,message19
push ax
push word[length19]
call printstr

mov ax,48
push ax
mov bx,19
push bx
mov ax,0x30
push ax
mov ax,message20
push ax
push word[length20]
call printstr

mov ax,66
push ax
mov bx,19
push bx
mov ax,0x30
push ax
mov ax,message21
push ax
push word[length21]
call printstr
;;; End of by alphabets ki values rakhwana wla scene ;;;

call getin

End:
mov ax, 0x4c00
int 0x21

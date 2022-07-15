format PE console
entry start


include 'win32a.inc'

section '.text' code executable
start:
        stdcall [GetSystemTime],Time
        mov eax,0
        mov ax, [Time.wSecond]
        mov [seed],eax

        mov ax,0
        call rand
        mov edx,0
        div [limit]
        inc dl
        mov [number1],dl
        L:
        call rand
        mov edx,0
        div [limit]
        inc dl
        cmp dl,[number1]
        je L
        mov [number2],dl

        L1:
        call rand
        mov edx,0
        div [limit]
        inc dl
        cmp dl,[number1]
        je L1
        cmp dl,[number2]
        je L1
        mov [number3],dl

        L2:
        call rand
        mov edx,0
        div [limit]
        inc dl
        cmp dl,[number1]
        je L2
        cmp dl,[number2]
        je L2
        cmp dl,[number3]
        je L2
        mov [number4],dl

        push h1
        call [printf]

        mov al,[number1]
        cmp al,10
        jne L10
        push for10
        jmp L11
        L10:
        add al,48
        mov [out1],al
        push out1
        L11:
        call [printf]

        mov al,[number2]
        cmp al,10
        jne L12
        push for10
        jmp L13
        L12:
        add al,48
        mov [out1],al
        push out1
        L13:
        call [printf]


        mov al,[number3]
        cmp al,10
        jne L14
        push for10
        jmp L15
        L14:
        add al,48
        mov [out1],al
        push out1
        L15:
        call [printf]


        mov al,[number4]
        cmp al,10
        jne L17
        push for10
        jmp L16
        L17:
        add al,48
        mov [out1],al
        push out1
        L16:
        call [printf]



        call rand
        mov edx,0
        div [limit]
        inc dl
        cmp dl,1
        jne L6
        push M1
        call [printf]
        call [Sleep]
        ret
        L6:

        cmp dl,2
        jne L3
        push M2
        call [printf]
        call [Sleep]
        ret
        L3:

        cmp dl,3
        jne L4
        push M3
        call [printf]
        call [Sleep]
        ret
        L4:

        cmp dl,4
        jne L5
        push M4
        call [printf]
        call [Sleep]
        ret
        L5:
        push M5
        call [printf]
        call [Sleep]
        ret
rand:
      mov   eax, 343FDh
      imul  [seed]
      add   eax, 269EC3h
      mov   [seed], eax
      ror   eax,8
      ret


section '.idata' data readable writeable

        out1 db ' ',10,0
        for10 db '10',10,0
        limit dd 10
        h1 db 'Here are four distinct (not duplicate) random numbers', 10, 0
        M1 db '"Negative Thinking Is As Importnt As Creative Thinking Coz If Creative Thinking Invents Aeroplane Den Negative Thinking Invents Parachute."' ,10,0
        M2 db '"No one is perfect - that is why pencils have erasers."',10,0
        M3 db 'Never give up your dreams, if you are already half way and then you have many difficulties get over them. Only with your studies you will feel fulfilled.'     ,10,0
        M4 db '"Success is not final; failure is not fatal: It is the courage to continue that counts."'          ,10,0
        M5 db '"Success usually comes to those who are too busy looking for it."'            ,10,0
        number1 db 0
        number2 db 0
        number3 db 0
        number4 db 0
        Time SYSTEMTIME
        seed dd 0

section '.idata' data readable import
       library kernel32, 'kernel32.dll', \
                msvcrt,   'msvcrt.dll' ,\
                crtdll, 'CRTDLL.DLL'
        import kernel32, ExitProcess, 'ExitProcess',Sleep,'Sleep',GetSystemTime, 'GetSystemTime'
        import msvcrt, printf, 'printf'

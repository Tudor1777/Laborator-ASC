.data
    m: .space 4       
    n: .space 4       
    p: .space 4       
    k: .space 4      
    l: .space 4
    c: .space 4
    lin: .space 4
    col: .space 4
    i: .space 4
    j: .space 4
    lineIndex: .space 4
    columnIndex: .space 4
    vecini_vii: .space 4
    vecini_morti: .space 4
    format: .asciz "%d"
    formatAfisare: .asciz "%d "
    newline: .asciz "\n"
    matrix: .space 1600
    read: .asciz "r"
    write: .asciz "w"
    nume_fisier_input: .asciz "in.txt"
    nume_fisier_output: .asciz "out.txt"
    f_in: .space 8   
    f_out: .space 8  
   
.text
 
.global main

main:
    //open fisier intrare
    pushl $read
    pushl $nume_fisier_input
    call fopen
    movl %eax, f_in
    popl %ebx
    popl %ebx

    //open fisier iesire
    pushl $write
    pushl $nume_fisier_output
    call fopen
    movl %eax, f_out
    popl %ebx
    popl %ebx 

    pushl $m
    pushl $format
    pushl f_in
    call fscanf
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $n
    pushl $format
    pushl f_in
    call fscanf
    popl %ebx
    popl %ebx
    popl %ebx

    addl $2, m
    addl $2, n

    pushl $p
    pushl $format
    pushl f_in
    call fscanf
    popl %ebx
    popl %ebx
    popl %ebx

    lea matrix, %edi

    movl $0, i

for_citire_celule:

    movl i, %ecx
    cmp %ecx, p
    je continuare

    pushl $l
    pushl $format
    pushl f_in
    call fscanf
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $c
    pushl $format
    pushl f_in
    call fscanf
    popl %ebx
    popl %ebx
    popl %ebx

    addl $1, l
    addl $1, c

    movl l, %eax
    mull n
    addl c, %eax

    movl $1, (%edi, %eax, 4)

    addl $1, i
    jmp for_citire_celule

continuare:
    pushl $k
    pushl $format
    pushl f_in
    call fscanf
    popl %ebx
    popl %ebx
    popl %ebx

    movl $0, j
    
for_evolutii:

    movl j, %ecx
    cmp %ecx, k
    je continuare2

    movl $1, lineIndex
    for_lines:
        movl lineIndex, %ecx
        addl $1, %ecx
        cmp %ecx, m
        je cont_for_evolutii

        movl $1, columnIndex
        for_columns:
            movl columnIndex, %ecx
            addl $1, %ecx
            cmp %ecx, n
            je cont_for_lines

            movl lineIndex, %eax
            mull n
            addl columnIndex, %eax

            movl (%edi, %eax, 4), %ebx

            movl $0, vecini_morti
            movl $0, vecini_vii

            if_viu_mort:
                cmp $1, %ebx
                je viu
            mort:
                if_vecin_stanga_sus:
                    //pun vecinul in ecx
                    movl lineIndex, %edx
                    movl %edx, lin
                    movl columnIndex, %edx
                    movl %edx, col
                    subl $1, lin
                    subl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp  $1, %ecx
                    je vecin_viu_stanga_sus
                    cmp $0, %ecx
                    je vecin_mort_stanga_sus
                    cmp $2, %ecx
                    je vecin_mort_stanga_sus
                    cmp $3, %ecx
                    je vecin_viu_stanga_sus
                    vecin_mort_stanga_sus:
                        addl $1, vecini_morti
                        jmp if_vecin_sus
                    vecin_viu_stanga_sus:
                        addl $1, vecini_vii

                if_vecin_sus:
                    addl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_sus
                    cmp $0, %ecx
                    je vecin_mort_sus
                    cmp $2, %ecx
                    je vecin_mort_sus
                    cmp $3, %ecx
                    je vecin_viu_sus
                    vecin_mort_sus:
                        addl $1, vecini_morti
                        jmp if_vecin_dreapta_sus
                    vecin_viu_sus:
                        addl $1, vecini_vii

                if_vecin_dreapta_sus:
                    addl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_dreapta_sus
                    cmp $0, %ecx
                    je vecin_mort_dreapta_sus
                    cmp $2, %ecx
                    je vecin_mort_dreapta_sus
                    cmp $3, %ecx
                    je vecin_viu_dreapta_sus
                    vecin_mort_dreapta_sus:
                        addl $1, vecini_morti
                        jmp if_vecin_dreapta
                    vecin_viu_dreapta_sus:
                        addl $1, vecini_vii
                if_vecin_dreapta:
                    addl $1, lin
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_dreapta
                    cmp $0, %ecx
                    je vecin_mort_dreapta
                    cmp $2, %ecx
                    je vecin_mort_dreapta
                    cmp $3, %ecx
                    je vecin_viu_dreapta
                    vecin_mort_dreapta:
                        addl $1, vecini_morti
                        jmp if_vecin_dreapta_jos
                    vecin_viu_dreapta:
                        addl $1, vecini_vii

                if_vecin_dreapta_jos:
                    addl $1, lin
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_dreapta_jos
                    cmp $0, %ecx
                    je vecin_mort_dreapta_jos
                    cmp $2, %ecx
                    je vecin_mort_dreapta_jos
                    cmp $3, %ecx
                    je vecin_viu_dreapta_jos
                    vecin_mort_dreapta_jos:
                        addl $1, vecini_morti
                        jmp if_vecin_jos
                    vecin_viu_dreapta_jos:
                        addl $1, vecini_vii
                if_vecin_jos:
                    subl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_jos
                    cmp $0, %ecx
                    je vecin_mort_jos
                    cmp $2, %ecx
                    je vecin_mort_jos
                    cmp $3, %ecx
                    je vecin_viu_jos
                    vecin_mort_jos:
                        addl $1, vecini_morti
                        jmp if_vecin_stanga_jos
                    vecin_viu_jos:
                        addl $1, vecini_vii
                if_vecin_stanga_jos:
                    subl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_stanga_jos
                    cmp $0, %ecx
                    je vecin_mort_stanga_jos
                    cmp $2, %ecx
                    je vecin_mort_stanga_jos
                    cmp $3, %ecx
                    je vecin_viu_stanga_jos
                    vecin_mort_stanga_jos:
                        addl $1, vecini_morti
                        jmp if_vecin_stanga
                    vecin_viu_stanga_jos:
                        addl $1, vecini_vii
                if_vecin_stanga:
                    subl $1, lin
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_stanga
                    cmp $0, %ecx
                    je vecin_mort_stanga
                    cmp $2, %ecx
                    je vecin_mort_stanga
                    cmp $3, %ecx
                    je vecin_viu_stanga
                    vecin_mort_stanga:
                        addl $1, vecini_morti
                        jmp prelucrare_mort
                    vecin_viu_stanga:
                        addl $1, vecini_vii
                prelucrare_mort:
                    //daca are exact 3 vecinii vii, devine 2(invie generatia urmatoare)                   

                    addl $1, %eax

                    movl $3, %edx
                    cmp %edx, vecini_vii
                    jne cont_for_columns
                    movl $2, (%edi, %eax, 4)
                    jmp cont_for_columns
                    
            viu:
                if_vecin_stanga_sus2:
                    //pun vecinul in ecx
                    movl lineIndex, %edx
                    movl %edx, lin
                    movl columnIndex, %edx
                    movl %edx, col
                    subl $1, lin
                    subl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_stanga_sus2
                    cmp $0, %ecx
                    je vecin_mort_stanga_sus2
                    cmp $2, %ecx
                    je vecin_mort_stanga_sus2
                    cmp $3, %ecx
                    je vecin_viu_stanga_sus2
                    vecin_mort_stanga_sus2:
                        addl $1, vecini_morti
                        jmp if_vecin_sus2
                    vecin_viu_stanga_sus2:
                        addl $1, vecini_vii

                if_vecin_sus2:
                    addl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_sus2
                    cmp $0, %ecx
                    je vecin_mort_sus2
                    cmp $2, %ecx
                    je vecin_mort_sus2
                    cmp $3, %ecx
                    je vecin_viu_sus2
                    vecin_mort_sus2:
                        addl $1, vecini_morti
                        jmp if_vecin_dreapta_sus2
                    vecin_viu_sus2:
                        addl $1, vecini_vii

                if_vecin_dreapta_sus2:
                    addl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_dreapta_sus2
                    cmp $0, %ecx
                    je vecin_mort_dreapta_sus2
                    cmp $2, %ecx
                    je vecin_mort_dreapta_sus2
                    cmp $3, %ecx
                    je vecin_viu_dreapta_sus2
                    vecin_mort_dreapta_sus2:
                        addl $1, vecini_morti
                        jmp if_vecin_dreapta2
                    vecin_viu_dreapta_sus2:
                        addl $1, vecini_vii
                if_vecin_dreapta2:
                    addl $1, lin
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_dreapta2
                    cmp $0, %ecx
                    je vecin_mort_dreapta2
                    cmp $2, %ecx
                    je vecin_mort_dreapta2
                    cmp $3, %ecx
                    je vecin_viu_dreapta2
                    vecin_mort_dreapta2:
                        addl $1, vecini_morti
                        jmp if_vecin_dreapta_jos2
                    vecin_viu_dreapta2:
                        addl $1, vecini_vii

                if_vecin_dreapta_jos2:
                    addl $1, lin
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_dreapta_jos2
                    cmp $0, %ecx
                    je vecin_mort_dreapta_jos2
                    cmp $2, %ecx
                    je vecin_mort_dreapta_jos2
                    cmp $3, %ecx
                    je vecin_viu_dreapta_jos2
                    vecin_mort_dreapta_jos2:
                        addl $1, vecini_morti
                        jmp if_vecin_jos2
                    vecin_viu_dreapta_jos2:
                        addl $1, vecini_vii
                if_vecin_jos2:
                    subl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_jos2
                    cmp $0, %ecx
                    je vecin_mort_jos2
                    cmp $2, %ecx
                    je vecin_mort_jos2
                    cmp $3, %ecx
                    je vecin_viu_jos2
                    vecin_mort_jos2:
                        addl $1, vecini_morti
                        jmp if_vecin_stanga_jos2
                    vecin_viu_jos2:
                        addl $1, vecini_vii
                if_vecin_stanga_jos2:
                    subl $1, col
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_stanga_jos2
                    cmp $0, %ecx
                    je vecin_mort_stanga_jos2
                    cmp $2, %ecx
                    je vecin_mort_stanga_jos2
                    cmp $3, %ecx
                    je vecin_viu_stanga_jos2
                    vecin_mort_stanga_jos2:
                        addl $1, vecini_morti
                        jmp if_vecin_stanga2
                    vecin_viu_stanga_jos2:
                        addl $1, vecini_vii
                if_vecin_stanga2:
                    subl $1, lin
                    movl lin, %eax
                    mull n
                    addl col, %eax

                    movl (%edi, %eax, 4), %ecx

                    cmp $1, %ecx
                    je vecin_viu_stanga2
                    cmp $0, %ecx
                    je vecin_mort_stanga2
                    cmp $2, %ecx
                    je vecin_mort_stanga2
                    cmp $3, %ecx
                    je vecin_viu_stanga2
                    vecin_mort_stanga2:
                        addl $1, vecini_morti
                        jmp prelucrare_viu
                    vecin_viu_stanga2:
                        addl $1, vecini_vii
                prelucrare_viu:
                    //daca trebuie sa moara in generatia viitoare ii pun 3

                    addl $1, %eax

                    movl vecini_vii, %edx
                    cmp $2, %edx
                    je cont_for_columns
                    cmp $3, %edx
                    je cont_for_columns
                    movl $3, (%edi, %eax, 4)
    
        cont_for_columns:
            addl $1, columnIndex
            jmp for_columns

    cont_for_lines:

        addl $1, lineIndex
        jmp for_lines

cont_for_evolutii:
    //aici trebuie sa inlocuiesc 2 cu 1 si 3 cu 0

        movl $1, lin
        for_lines3:
            movl lin, %ecx
            cmp %ecx, m
            je continuare3

            movl $1, col
            for_columns3:
                movl col, %ecx
                cmp %ecx, n
                je cont_for_lines3

                movl lin, %eax
                mull n
                addl col, %eax

                movl (%edi, %eax, 4), %ebx
                cmp $2, %ebx
                jne et
                movl $1, (%edi, %eax, 4) 
                et:
                cmp $3, %ebx
                jne cont_for_columns3
                movl $0, (%edi, %eax, 4)

    cont_for_columns3:       
        addl $1, col
        jmp for_columns3

        cont_for_lines3:
   
            addl $1, lin
            jmp for_lines3
continuare3:

    addl $1, j
    jmp for_evolutii

continuare2:

//afisare
    movl $1, lineIndex

for_lines2:
    movl lineIndex, %ecx
    addl $1, %ecx
    cmp %ecx, m
    je inchidere_fisiere

    movl $1, columnIndex
    for_columns2:
        movl columnIndex, %ecx
        addl $1, %ecx
        cmp %ecx, n
        je cont_for_lines2

        movl lineIndex, %eax
        mull n
        addl columnIndex, %eax

        movl (%edi, %eax, 4), %ebx

        pushl %ebx
        pushl $formatAfisare
        pushl f_out
        call fprintf
        popl %ebx
        popl %ebx
        popl %ebx

        pushl $0
        call fflush
        popl %ebx

        addl $1, columnIndex
        jmp for_columns2

cont_for_lines2:
    pushl $newline
    pushl f_out
    call fprintf
    popl %ebx
    popl %ebx


    addl $1, lineIndex
    jmp for_lines2

    
inchidere_fisiere:

    pushl f_in
    call fclose
    popl %ebx

    pushl f_out
    call fclose
    popl %ebx

et_exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80

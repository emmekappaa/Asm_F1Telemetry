#MATRICOLE:
#ALEX GAIGA: VR471343
#MICHELE CIPRIANI: V3471337
#TOMMASO VILOTTO: VR471287

.section .data

id:
    .long 6
checkRigheTrovate:
    .long 0
countTempULTIMATOR:
    .long 0
valoreTemporaneo:
    .long 0
cifraTemporanea:
    .long 0
resto:
    .long 0
quoziente:
    .long 0
dieci:
    .long 10
contaCifre:
    .long 0
moltiplicatoreCifre:
    .long 1
#variabili dei record
rpmMax:
    .long 0
tempMax:
    .long 0
velMax:
    .long 0
contaVelocita:
    .long 0
velocitaMedia:
    .long 0
checkStampaUltimaRiga:
    .long 0
numeroCifre:
    .long 0
pointerFile:
    .long 0
#variabili dei dati del txt
megaTEMP:
    .ascii "00000000000000\n"
megaTEMP_len:
    .long . - megaTEMP
tempCOUNTER:
    .long 0
tempVariabileINT:
    .long 0
idDaStringa: #idPilota ma è int
    .long 0
countVelocitaSTR:
    .long 0
#queste variabili si aggiornano ad ogni riga
#che cicliamo con il giusto id
velocita:
    .long 0
rpm:
    .long 0
temperatura:
    .long 0
checkDoppio:
    .long 0
countTemp:
    .long 0    
contaPilota:
    .long 0
invalid:
    .ascii "Invalid\n\0"
etichettaHIGH:
    .ascii "HIGH"
etichettaMEDIUM:
    .ascii "MEDIUM"
etichettaLOW:
    .ascii "LOW"
spazio:
    .ascii " "    
numVirgola:
    .long 0
ck:
    .long 0
cifra:
    .long 0
numtmp: 
  .ascii "00000000000"     
virgola:
    .ascii ","
virgola_len:
    .long . - virgola
pilot_0_str:
    .string   "Pierre Gasly\0"
pilot_0_str_len:
    .long . - pilot_0_str
pilot_1_str:
    .string   "Charles Leclerc\0"
pilot_1_str_len:
    .long . - pilot_1_str
pilot_2_str:
    .string   "Max Verstappen\0"
pilot_2_str_len:
    .long . - pilot_2_str
pilot_3_str:                       
    .string   "Lando Norris\0"
pilot_3_str_len:
    .long . - pilot_3_str
pilot_4_str:
    .string   "Sebastian Vettel\0"
pilot_4_str_len:
    .long . - pilot_4_str
pilot_5_str:
    .string   "Daniel Ricciardo\0"
pilot_5_str_len:
    .long . - pilot_5_str
pilot_6_str: 
    .string   "Lance Stroll\0"
pilot_6_str_len:
    .long . - pilot_6_str
pilot_7_str:
    .string   "Carlos Sainz\0"
pilot_7_str_len:
    .long . - pilot_7_str
pilot_8_str:
    .string   "Antonio Giovinazzi\0"
pilot_8_str_len:
    .long . - pilot_8_str
pilot_9_str:
    .string   "Kevin Magnussen\0"
pilot_9_str_len:
    .long . - pilot_9_str
pilot_10_str:
    .string  "Alexander Albon\0"
pilot_10_str_len:
    .long . - pilot_10_str
pilot_11_str:
    .string  "Nicholas Latifi\0"
pilot_11_str_len:
    .long . - pilot_11_str
pilot_12_str:
    .string  "Lewis Hamilton\0"
pilot_12_str_len:
    .long . - pilot_12_str
pilot_13_str:
    .string  "Romain Grosjean\0"
pilot_13_str_len:
    .long . - pilot_13_str
pilot_14_str:
    .string  "George Russell\0"
pilot_14_str_len:
    .long . - pilot_14_str
pilot_15_str:
    .string  "Sergio Perez\0"
pilot_15_str_len:
    .long . - pilot_15_str
pilot_16_str:
    .string  "Daniil Rat\0"
pilot_16_str_len:
    .long . - pilot_16_str
pilot_17_str:
    .string  "Kimi Raikkonen\0"
pilot_17_str_len:
    .long . - pilot_17_str  
pilot_18_str:
    .string  "Esteban Ocon\0"
pilot_18_str_len:
    .long . - pilot_18_str
pilot_19_str:
    .string  "Waltteri Bottas\0"
pilot_19_str_len:
    .long . - pilot_19_str
invalid_pilot_str:	
.string "Invalid\0"
tempo1:
    .ascii "000000000000"   #ziopera no tappo
tempo1_len:
    .long . - tempo1  
.section .text
.global telemetry

telemetry:
movl 4(%esp), %esi  #per prendere lindirizzo della stringa in input (ESI PUNTA ALLA STRINGA SORGENTE)(PRIMO PARAMETRO cioe' puntatore a prima stringa)
movl 8(%esp), %edi  #per prendere l'indirizzo su cui andra' la stringa in output (EDI PUNTA ALLA STRINGA DESTINAZIONE)(SECONDO PARAMETRO cioe' puntatore a seconda stringa)
#salvo lo stato dei 4 registri prima di eventuali modifiche per ritrovarli cosi una volta finita la funzione
    pushl %eax  
    pushl %ebx
    pushl %ecx
    pushl %edx
    xorl %ecx, %ecx
    xorl %ebx, %ebx 
    xorl %ebx, %ebx 
    movb $1, %cl #è il famoso ck
    leal pilot_0_str, %edx 
for_0:
    cmp %ebx , pilot_0_str_len
    je ENDfor_0 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_0 
    incl %ebx
    jmp for_0 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_0:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_0
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_0
    cambiaCK_0:
         movb $0 ,%cl
         jmp checkCK_0
    checkCK_0:
    cmp $1, %ecx
    jne nextPilota_1
    movb $0, id #imposto id con il numero del pilota
    jmp FINEpiloti
nextPilota_1:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_1_str, %edx 
for_1:
    cmp %ebx , pilot_1_str_len
    je ENDfor_1 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_1 
    incl %ebx
    jmp for_1 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_1:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_1
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_1
    cambiaCK_1:
         movb $0 ,%cl
         jmp checkCK_1
    checkCK_1:
        cmp $1, %ecx
        jne nextPilota_2
        movb $1, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_2:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_2_str, %edx 
for_2:
    cmp %ebx , pilot_2_str_len
    je ENDfor_2 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_2 
    incl %ebx
    jmp for_2 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_2:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_2
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_2
    cambiaCK_2:
         movb $0 ,%cl
         jmp checkCK_2
    checkCK_2:
        cmp $1, %ecx
        jne nextPilota_3
        movb $2, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_3:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_3_str, %edx 
for_3:
    cmp %ebx , pilot_3_str_len
    je ENDfor_3 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_3
    incl %ebx
    jmp for_3 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_3:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_3
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_3
    cambiaCK_3:
         movb $0 ,%cl
         jmp checkCK_3
    checkCK_3:
        cmp $1, %ecx
        jne nextPilota_4
        movb $3, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_4:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_4_str, %edx 
for_4:
    cmp %ebx , pilot_4_str_len
    je ENDfor_4 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_4
    incl %ebx
    jmp for_4 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_4:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_4
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_4
    cambiaCK_4:
         movb $0 ,%cl
         jmp checkCK_4
    checkCK_4:
        cmp $1, %ecx
        jne nextPilota_5
        movb $4, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_5:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_5_str, %edx 
for_5:
    cmp %ebx , pilot_5_str_len
    je ENDfor_5 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_5
    incl %ebx
    jmp for_5 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_5:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_5
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_5
    cambiaCK_5:
         movb $0 ,%cl
         jmp checkCK_5
    checkCK_5:
        cmp $1, %ecx
        jne nextPilota_6
        movb $5, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_6:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_6_str, %edx 
for_6:
    cmp %ebx , pilot_6_str_len
    je ENDfor_6 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_6
    incl %ebx
    jmp for_6 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_6:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_6
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_6
    cambiaCK_6:
         movb $0 ,%cl
         jmp checkCK_6
    checkCK_6:
        cmp $1, %ecx
        jne nextPilota_7
        movb $6, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_7:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_7_str, %edx 
for_7:
    cmp %ebx , pilot_7_str_len
    je ENDfor_7 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_7
    incl %ebx
    jmp for_7 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_7:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_7
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_7
    cambiaCK_7:
         movb $0 ,%cl
         jmp checkCK_7
    checkCK_7:
        cmp $1, %ecx
        jne nextPilota_8
        movb $7, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_8:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_8_str, %edx 
for_8:
    cmp %ebx , pilot_8_str_len
    je ENDfor_8 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_8
    incl %ebx
    jmp for_8 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_8:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_8
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_8
    cambiaCK_8:
         movb $0 ,%cl
         jmp checkCK_8
    checkCK_8:
        cmp $1, %ecx
        jne nextPilota_9
        movb $8, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_9:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_9_str, %edx 
for_9:
    cmp %ebx , pilot_9_str_len
    je ENDfor_9 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_9
    incl %ebx
    jmp for_9 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_9:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_9
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_9
    cambiaCK_9:
         movb $0 ,%cl
         jmp checkCK_9
    checkCK_9:
        cmp $1, %ecx
        jne nextPilota_10
        movb $9, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_10:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_10_str, %edx 
for_10:
    cmp %ebx , pilot_10_str_len
    je ENDfor_10 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_10
    incl %ebx
    jmp for_10 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_10:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_10
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_10
    cambiaCK_10:
         movb $0 ,%cl
         jmp checkCK_10
    checkCK_10:
        cmp $1, %ecx
        jne nextPilota_11
        movb $10, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_11:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_11_str, %edx 
for_11:
    cmp %ebx , pilot_11_str_len
    je ENDfor_11 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_11
    incl %ebx
    jmp for_11 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_11:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_11
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_11
    cambiaCK_11:
         movb $0 ,%cl
         jmp checkCK_11
    checkCK_11:
        cmp $1, %ecx
        jne nextPilota_12
        movb $11, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_12:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_12_str, %edx 
for_12:
    cmp %ebx , pilot_12_str_len
    je ENDfor_12 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_12
    incl %ebx
    jmp for_12 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_12:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_12
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_12
    cambiaCK_12:
         movb $0 ,%cl
         jmp checkCK_12
    checkCK_12:
        cmp $1, %ecx
        jne nextPilota_13
        movb $12, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_13:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_13_str, %edx 
for_13:
    cmp %ebx , pilot_13_str_len
    je ENDfor_13 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_13
    incl %ebx
    jmp for_13 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_13:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_13
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_13
    cambiaCK_13:
         movb $0 ,%cl
         jmp checkCK_13
    checkCK_13:
        cmp $1, %ecx
        jne nextPilota_14
        movb $13, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_14:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_14_str, %edx 
for_14:
    cmp %ebx , pilot_14_str_len
    je ENDfor_14 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_14
    incl %ebx
    jmp for_14 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_14:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_14
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_14
    cambiaCK_14:
         movb $0 ,%cl
         jmp checkCK_14
    checkCK_14:
        cmp $1, %ecx
        jne nextPilota_15
        movb $14, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_15:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_15_str, %edx 
for_15:
    cmp %ebx , pilot_15_str_len
    je ENDfor_15 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_15
    incl %ebx
    jmp for_15 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_15:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_15
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_15
    cambiaCK_15:
         movb $0 ,%cl
         jmp checkCK_15
    checkCK_15:
        cmp $1, %ecx
        jne nextPilota_16
        movb $15, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_16:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_16_str, %edx 
for_16:
    cmp %ebx , pilot_16_str_len
    je ENDfor_16 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_16
    incl %ebx
    jmp for_16 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_16:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_16
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_16
    cambiaCK_16:
         movb $0 ,%cl
         jmp checkCK_16
    checkCK_16:
        cmp $1, %ecx
        jne nextPilota_17
        movb $16, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_17:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_17_str, %edx 
for_17:
    cmp %ebx , pilot_17_str_len
    je ENDfor_17 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_17
    incl %ebx
    jmp for_17 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_17:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_17
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_17
    cambiaCK_17:
         movb $0 ,%cl
         jmp checkCK_17
    checkCK_17:
        cmp $1, %ecx
        jne nextPilota_18
        movb $17, id #imposto id con il numero del pilota
        jmp FINEpiloti        
nextPilota_18:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck
leal pilot_18_str, %edx 
for_18:
    cmp %ebx , pilot_18_str_len
    je ENDfor_18 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_18
    incl %ebx
    jmp for_18 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_18:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_18
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_18
    cambiaCK_18:
         movb $0 ,%cl
         jmp checkCK_18
    checkCK_18:
        cmp $1, %ecx
        jne nextPilota_19
        movb $18, id #imposto id con il numero del pilota
        jmp FINEpiloti
nextPilota_19:
xorl %ecx, %ecx
xorl %ebx, %ebx
xorl %edx, %edx 
xorl %eax, %eax 
movb $1, %cl #è il famoso ck #resetto i contatori
leal pilot_19_str, %edx 
for_19:
    cmp %ebx , pilot_19_str_len
    je ENDfor_19 #se supero la lunghezza della variabile esco
    movb (%edx,%ebx), %al
    cmp (%esi,%ebx), %al
    jne ENDfor_19
    incl %ebx
    jmp for_19 #serve per ritornare a capo del for(cambiare carattere con il successivo della verifica)
ENDfor_19:
    movb (%esi,%ebx), %al
    cmp $10,%al #controllo "\n"
    jne cambiaCK_19
    movb (%edx,%ebx), %al
    cmp $0,%al #controllo "\0"
    je checkCK_19
    cambiaCK_19:
         movb $0 ,%cl
         jmp checkCK_19
    checkCK_19:
        cmp $1, %ecx
        jne pilotaERROR
        movb $19, id #imposto id con il numero del pilota
        jmp FINEpiloti
pilotaERROR:
    leal invalid, %ecx #dobbiamo gestire la casistica in cui non esista il pilota
    xorl %edx, %edx
    ciclo_lettura:
        movb (%ecx,%edx),%al  
        movb %al,(%edi,%edx) #edi rappresenta il file di uscita
        incl %edx
        cmp $0,%al
        jne ciclo_lettura  #se non vale zero torno su e leggo il carattere successivo
        jmp THE_END  
    FINEpiloti:
addb $48, id
xorl %ecx, %ecx #conto i caratteri del file
movb id, %al
jmp saltaCONTROLLOprime
idDoppioCheck:
    push %eax
    push %ebx
    xorl %eax,%eax
    movb (%esi,%ecx),%dl #prima cifra #ora in questo momento abbiamo in (esi ecx) il valore 1 della cifra
    subb $48, %dl #lo facciam diventare int
    addb %dl, %al
    movb $10,%bl
    mulb %bl #moltiplico per 10 così ho le decine
    #ora mi ricavo le unita
    movb 1(%esi,%ecx),%dl #seconda cifra
    subb $48, %dl #lo facciam diventare int
    addb %dl, %al
    movb %al, idDaStringa #spostiamo qui cosi lo riusiamo piu sotto
    pop %ebx
    pop %eax
    jmp ENDidDoppioCheck
saltaCONTROLLOprime:
    xorl %ebx,%ebx #contatore scrittura in fil
    xorl %ecx,%ecx
scraping: #ciclo i valori presi da input
    movb (%esi,%ecx),%dl 
    cmp $10,%dl #confronto il char con EOL(cioe dollaro 10 -- end of fil)
    jne notDataLine
   dataLines:
        cmp $10, %dl
        je endNESTING
        pushl %eax
        pushl %ebx
        pushl %ecx
        pushl %edx
        decl %ecx
        movb (%esi,%ecx),%dl  #controllo il valore precedente
        cmp $10, %dl
        jne FINE_reset_tempCount
        movl $0, countTemp #resetto countTemp se prima c'era uno sburo
        FINE_reset_tempCount:
        popl %edx
        popl %ecx
        popl %ebx
        popl %eax
        cmp $0, numVirgola  #nesting michele's code
        jne endNESTING
            pushl %eax
            pushl %ecx
            xorl %ecx,%ecx
            movl countTemp, %ecx
            leal tempo1, %eax
            movb %dl, (%eax,%ecx)
            incl countTemp
            popl %ecx
            popl %eax
        endNESTING:
         movb (%esi,%ecx),%dl
         cmp $44,%dl   
         je printaSpazio
            cmp $1, numVirgola   #controllo di essere nella virgola prima del dato id
            jne saltaSaltaDati  #controllo i dati del pilota
            movb 1(%esi,%ecx),%dl #contrllo che l'id abbia uno o due cifre
            cmp $44,%dl
            je unaVirgola
            cmp $44,%dl
            jne idDoppioCheck
            ENDidDoppioCheck: #ora se l'id ha due cifre ce lo abbiamo salvato in idDaStringa
            subb $48, id #andiamo a confrontarlo con id
            movb id, %al
            addb $48, id
            cmp idDaStringa, %eax
            je QUASIsaltaSaltaDati #se ho id uguale non salto i dati
            cmp $1,checkDoppio
            je saltaSaltaDati 
            cmp idDaStringa, %eax
            jne inizioSaltaDati
            unaVirgola:
                cmp $1,checkDoppio
                je saltaSaltaDati
                movb (%esi,%ecx),%dl
                cmp %dl,id
                je saltaSaltaDati #se ho id uguale non salto i dati
            inizioSaltaDati: #qui faccio il pezzetto saltadati
                incl %ecx
                movb (%esi,%ecx),%dl 
                cmp $0,%dl
                je ENDscraping
                cmp $10,%dl
                jne inizioSaltaDati
            ENDsaltaDati:   
                movb $0, numVirgola
            saltaSaltaDati: #STAMPA DATI 
                jmp ELABORAZIONEdati
            saltaStampaFile:        
            incl %ecx
            movb (%esi,%ecx),%dl   
            cmp $10,%dl   #arrivato in fondo %dl vale 0, checkato con gdb
            jne saltaReset #SE NON TROVA IL \N SALTA
            movb $0, numVirgola
            jmp printLevel
            saltaResetVirgola:
                movb $0, checkDoppio
                movb $0, checkStampaUltimaRiga
        saltaReset: 
        cmp $0, checkStampaUltimaRiga
        jne printLevel
        cmp $0,%dl     #se raggiunge il tappo, esce
        je ENDscraping 
        jmp dataLines
    ENDdatLines:
    notDataLine:
        incl %ecx
        movb (%esi,%ecx),%dl
        cmp $0,%dl
        jne scraping  #se non vale zero torno su e leggo il carattere successivo
ENDscraping:
jmp saltaSpazio
printaSpazio:
    incl numVirgola
    incl %ecx
    jmp dataLines
    jmp saltaSpazio
QUASIsaltaSaltaDati:
    movb $1, checkDoppio
    jmp saltaSaltaDati
    jmp saltaSpazio
ELABORAZIONEdati:
    push %eax
    push %ebx
    push %ecx
    push %edx
    cmp $0,numVirgola #DA QUI IN POI INIZIO A SPOSTARE I DATI
    je saltaStampaFile1
    cmp $1,numVirgola
    je saltaStampaFile1
    leal megaTEMP, %eax
    movb tempCOUNTER, %bl
        inizioForScraping:
        movb (%esi,%ecx),%dl
        movb %dl, (%eax,%ebx)
        movb 1(%esi,%ecx),%dl
        cmp $4,numVirgola
        je confrontoEOL
        cmp $44, %dl #se dopo si passa ad un altro parametro metto il tappo
        jne QUASIinizioForScraping
        incb %bl
        movb $64, (%eax,%ebx) #metto la chiocciola
        jmp saltaConfrontoEOL
        confrontoEOL:  #sezione per l'ultimo carattere dove controlliamo \0 e non a capo
            cmp $10, %dl #se dopo si passa ad un altro parametro metto il tappo
            jne QUASIinizioForScrapingEOL 
            incb %bl
            movb $64, (%eax,%ebx) #metto la chiocciola
        saltaConfrontoEOL:
        jmp END_QUASIinizioForScrapingEOL
        QUASIinizioForScrapingEOL:
            cmp $0,%dl #se salta qui perchè non è \n ma, è \0
            je endFile #allora salto qui
            incl %ecx
            incl %ebx
            jmp inizioForScraping
        END_QUASIinizioForScrapingEOL:
        jmp END_QUASIinizioForScraping
        endFile:
            incb %bl
            movb $64, (%eax,%ebx) #metto la chiocciola
        jmp END_QUASIinizioForScraping
        QUASIinizioForScraping:
            incl %ecx
            incl %ebx
            jmp inizioForScraping
        END_QUASIinizioForScraping:
        #ora devo prendere e convertire da ascii a intero
        #in %ebx  abbiamo la lunghezza del totale Numero prima della @
        #ora mi interessa: ebx lunghezza stringa
        xorl %eax, %eax #qui ci metto le potenze del 1
        xorl %ebx, %ebx
        push %ecx #ci serve come contatore piu sopra
        leal megaTEMP, %edx
        movl $0, %ebx
        xorl %eax, %eax
        xorl %ecx, %ecx
        cicloATOI:      
            movb (%edx,%ebx), %cl
            cmpb $64, %cl
            je ESCI_cicloATOI
            pushl %edx
            xorl %edx, %edx #devo resettare perchè divido a word
            mull dieci
            popl %edx
            subl $48,%ecx #aggiungo la cifra
            addl %ecx,%eax
            incl %ebx
            jmp cicloATOI
            ESCI_cicloATOI:
       pop %ecx
movl %eax, tempCOUNTER
movl tempCOUNTER, %ebx #carico preventivamente il dato intero in ebx
cmp $2,numVirgola #immagazino velocita
jne provaTerzaVirgola
movl %ebx, velocita
jmp saltaStampaFile1
provaTerzaVirgola:
    cmp $3,numVirgola #rpm
    jne provaQuartaVirgola
    movl %ebx, rpm
    jmp saltaStampaFile1
    jmp saltaStampaFile1
provaQuartaVirgola:
    cmp $4,numVirgola #temperatura
    movl %ebx, temperatura
    incl checkStampaUltimaRiga #perchè senno in caso ultima riga fosse utile non stampa
    jmp saltaStampaFile1
    saltaStampaFile1:
    movb $0, tempCOUNTER
    pop %edx
    pop %eax #butto via il valore di eax
    pop %ebx
    pop %eax
    jmp saltaStampaFile
END_ELABORAZIONEdati:
printLevel:
    push %eax
    push %ebx
    push %ecx
    push %edx
    incl checkRigheTrovate
    decl countTemp #qui ci entro ad ogni char
    stampoTempo: #ora ciclino che termina entro countTemp
        pushl %eax
        xorl %eax, %eax
        movl countTemp, %eax
        cmp countTempULTIMATOR, %eax
        je saltaAvirgola
        popl %eax
        pushl %eax
        pushl %ebx
        pushl %ecx
        pushl %edx
        leal tempo1, %ebx
        xorl %ecx, %ecx #resetto ecx perche infame
        xorl %eax, %eax #resetto eax perche infame
        xorl %edx, %edx 
        movl pointerFile, %ecx
        movl countTempULTIMATOR, %eax
        movb (%ebx,%eax), %dl
        movb  %dl,(%edi,%ecx)
        popl %edx
        popl %ecx 
        popl %ebx 
        popl %eax 
        incl countTempULTIMATOR 
        incl pointerFile #incremento il pointerFile
        jmp stampoTempo
saltaAvirgola:
    popl %eax #server perche se salta non lo pop di la
    movl $0, countTempULTIMATOR
    call stampaVirgola #stampo virgola
    movl $5000, %eax #controllo gli rpm
    cmp %eax, rpm  #LOW: rpm <= 5000, si legge da dx a sx, rpm<=%eax
    jle stampaLOW
    movl $10000, %eax
    cmp %eax, rpm  #HIGH: rpm > 10000
    jg stampaHIGH
    jmp stampaMEDIUM #se arriva qui è per forza  MEDIUM: 5000 < rpm <=10000
    jmp ENDsezioneSTAMPA
stampaHIGH:
            call FunzStampaHIGH
            jmp ENDsezioneSTAMPA
stampaMEDIUM:
            call FunzStampaMEDIUM
            jmp ENDsezioneSTAMPA    
stampaLOW:
            call FunzStampaLOW
            jmp ENDsezioneSTAMPA
ENDsezioneSTAMPA:
    call stampaVirgola
    movl $90, %eax   #controllo la temperatura
    cmp %eax, temperatura  # LOW: temperatura <= 90, si legge da dx a sx, rpm<=%eax
    jle stampaLOW_temp
    movl $110, %eax
    cmp %eax, temperatura  # HIGH: temperatura > 10000
    jg stampaHIGH_temp
    jmp stampaMEDIUM_temp # se arriva qui è per forza  MEDIUM: 5000 < rpm <=10000
    jmp ENDsezioneSTAMPA_temp
stampaHIGH_temp:
    call FunzStampaHIGH
    jmp ENDsezioneSTAMPA_temp
stampaMEDIUM_temp:
    call FunzStampaMEDIUM
    jmp ENDsezioneSTAMPA_temp
stampaLOW_temp:
    call FunzStampaLOW
    jmp ENDsezioneSTAMPA_temp
ENDsezioneSTAMPA_temp: 
    call stampaVirgola
movl $100, %eax #controllo la velocita
cmp %eax, velocita  #LOW: velocita <= 90, si legge da dx a sx, rpm<=%eax
jle stampaLOW_vel
movl $250, %eax
cmp %eax, velocita  #HIGH: velocita > 10000
jg stampaHIGH_vel
jmp stampaMEDIUM_vel #se arriva qui è per forza  MEDIUM: 5000 < rpm <=10000
jmp ENDsezioneSTAMPA_vel
stampaHIGH_vel:
    call FunzStampaHIGH
    jmp ENDsezioneSTAMPA_vel
stampaMEDIUM_vel:
    call FunzStampaMEDIUM
    jmp ENDsezioneSTAMPA_vel 
stampaLOW_vel:
    call FunzStampaLOW
    jmp ENDsezioneSTAMPA_vel
ENDsezioneSTAMPA_vel:
        pushl %eax #stampo a capo
        pushl %ebx
        pushl %ecx
        pushl %edx
        xorl %ecx, %ecx #resetto ecx perche infame
        movl pointerFile, %ecx
        movb  $10,(%edi,%ecx)
        popl %edx
        popl %ecx 
        popl %ebx 
        popl %eax 
        incl pointerFile #incrementiamo per il file
    push %eax #ora controllo <rpm max>,<temp max>,<velocità max>,<velocità media>
    xorl %eax, %eax
    movl rpm, %eax
    cmp %eax, rpmMax
    jg checkRECORD_temp
    movl %eax, rpmMax #salvo nuovo record
checkRECORD_temp:
    xorl %eax, %eax
    movl temperatura, %eax
    cmp %eax, tempMax
    jg sommaVelocità
    movl %eax, tempMax
sommaVelocità:
    xorl %eax, %eax
    movl velocita, %eax
    addl %eax,velocitaMedia
    cmp %eax, velMax
    jg fineComparazioni
    movl %eax, velMax
fineComparazioni:
    pop %eax
    incl contaVelocita
    pop %edx
    pop %ecx 
    pop %ebx
    pop %eax
    jmp saltaResetVirgola
END_printLevel:
saltaSpazio:
            cmp $0, checkRigheTrovate
            je THE_END
            pushl %eax # Calcolo la media delle velocità
            pushl %ebx
            xorl %edx, %edx
            movl velocitaMedia, %eax
            movl contaVelocita, %ebx
            divl %ebx 
            movl %eax, velocitaMedia
            popl %ebx
            popl %eax
            xorl %eax, %eax
            xorl %ebx, %ebx       
            xorl %ecx, %ecx
            xorl %edx, %edx
            movl rpmMax, %edx #rendo il programma unversale
            movl %edx, valoreTemporaneo
            xorl %edx, %edx
            movl valoreTemporaneo, %ebx #mi salvo rpm per dopo
            ciclomini:
            incl contaCifre
            movl valoreTemporaneo, %eax
            divl dieci
            movl %edx, resto
            movl %eax, quoziente
            pushl %eax
            movl moltiplicatoreCifre, %eax
            mull dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            movl %eax,valoreTemporaneo
            cmp $0, quoziente
            jne ciclomini
            movl %ebx, valoreTemporaneo  #ripristino rpm
            pushl %eax   #aggiustiamo il moltiplicatoreCifre
            xorl %eax, %eax
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            xorl %eax, %eax
            xorl %ebx, %ebx       
            xorl %ecx, %ecx
            xorl %edx, %edx
            intoFile:   #ci ricaviamo la cifra
            movl valoreTemporaneo, %eax 
            divl moltiplicatoreCifre
            movl %edx, valoreTemporaneo #il resto va in rpm (edx resto divisione coi long)
            movl %eax, cifraTemporanea #il quoziente va in cifraTemporanea
            addl $48, cifraTemporanea #cosi lo trasformo in ascii
            xorl %eax, %eax #adesso devo buttarlo nel file
            xorl %edx, %edx
            movl cifraTemporanea, %eax
            movl pointerFile, %edx
            movl %eax, (%edi,%edx)
            incl pointerFile
            xorl %eax, %eax  #ora faccio moltiplicatoreCifre \= 10
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre #prendiamo il quoziente della divisione per 10 e lo mettiamo in moltiplicatoreCifre
            cmp $0, moltiplicatoreCifre
            jne intoFile
            END_intoFile:
            call stampaVirgola
            movl $1, moltiplicatoreCifre
            movl $0, cifraTemporanea
            movl $0, valoreTemporaneo
            movl tempMax, %edx #rendo il programma unversale
            movl %edx, valoreTemporaneo
            xorl %edx, %edx
            movl valoreTemporaneo, %ebx #mi salvo rpm per dopo
            ciclomini_1:
            incl contaCifre
            movl valoreTemporaneo, %eax
            divl dieci
            movl %edx, resto
            movl %eax, quoziente
            pushl %eax
            movl moltiplicatoreCifre, %eax
            mull dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            movl %eax,valoreTemporaneo
            cmp $0, quoziente
            jne ciclomini_1
            movl %ebx, valoreTemporaneo  #ripristino rpm
            pushl %eax #aggiustiamo il moltiplicatoreCifre
            xorl %eax, %eax
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            xorl %eax, %eax #adesso andiamo a dividere per moltiplicatore, finche esso non vale 0
            xorl %ebx, %ebx       
            xorl %ecx, %ecx
            xorl %edx, %edx
            intoFile_1:  #ci ricaviamo la cifra
            movl valoreTemporaneo, %eax
            divl moltiplicatoreCifre
            movl %edx, valoreTemporaneo #il resto va in rpm (edx resto divisione coi long)
            movl %eax, cifraTemporanea #il quoziente va in cifraTemporanea
            addl $48, cifraTemporanea #cosi lo trasformo in ascii
            xorl %eax, %eax  #adesso devo buttarlo nel file
            xorl %edx, %edx
            movl cifraTemporanea, %eax
            movl pointerFile, %edx
            movl %eax, (%edi,%edx)
            incl pointerFile
            xorl %eax, %eax #ora faccio moltiplicatoreCifre \= 10
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre #prendiamo il quoziente della divisione per 10 e lo mettiamo in moltiplicatoreCifre
            cmp $0, moltiplicatoreCifre
            jne intoFile_1
            END_intoFile_1:
            call stampaVirgola
            movl $1, moltiplicatoreCifre #velocita massima stampa
            movl $0, cifraTemporanea
            movl $0, valoreTemporaneo
            movl velMax, %edx   #rendo il programma unversale
            movl %edx, valoreTemporaneo
            xorl %edx, %edx
            movl valoreTemporaneo, %ebx #mi salvo rpm per dopo
            ciclomini_2:
            incl contaCifre
            movl valoreTemporaneo, %eax
            divl dieci
            movl %edx, resto
            movl %eax, quoziente
            pushl %eax
            movl moltiplicatoreCifre, %eax
            mull dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            movl %eax,valoreTemporaneo
            cmp $0, quoziente
            jne ciclomini_2
            movl %ebx, valoreTemporaneo #ripristino rpm
            pushl %eax  #aggiustiamo il moltiplicatoreCifre
            xorl %eax, %eax
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            xorl %eax, %eax  #adesso andiamo a dividere per moltiplicatore, finche esso non vale 0
            xorl %ebx, %ebx       
            xorl %ecx, %ecx
            xorl %edx, %edx
            intoFile_2: #ci ricaviamo la cifra
            movl valoreTemporaneo, %eax
            divl moltiplicatoreCifre
            movl %edx, valoreTemporaneo #il resto va in rpm (edx resto divisione coi long)
            movl %eax, cifraTemporanea #il quoziente va in cifraTemporanea
            addl $48, cifraTemporanea #cosi lo trasformo in ascii
            xorl %eax, %eax  #adesso devo buttarlo nel file
            xorl %edx, %edx
            movl cifraTemporanea, %eax
            movl pointerFile, %edx
            movl %eax, (%edi,%edx)
            incl pointerFile
            xorl %eax, %eax #ora faccio moltiplicatoreCifre \= 10
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre #prendiamo il quoziente della divisione per 10 e lo mettiamo in moltiplicatoreCifre
            cmp $0, moltiplicatoreCifre
            jne intoFile_2
            END_intoFile_2:
            call stampaVirgola
            movl $1, moltiplicatoreCifre #stampo vel media
            movl $0, cifraTemporanea
            movl $0, valoreTemporaneo
            movl velocitaMedia, %edx #rendo il programma unversale
            movl %edx, valoreTemporaneo
            xorl %edx, %edx
            movl valoreTemporaneo, %ebx #mi salvo rpm per dopo
            ciclomini_3:
            incl contaCifre
            movl valoreTemporaneo, %eax
            divl dieci
            movl %edx, resto
            movl %eax, quoziente
            pushl %eax
            movl moltiplicatoreCifre, %eax
            mull dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            movl %eax,valoreTemporaneo
            cmp $0, quoziente
            jne ciclomini_3
            movl %ebx, valoreTemporaneo #ripristino rpm
            pushl %eax #aggiustiamo il moltiplicatoreCifre
            xorl %eax, %eax
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre
            popl %eax
            xorl %eax, %eax    #adesso andiamo a dividere per moltiplicatore, finche esso non vale 0
            xorl %ebx, %ebx       
            xorl %ecx, %ecx
            xorl %edx, %edx
            intoFile_3:
            movl valoreTemporaneo, %eax #ci ricaviamo la cifra
            divl moltiplicatoreCifre
            movl %edx, valoreTemporaneo #il resto va in rpm (edx resto divisione coi long)
            movl %eax, cifraTemporanea #il quoziente va in cifraTemporanea
            addl $48, cifraTemporanea #cosi lo trasformo in ascii
            xorl %eax, %eax #adesso devo buttarlo nel file
            xorl %edx, %edx
            movl cifraTemporanea, %eax
            movl pointerFile, %edx
            movl %eax, (%edi,%edx)
            incl pointerFile
            xorl %eax, %eax #ora faccio moltiplicatoreCifre \= 10
            xorl %edx, %edx
            movl moltiplicatoreCifre, %eax
            divl dieci
            movl %eax, moltiplicatoreCifre #prendiamo il quoziente della divisione per 10 e lo mettiamo in moltiplicatoreCifre
            cmp $0, moltiplicatoreCifre
            jne intoFile_3
            END_intoFile_3:
            pushl %eax
            pushl %ebx
            pushl %ecx
            pushl %edx
            xorl %ecx, %ecx #resetto ecx perche infame
            movl pointerFile, %ecx
            movb  $10,(%edi,%ecx)
            popl %edx
            popl %ecx 
            popl %ebx 
            popl %eax 
THE_END:
    popl %edx
    popl %ecx
    popl %ebx
    popl %eax
ret
.type FunzStampaHIGH, @function
FunzStampaHIGH:
        pushl %eax #stampo high
        pushl %ebx
        pushl %ecx
        pushl %edx
        leal etichettaHIGH, %ecx
        xorl %edx, %edx
        xorl %ebx, %ebx #resetto ebx perche ci serve da spiazzatore per l'etichetta
        ciclo_scrittura1:
            movl pointerFile, %edx
            movb (%ecx,%ebx),%al  #spostiamo char di etichetta in eax
            movb %al,(%edi,%edx) #edi rappresenta il file di uscita
            incl %ebx  #incrementiamo gli indici
            incl pointerFile #incrementiamo per il file
            cmp $4,%ebx #check se sono arrivato a fine etichetta
            jne ciclo_scrittura1
        popl %edx
        popl %ecx 
        popl %ebx 
        popl %eax 
ret
.type FunzStampaMEDIUM, @function
FunzStampaMEDIUM: #stampo MEDIUM
        pushl %eax 
        pushl %ebx
        pushl %ecx
        pushl %edx
        leal etichettaMEDIUM, %ecx
        xorl %edx, %edx
        xorl %ebx, %ebx #resetto ebx perche ci serve da spiazzatore per l'etichetta
        ciclo_scrittura2:
            movl pointerFile, %edx
            movb (%ecx,%ebx),%al  #spostiamo char di etichetta in eax
            movb %al,(%edi,%edx) #edi rappresenta il file di uscita
            incl %ebx #incrementiamo gli indici
            incl pointerFile #incrementiamo per il file
            cmp $6,%ebx #check se sono arrivato a fine etichetta
            jne ciclo_scrittura2
        popl %edx
        popl %ecx 
        popl %ebx 
        popl %eax 
ret
.type FunzStampaLOW, @function
FunzStampaLOW:
        #stampo LOW
        pushl %eax
        pushl %ebx
        pushl %ecx
        pushl %edx
        leal etichettaLOW, %ecx
        xorl %edx, %edx
        xorl %ebx, %ebx #resetto ebx perche ci serve da spiazzatore per l'etichetta
        ciclo_scrittura3:
            movl pointerFile, %edx
            movb (%ecx,%ebx),%al  #spostiamo char di etichetta in eax
            movb %al,(%edi,%edx) #edi rappresenta il file di uscita
            incl %ebx  #incrementiamo gli indici
            incl pointerFile #incrementiamo per il file
            cmp $3,%ebx #check se sono arrivato a fine etichetta
            jne ciclo_scrittura3
        popl %edx
        popl %ecx 
        popl %ebx 
        popl %eax 
ret
.type stampaVirgola, @function
stampaVirgola:
        #stampo la virgola
        pushl %eax
        pushl %ebx
        pushl %ecx
        pushl %edx
        xorl %ecx, %ecx #resetto ecx perche infame
        movl pointerFile, %ecx
        movb  $44,(%edi,%ecx)
        popl %edx
        popl %ecx 
        popl %ebx 
        popl %eax 
        incl pointerFile #incrementiamo per il file
ret

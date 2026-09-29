.MODEL SMALL
.STACK 100H
.DATA
    msg1       DB 13,10,'Guess a number (0-100): $'
    msgHigh    DB 13,10,'Too High!$'
    msgLow     DB 13,10,'Too Low!$'
    msgWin     DB 13,10,'Correct Guess!$'
    msgLose    DB 13,10,'You lost!$'
    msgTry     DB 13,10,'Attempts left: $'
    msgAgain   DB 13,10,'Play again? (y/n): $'
    msgAnswer  DB 13,10,'The correct number was: $'

    msgClose   DB 13,10,'Very Close!$'
    msgNear    DB 13,10,'Close!$'

    secret     DW ?
    attempts   DB ?

.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

GAME_START:
    CALL RANDOM
    MOV attempts,5

START:
    LEA DX,msgTry
    MOV AH,9
    INT 21H

    MOV AL,attempts
    ADD AL,'0'
    MOV DL,AL
    MOV AH,2
    INT 21H

    LEA DX,msg1
    MOV AH,9
    INT 21H

    CALL READ_NUM

    MOV BX,secret

    CMP AX,BX
    JNE SKIP_CORRECT
    JMP CORRECT

SKIP_CORRECT:
    DEC attempts
    CMP attempts,0
    JNE SKIP_LOSE
    JMP LOSE

SKIP_LOSE:
    MOV DX,AX
    SUB DX,BX
    JNS POSITIVE
    NEG DX

POSITIVE:
    CMP DX,5
    JBE VERY_CLOSE

    CMP DX,10
    JBE CLOSE_HINT

    CMP AX,BX
    JA HIGH_HINT
    JMP LOW_HINT

VERY_CLOSE:
    LEA DX,msgClose
    MOV AH,9
    INT 21H

    CMP AX,BX
    JA HIGH_HINT
    JMP LOW_HINT

CLOSE_HINT:
    LEA DX,msgNear
    MOV AH,9
    INT 21H

    CMP AX,BX
    JA HIGH_HINT
    JMP LOW_HINT

HIGH_HINT:
    LEA DX,msgHigh
    MOV AH,9
    INT 21H
    JMP START

LOW_HINT:
    LEA DX,msgLow
    MOV AH,9
    INT 21H
    JMP START

CORRECT:
    LEA DX,msgWin
    MOV AH,9
    INT 21H
    JMP AGAIN

LOSE:
    LEA DX,msgLose
    MOV AH,9
    INT 21H

    LEA DX,msgAnswer
    MOV AH,9
    INT 21H

    MOV AX,secret
    CALL PRINT_NUM

    MOV DL,13
    MOV AH,2
    INT 21H

    MOV DL,10
    MOV AH,2
    INT 21H

AGAIN:
    LEA DX,msgAgain
    MOV AH,9
    INT 21H

    MOV AH,1
    INT 21H

    CMP AL,'y'
    JNE CHECK_UPPER_Y
    JMP GAME_START

CHECK_UPPER_Y:
    CMP AL,'Y'
    JNE EXIT_PROGRAM
    JMP GAME_START

EXIT_PROGRAM:
    MOV AH,4CH
    INT 21H

MAIN ENDP


RANDOM PROC
    MOV AH,2Ch
    INT 21H

    MOV AL,DH
    MOV AH,0

    MOV BL,101
    DIV BL

    MOV AL,AH      
    MOV AH,0     
    MOV secret,AX
    RET
RANDOM ENDP

READ_NUM PROC
    XOR BX,BX

READ_LOOP:
    MOV AH,1
    INT 21H

    CMP AL,13
    JE DONE

    SUB AL,'0'

    XOR AH,AH
    MOV CX,AX

    MOV AX,BX

    MOV SI,10
    MUL SI

    ADD AX,CX
    MOV BX,AX

    JMP READ_LOOP

DONE:

    MOV AX,BX
    RET

READ_NUM ENDP


PRINT_NUM PROC
    MOV BX,10
    XOR CX,CX

L1:
    XOR DX,DX
    DIV BX

    PUSH DX
    INC CX

    CMP AX,0
    JNE L1

L2:
    POP DX
    ADD DL,'0'

    MOV AH,2
    INT 21H

    LOOP L2

    RET

PRINT_NUM ENDP

END MAIN

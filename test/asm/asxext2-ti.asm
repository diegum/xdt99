*  TEST XDT EXTENSIONS

	DEF DATA1		* COMMENT

SYM1    EQU 1

        AORG >A000
AA1     DATA >1111
AA2     DATA >2222
        RORG
AR1     DATA >3333
AR2     DATA >4444

* LOWER CASE SUPPORT

LABEL1	EQU 1			* COMMENT
LABEL2	EQU 2

	CLR R0

DATA1	DATA LABEL1,LABEL2
TEXT1	TEXT 'Hello World!'

* LONG LABELS

LONGL1  DATA LONGL2-LONGL1
LONGL2  MOV @LONGL1,@LONGL2
XFUNKY  DATA XFUNKY

* RELAXED WHITESPACE

WS1
WS2     EQU >1+-2*>3+'4'
WS3     EQU     >1  + 2 IGNORED
        INC @DATA1
        INC @DATA1+2
        MOV @DATA1,@DATA1+2
        MOV @DATA1+2,@DATA1
        CLR @DATA1(R6)
        INC @DATA1+>2(R4)
        MOV  @TEXT1(R7),@TEXT1(R9)
        MOV @>10,@>20(R0)
        MOV *R10+,*R9
        MOV *R0,*R9+
        MOV  @2+DATA1,@DATA1+>2-TEXT1

WS4     BYTE 1,2,3,4,5
        TEXT '   ,'',   '
        EVEN
        RTWP
        RT
	DATA  WS1,WS2,WS3,WS4

* ADVANCED EXPRESSIONS

EXPR1   EQU 6
EXPR2   EQU 14
EXPR3   EQU -10
EXPR4   EQU 10
EXPR5   EQU 6
EXPR6   EQU -9
EXPR7   EQU >816
EXPR8   EQU >F55
EXPR9   EQU 5
EXPR10  EQU 102
EXPR11  EQU 2

        DATA 6,10
	BYTE >FF,0,-1
        DATA >510,>A,>FFFF,0
        DATA 0

        CLR @EXPR1-EXPR2+1(R1)    ; @-7(R1)
        INC @4
        DEC @2457(2)
        CLR @>FFFF
        LI 1,1

EXPR20  EQU AA1+AR1-AR2
EXPR21  EQU AA1+AR1-AR2

	DATA EXPR1,EXPR2,EXPR3,EXPR4,EXPR5
	DATA EXPR6,EXPR7,EXPR8,EXPR9,EXPR10
	DATA EXPR11,EXPR20,EXPR21

        DATA AA1+AR1-AR2-1
        DATA AA1-AR2+AR1-AA1
        DATA >1000
        DATA >5FFF

* CONDITIONAL ASSEMBLY SYM2=SYM3=2

COND1   DATA >1111
*       .IFDEF SYM1
        DATA >2001
*       .ELSE
*       DATA >2002
*       .ENDIF
*	.IFNDEF SYM2
*	DATA >2003
*	.ENDIF

*OND2	.IFDEF SYM3
        DATA >3001
*       .IFDEF SYM2
        DATA >300F
*       .ENDIF
*       .ELSE
*       DATA >3002
*       .IFDEF SYM2
*       DATA >3101
*       .ELSE
*       DATA >3102
*       .ENDIF
*       DATA >3003
*       .ENDIF
        DATA >FFFF

COND3   DATA >1111
*       .IFEQ SYM2
*       DATA >2222
*       .ENDIF
*       .IFNE SYM2
        DATA >3333
*       .ENDIF
*	.IFGT SYM2
	DATA >4444
*	.ENDIF

*OND4   .IFEQ SYM1 + SYM2 + SYM3, 3
*       DATA >2222
*       .ENDIF
*       .IFNE SYM2 * SYM3, 4
*       DATA >3333
*       .ENDIF
*	.IFGT SYM2, SYM1
	DATA >4444
*	.ENDIF
*	.IFGE SYM2, SYM3
	DATA >5555
*	.ENDIF

*OND5   .IFNDEF _VERSION_
        DATA >FEFE
*       .ENDIF

	END LONGL1

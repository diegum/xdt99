START:
 C=1
 D=2
 ON D GOSUB @CASE1,@CASE2,@CASE3
 D=D+1
 GO SUB @SUBROUTINE
 D=D+C
 GOTO @START

CASE1:
 C=C-D
 RETURN
CASE2:
 D=1
 RETURN
CASE3:
 C=0
 RETURN

SUBROUTINE:
 IF D<3 THEN @S1 ELSE @S2
 GO TO @S2
S1:
 D=1
S2:
 RETURN

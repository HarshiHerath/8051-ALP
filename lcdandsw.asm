//LCD Module Connections
RS BIT P0.0
EN BIT P0.1
D0 BIT P2.0
D1 BIT P2.1
D2 BIT P2.2
D3 BIT P2.3
D4 BIT P2.4
D5 BIT P2.5
D6 BIT P2.6
D7 BIT P2.7
//End LCD Module Connections
//Keypad Connections
RO1 BIT P1.0
RO2 BIT P1.1
RO3 BIT P1.2
RO4 BIT P1.3
C1 BIT P1.4
C2 BIT P1.5
C3 BIT P1.6
C4 BIT P1.7
	
//Motor connnections
M0 BIT P3.0
M1 BIT P3.1

ORG 0
// MAIN PROGRAM STARTS HERE


LCALL Lcd8_init   
MOV R3,#0         ;i=0
MOV R0,#1
MOV R1,#1
LCALL Lcd8_Set_Cursor
MOV DPTR, #MSG1
LCALL Lcd8_Write_String


BACK:
         LCALL Read_Keypad
		CJNE A,#0,READ_DONE
		JMP BACK
READ_DONE:
		MOV R2,A    
      		
        LCALL READ_MOTOR_KEYS
		MOV R0,#1
		MOV R1,#14
		LCALL Lcd8_Set_Cursor
		MOV A,R2
		LCALL Lcd8_Write_Char
		

JMP BACK


Delay:
L2:MOV R6,#100
L1:DJNZ R6,L1
DJNZ R7,L2
RET





READ_MOTOR_KEYS:
CLR P3.0
CLR P3.1
SETB C1
 SETB C2
 SETB C3
 SETB C4
 SETB RO1
 SETB RO2
 CLR RO3
 SETB RO4
 
 JB C1,END1
 JB C2,END1
 MOV R7,#100
 LCALL Delay
 JB C1,END1
 JB C2,END1
     SETB P3.0
     CLR P3.1
        MOV R0,#1
		MOV R1,#14
		LCALL Lcd8_Set_Cursor
		MOV A,#'R'
		LCALL Lcd8_Write_Char
JMP  READ_MOTOR_KEYS



 END1:
 RET
 

Read_Keypad:

 SETB C1
 SETB C2
 SETB C3
 SETB C4
 CLR RO1
 SETB RO2
 SETB RO3
 SETB RO4
 JB C1,N1
 MOV R7,#100
 LCALL Delay
 JB C1,N1
 MOV A,#'7'
 RET
 N1:
 
 JB C2,N2
 MOV R7,#100
 LCALL Delay
 JB C2,N2
 MOV A,#'8'
 RET
 N2:
 
 JB C3,N3
 MOV R7,#100
 LCALL Delay
 JB C3,N3
 MOV A,#'9'
 RET
 N3:
 
 JB C4,N4
 MOV R7,#100
 LCALL Delay
 JB C4,N4
 MOV A,#'/'
 RET
 N4:
 

 SETB RO1
 CLR RO2
 SETB RO3
 SETB RO4
 JB C1,N5
 MOV R7,#100
 LCALL Delay
 JB C1,N5
 MOV A,#'4'
 RET
 N5:
 
 JB C2,N6
 MOV R7,#100
 LCALL Delay
 JB C2,N6
 MOV A,#'5'
 RET
 N6:
	 
	 
	 
JB C3,N7
 MOV R7,#100
 LCALL Delay
 JB C3,N7
 MOV A,#'6'
 RET
 N7:
 
 JB C4,N8
 MOV R7,#100
 LCALL Delay
 JB C4,N8
 MOV A,#'X'
 RET
 N8:
 
 SETB RO1
 SETB RO2
 CLR RO3
 SETB RO4
 JB C1,N9
 MOV R7,#100
 LCALL Delay
 JB C1,N9
 MOV A,#'1'
 RET
 N9:
 
 
JB C2,N10
 MOV R7,#100
 LCALL Delay
 JB C2,N10
 MOV A,#'2'
 RET
 N10:
 
 
JB C3,N11
 MOV R7,#100
 LCALL Delay
 JB C3,N11
 MOV A,#'3'
 RET
 N11:
 
 
 JB C4,N12
 MOV R7,#100
 LCALL Delay
 JB C4,N12
 MOV A,#'-'
 RET
 N12:
 
 
 
 SETB RO1
 SETB  RO2
 SETB RO3
 CLR RO4
 
 JB C1,N13
 MOV R7,#100
 LCALL Delay
 JB C1,N13
 MOV A,#'C'
 RET
 N13:
 
  JB C2,N14
 MOV R7,#100
 LCALL Delay
 JB C2,N14
 MOV A,#'0'
 RET
 N14:
 
 JB C3,N15
 MOV R7,#100
 LCALL Delay
 JB C3,N15
 MOV A,#'='
 RET
 N15:
  JB C4,N16
 MOV R7,#100
 LCALL Delay
 JB C4,N16
 MOV A,#'+'
 RET
 N16: 
 MOV A,#0
 RET





// LCD.H FUNCTIONS ARE HERE

//LCD Functions Developed by electroSome

//lLCD DELAY FUNCTION

Lcd_Delay:
L6: 
MOV R6,#100
L5:DJNZ R6,L5
DJNZ R7,L6
RET

//LCD 8 Bit Interfacing Functions
Lcd8_Port:
    MOV B,A

	ANL A,#01
	JNB ACC.0,ND0
	SETB D0
	JMP X1
ND0: 
	CLR D0
	X1:	
	
MOV  A,B
ANL A,#02
	JNB ACC.1,ND1
	SETB D1
	JMP X2
ND1:
	CLR D1
	X2:	
	
MOV  A,B
ANL A,#04
	JNB ACC.2,ND2
	SETB D2
	JMP X3
ND2:
	CLR D2
	X3:	
	
	MOV  A,B
ANL A,#08
	JNB ACC.3,ND3
	SETB D3
	JMP X4
ND3:
	CLR D3
	X4:
	
	MOV  A,B
ANL A,#16
	JNB ACC.4,ND4
	SETB D4
	JMP X5
ND4:
	CLR D4
	X5:
	
	MOV  A,B
ANL A,#32
	JNB ACC.5,ND5
	SETB D5
	JMP X6
ND5:
	CLR D5
	X6:
	MOV  A,B
ANL A,#64
	JNB ACC.6,ND6
	SETB D6
	JMP X7
ND6:
	CLR D6
	X7:
	
	MOV  A,B

ANL A,#128
	JNB ACC.7,ND7
	SETB D7
	JMP X8
ND7:
	CLR D7
	X8:
	RET
	
	
	
Lcd8_Cmd:

  CLR RS             // => RS = 0
  LCALL Lcd8_Port             //Data transfer
  SETB EN              // => E = 1
  LCALL Lcd_Delay
  CLR EN           // => E = 0
  RET


Lcd8_Clear:
      MOV A,#01
	  LCALL Lcd8_Cmd
	  RET


Lcd8_Set_Cursor:

	CJNE R0,#1,CUR2
	MOV A,#80H
	ADD A,R1
	LCALL Lcd8_Cmd
	RET
CUR2:
         
        MOV A,#0C0H
		ADD A,R1
		LCALL Lcd8_Cmd
		RET
	
	
	

Lcd8_Init:
    MOV A,#0
	LCALL Lcd8_Port
	CLR RS 
	MOV R7,#200
	LCALL Lcd_Delay
	///////////// Reset process from datasheet /////////
	MOV A,#30H
	LCALL  Lcd8_Cmd
	MOV R7,#50
	LCALL Lcd_Delay
	MOV A,#30H
	LCALL  Lcd8_Cmd
	MOV R7,#110
	LCALL Lcd_Delay
	MOV A,#30H
	LCALL  Lcd8_Cmd	
  /////////////////////////////////////////////////////
    MOV A,#38H
	LCALL  Lcd8_Cmd    //function set
	MOV A,#0CH
	LCALL  Lcd8_Cmd    //display on,cursor off,blink off
	MOV A,#01H
	LCALL  Lcd8_Cmd   //clear display
	MOV A,#06H
	LCALL  Lcd8_Cmd    //entry mode, set increment
	RET
	
Lcd8_Write_Char:

    SETB   RS            // => RS = 1
    LCALL Lcd8_Port             //Data transfer
   SETB EN             // => E = 1
   MOV R7,#5
   LCALL Lcd_Delay
   CLR EN           // => E = 04
  RET


Lcd8_Write_String:

	PUSH ACC
	SSS:
	MOV A,#0
	MOVC A,@A+DPTR
	JZ EXIT1
	LCALL  Lcd8_Write_Char
	INC DPTR
	JMP SSS
	
	EXIT1:
	POP ACC
	RET

//End LCD 8 Bit Interfacing Functions

ORG 3000H
MSG1: DB 'Key:',0

	
END
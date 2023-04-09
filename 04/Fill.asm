// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

    // Initialization
    @SCREEN
    D=A
    @pScreen    // current position
    M=D

    @24575    // The end of Screen Memory
    D=A
    @screen_end
    M=D

    @state
    M=0

(CLEAR)
    @KBD
    D=M
    @CLEAR
    D;JEQ    // Loop if no key is pressed
    @state
    M=-1
    @DRAW
    0;JMP    // goto draw on the screen

(BLACKEN)
    @KBD
    D=M
    @BLACKEN
    D;JNE    // Loop if key is still pressed
    @state
    M=0    // Continue to draw on the screen

(DRAW)
    @pScreen
    D=M
    @screen_end
    D=D-M
    @FINISHDRAWING    // It's the last row of screen
    D;JGE

    @state
    D=M
    @pScreen    // Choose the register "cur" point at
    A=M
    M=D
    @pScreen
    M=M+1
    @DRAW
    0;JMP

(FINISHDRAWING)
    @SCREEN    // Initialize the screen pointer
    D=A
    @pScreen
    M=D

    @state    // choose to goto "CLEAR" or "BLACKEN" base on current state
    D=M
    @CLEAR
    D;JEQ
    @BLACKEN
    0;JMP

# mips-disassembly POC

Assembly program that decodes binary instructions stored in memory to valid (and human readable) MIPS assembly instructions. This PoC only decodes `add`, `sub`, `addi`, `lw` and `sw`.

E.G.: 

0x02538820 == `add   $17, $18, $19`

0x02538822 == `sub   $17, $18, $19`

0x22510064 == `addi  $17, $18, 100`

0x8E510064 == `lw    $17, 100($18)`

0xAE510064 == `sw    $17, 100($18)`

0x12345678 == `Invalid instruction`

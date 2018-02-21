@ECHO OFF
"C:\Program Files (x86)\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "D:\sumaru\C1\labels.tmp" -fI -W+ie -C V2E -o "D:\sumaru\C1\C1.hex" -d "D:\sumaru\C1\C1.obj" -e "D:\sumaru\C1\C1.eep" -m "D:\sumaru\C1\C1.map" "D:\sumaru\C1\C1.asm"

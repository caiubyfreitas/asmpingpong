all: ping
	qemu-system-x86_64 ping

ping: ping.asm
	nasm ping.asm -o ping

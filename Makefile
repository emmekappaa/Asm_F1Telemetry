all: compilazione

compilazione:

	cd ./bin
	rm -f telemetry
	cd ..
	gcc -c -g -m32 -o main.o ./src/main.c
	gcc -c -g -o telemetry.o -m32 ./src/telemetry.s
	gcc -m32 -g -o telemetry main.o telemetry.o
	mv telemetry ./bin
	mv main.o telemetry.o ./obj
	rm -f main.o 
	rm -f telemetry.o

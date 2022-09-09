OBJS=main.o utils.o
AS=as
LD=ld

default: main

main: $(OBJS)
	$(LD) $^ -o $@

%.o: %.s
	$(AS) -o $@ $^

MODS = $(patsubst %.erl, %.beam, $(wildcard *.erl))

%.beam: %.erl
	erlc -W $<

.PHONY: all clean

all: $(MODS)
	erl $^

clean:
	rm -f *.beam

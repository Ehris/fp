MODS = $(patsubst %.erl, %.beam, $(wildcard *.erl))

%.beam: %.erl
	erlc -W $<

.PHONY: all clean

all: $(MODS)
	rlwrap erl $^

clean:
	rm -f *.beam

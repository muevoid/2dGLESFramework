CFLAGS = -Wall -fPIC -O2

INCLUDES = -Iinclude -Iexternal

LIBS = -lGLESv2 -lEGL

SRCS = src/sound.c src/buffer.c src/camera.c src/texture.c src/shader.c src/vingl.c 

PREFIX = /usr/local

OBJS = $(SRCS:.c=.o)

MAIN = vinox

.PHONY: depend uninstall install clean

all: $(MAIN)
	@echo LibVinox has successfully compiled

$(MAIN): $(OBJS)
	$(CC) -shared $(OBJS) -o libvinox.so

.c.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

install:
	mkdir -p $(DESTDIR)$(PREFIX)/lib
#	cp libvinox.a $(DESTDIR)$(PREFIX)/lib
	cp libvinox.so $(DESTDIR)$(PREFIX)/lib
	mkdir -p $(DESTDIR)$(PREFIX)/include/vinox
	cp include/* $(DESTDIR)$(PREFIX)/include/vinox
	cp external/raymath.h $(DESTDIR)$(PREFIX)/include
	cp external/cute_c2.h $(DESTDIR)$(PREFIX)/include

uninstall:
	rm -rf $(DESTDIR)$(PREFIX)/lib/libvinox.so
	rm -rf $(DESTDIR)$(PREFIX)/include/vinox
	rm -rf $(DESTDIR)$(PREFIX)/include/raymath.h
	rm -rf $(DESTDIR)$(PREFIX)/include/cute_c2.h

clean:
	$(RM) $(OBJS) libvinox.so

depend: $(SRCS)
	makedepend $(INCLUDES) $^

#END

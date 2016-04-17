#include <io/io.h>

void io_send_buffer (io_port_t port, uint8_t *buf, size_t len) {
	size_t i;
	for (i = 0; i < len; i++) {
		io_send_byte (port, buf[i]);
	}
}

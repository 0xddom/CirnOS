#ifndef INCLUDE_IO_H
#define INCLUDE_IO_H

#include <libc/types.h>
#include <stddef.h>

#define FB_COMMAND_PORT			0x3d4
#define FB_DATA_PORT 			0x3d5
#define FB_HIGH_BYTE_COMMAND 	14
#define FB_LOW_BYTE_COMMAND		15

typedef uint16_t io_port_t;

void io_send_byte(io_port_t port, uint8_t data);
void io_send_buffer(io_port_t port, uint8_t *buf, size_t len);
uint8_t io_read_byte(io_port_t port);

#endif

ENTRY(_start)

SECTIONS
{
	. = 1M;
	
	.text BLOCK (4K) : ALIGN (4K)
	{
		*(.multiboot)
		*(.text)
	}

	.rodata BLOCK (4K) : ALIGN (4K)
	{
		*(.rodata)
	}

	.data BLOCK (4K) : ALIGN (4K)
	{
		*(.data)
	}

	.bssALIGN (0x1000) :

	{
		*(COMMON)
		*(.bss)
		*(.bootstrap_stack)
	}
}

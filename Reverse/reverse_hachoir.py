def rol(val, r_bits, max_bits):
	return (val << r_bits % max_bits) & (2**max_bits-1) | \
	((val & (2**max_bits-1)) >> (max_bits-(r_bits % max_bits)))


def ror(val, r_bits, max_bits):
	return ((val & (2**max_bits-1)) >> r_bits % max_bits) | \
	(val << (max_bits-(r_bits % max_bits)) & (2**max_bits-1))


max_bits = 32


def reverse_hash(value, passValue):
	value ^= 0x1337
	value += 0x453B698E
	value = rol(value, 7, max_bits)
	value = ~value
	value -= passValue
	value = ror(value, 0xD, max_bits)
	return value


def reverse(value, xorValue):
	value ^= xorValue
	value = reverse_hash(value, 2)
	value = reverse_hash(value, 1)
	value = reverse_hash(value, 0)
	return value


val1 = reverse(0xB7018C0E, 0x444E4152)
val2 = reverse(0xA867B02F, 0x53204D4F)
val3 = reverse(0xE7BBE069, 0x21444545)

print str(hex(val3)[2:10]).decode("hex"), str(hex(val2)[2:10]).decode("hex"), \
str(hex(val1)[2:10]).decode("hex")

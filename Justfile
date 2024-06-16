

build:
    mkdir -p build

    # Compile and link
    riscv32-elf-as boot.s -o build/boot.o -march=rv32i -misa-spec=2.2 -mlittle-endian
    riscv32-elf-as stdlib.helper.s -o build/stdlib.helper.o -march=rv32i -misa-spec=2.2 -mlittle-endian
    riscv32-elf-as stdlib.io.s -o build/stdlib.io.o -march=rv32i -misa-spec=2.2 -mlittle-endian
    riscv32-elf-as main.s -o build/main.o -march=rv32i -misa-spec=2.2 -mlittle-endian

    riscv32-elf-ld -T linker.lds -o build/kernel.elf --gc-sections -flto

    # Export binary and generated assembly
    riscv32-elf-objcopy -O binary build/kernel.elf build/kernel.bin
    riscv32-elf-objdump -d build/kernel.elf > build/program.dump.elf.s

    # Consume 1 unit of 4 bytes per line
    hexdump -v -e '1/4 "%08x \n" ' build/kernel.bin > build/kernel.hex # 32b

# for gcc godbolt: 
#   -mno-fdiv -O3 -march=rv32id -lm -nostdlib -nodefaultlibs -nostartfiles -fno-exceptions -fno-rtti -pie -flto
# https://godbolt.org/z/qPGn3EEd9

# gcc -nostdlib -nodefaultlibs -fno-exceptions -nostartfiles -fno-rtti
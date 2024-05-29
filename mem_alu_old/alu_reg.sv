// register maneger for ALU

class alu_reg;

    parameter int ADDR_WIDTH = 2;
    parameter int DATA_WIDTH = 8;
    parameter array_size = 2**ADDR_WIDTH-1;
    // reg is emulate by assosiated array
    // $clog2(2**ADDR_WIDTH) calculate the number of bits needed to represent the address
    bit [DATA_WIDTH-1:0] reg_ref [bit [2**ADDR_WIDTH-1:0]];
    bit [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];

    // constructor
    function new();
        reset();
    endfunction

    // function to write to the register
    function void write(bit [2**ADDR_WIDTH-1:0] addr, bit [DATA_WIDTH-1:0] data);
        reg_ref[addr] = data;
        mem[addr] = data;
    endfunction

    // function to read from the register
    function bit [DATA_WIDTH-1:0] read(bit [2**ADDR_WIDTH-1:0] addr);
        return reg_ref[addr];
    endfunction

    // function to reset the register
    function void reset();
        reg_ref = '{default:'0};
    endfunction

endclass
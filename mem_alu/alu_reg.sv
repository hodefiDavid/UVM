// register maneger for ALU

class alu_reg;

    parameter int ADDR_WIDTH = 2;
    parameter int DATA_WIDTH = 8;
    parameter array_size = 2**ADDR_WIDTH-1;
    // reg is emulate by assosiated array
    // $clog2(2**ADDR_WIDTH) calculate the number of bits needed to represent the address
    bit [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];

    // constructor
    function new();
        reset();
    endfunction

    // function to write to the register
    function void write(bit [2**ADDR_WIDTH-1:0] addr, bit [DATA_WIDTH-1:0] data);
        case(addr)
            0: mem[addr] = data;
            1: mem[addr] = data;
            2: mem[addr][2:0] = data;
            3: mem[addr][0] = data;
        endcase
    endfunction

    function get_exe();
        return mem[3][0];
    endfunction

    // function to read from the register
    function bit [DATA_WIDTH-1:0] read(bit [2**ADDR_WIDTH-1:0] addr);
        return mem[addr];
    endfunction



    // function to reset the register
    function void reset();
        mem = '{default:'0};
    endfunction

endclass
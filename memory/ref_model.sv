class ref_model;
	parameter ADDR_WIDTH = 3;
	parameter DATA_WIDTH = 8;

    bit [DATA_WIDTH-1:0] queue_data[2**ADDR_WIDTH];
    my_transaction t_out;

    function new();
        my_transaction t_out = new();
        reset();
    endfunction

    function reset();
        for(int i=0; i<2**ADDR_WIDTH; i++)
            queue_data[i] = 8'hFF;
    endfunction


    function my_transaction rst_res();
        reset();
        this.t_out = new();
        this.t_out.is_data_valid = 0;
        return this.t_out;
    endfunction


    function void write_res(my_transaction t_in);
        if(t_in.wr_en == 1'b1) begin
            queue_data[t_in.addr] = t_in.wr_data;
        end
    endfunction

    function my_transaction read_res(my_transaction t_in);

        this.t_out = new();
        if(t_in.rd_en == 1'b1) begin
            t_out.rd_data = queue_data[t_in.addr];
            t_out.is_data_valid = 1;
            return t_out;
        end
        else begin
            t_out.is_data_valid = 0;
            return t_out;
        end

    endfunction

    function my_transaction write_read_res(my_transaction t_in);
        write_res(t_in);
        return read_res(t_in);
    endfunction

    function my_transaction step(my_transaction t_in);

        if(t_in.rst == 1'b1) 
            return rst_res();
        else
            return write_read_res(t_in);

    endfunction

endclass
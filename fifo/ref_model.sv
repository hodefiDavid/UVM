class ref_model;

    bit [3:0] queue_data[$];
    int MAX_SIZE = 16;
    int MIN_SIZE = 0;
    my_transaction t_out;

    function new();
        my_transaction t_out = new();
        reset();
    endfunction

    function reset();
        queue_data.delete();
    endfunction

    function bit is_full();
        if(queue_data.size() == MAX_SIZE) begin
            return 1;
        end
        else begin
            return 0;
        end
    endfunction

    function bit is_empty();
        if(queue_data.size() == MIN_SIZE) begin
            return 1;
        end
        else begin
            return 0;
        end
    endfunction

    function my_transaction rst_res();
        reset();
        this.t_out = new();
        return this.t_out;
    endfunction

    function my_transaction def_res();
        this.t_out = new();
        this.t_out.is_data_valid = 0;
        this.t_out.full = is_full();
        this.t_out.empty = is_empty();
        return t_out;
    endfunction

    function my_transaction write_res(my_transaction t_in);
        if(queue_data.size() < MAX_SIZE) begin
            queue_data.push_back(t_in.data_in);
        end
        return def_res();
    endfunction

    function my_transaction read_res(my_transaction t_in);
        this.t_out = new();
        if(!is_empty()) begin
            this.t_out.data_out = queue_data.pop_front();
            this.t_out.is_data_valid = 1;
            this.t_out.full = is_full();
            this.t_out.empty = is_empty();
            return this.t_out;
        end
        else begin
            return def_res();
        end
    endfunction

    function my_transaction step(my_transaction t_in);

        if(t_in.rst == 1'b1) 
            return rst_res();
        if(t_in.write_en == 1'b1) 
            return write_res(t_in);
        if(t_in.read_en == 1'b1)
            return read_res(t_in);
        //defualt
        return def_res();            

    endfunction

endclass
class ref_model;

    bit [7:0] count;

    function new();
        count = 0;
    endfunction

    function my_transaction step(my_transaction tr_in);
        if (tr_in.rst) begin
            count = 0;
        end
        else if (tr_in.load) begin
            count = tr_in.data_in;
        end
        else if (tr_in.up_down) begin
            count = count + 1;
        end
        else begin
            count = count - 1;
        end
        tr_in.count = count;
        return tr_in;
    endfunction
endclass

// class ref_modle;
// // this class receives the input signal 
// //from the monitor in and convert them to an output signal as same as the counter_up_dpwn DUT does

//     // input signal
//     bit clk;
//     bit rst;
//     bit up_down;
//     bit load;
//     bit [7:0] data_in;

//     // output signal
//     bit [7:0] count;
//     my_transaction ref_trans; 

//     // constructor
//     function new();
//     ref_trans = new();
//     endfunction

//     // this function will receive the input signal -  the transaction from the 
//     // monitor and convert it to the output signal - the transaction to the DUT 
//     function my_transaction step(my_transaction trans);

//     if(trans.rst)
//     retrun rst_res();
    
//     if(trans.load)
//     retrun load_res(trans);

//     retrun up_down_res(trans);

//     endfunction

//     function my_transaction rst_res();
//      ref_trans.count = 0;
//      count = 0;
//     return ref_trans;
//     endfunction

//     function my_transaction load_res(my_transaction trans);
//      ref_trans.count = trans.data_in;
//      count = trans.data_in;
//      retrun ref_trans;
//     endfunction

//     function my_transaction up_down_res (my_transaction trans);
//     if (trans.up_down)
//     count = count + 1;
//     else
//     count = count - 1;

//     ref_trans.count = count;
//     retrun ref_trans;
//     endfunction

// endclass
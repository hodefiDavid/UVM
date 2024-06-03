module alu ( input bit data_in,clk,rst, output bit [15:0] res_out);

    bit [3:0] occumulator;
    logic [31:0] full_register;
    logic execute;
    logic [2:0] op;
    logic [7:0] B;
    logic [7:0] A;
    bit valid;
    int counter;
    reg temp_res_out;
    always @(posedge clk) begin

        if(rst) begin
            occumulator = 4'b0000;
            full_register = 32'b0;
            execute = 0;
            op = 3'b000;
            B = 8'b0;
            A = 8'b0;
            valid = 0;
            counter = 0;
            temp_res_out = 16'h0;
        end
        else begin
            case(occumulator)
                1'b0:  occumulator = (data_in==1)? 1'b1 :1'b0;
                1'b1:  occumulator = (data_in==1)? 1'b1 : 2'b10;
                2'b10: occumulator = (data_in==1)? 3'b101 :1'b0;
                3'b101:occumulator = (data_in==1)? 1'b1 :4'b1010 ;
                4'b1010: valid = 1;
            endcase
    
            if (valid) begin
                occumulator = 1'b0;
                full_register[counter] = data_in;
                counter++;
                if (counter == 32) begin
                    occumulator = 0;
                    counter = 0;
                    valid = 0;
                    execute = full_register[0];
                    op = full_register[10:8];
                    B = full_register[23:16];
                    A = full_register[31:24];

                    $display("DUT: full_register=%b",full_register);
                    $display("DUT: A=%d B=%d OP=%d EXE=%d,   time = %d",A,B,op,execute,$time);


                    if(execute) begin
                        case(op)
                            0: temp_res_out = 0;
                            1: temp_res_out = A+B;
                            2: temp_res_out = A-B;
                            3: temp_res_out = A*B;
                            4: temp_res_out = (B==0)? 16'hDEAD : A/B;
                        endcase
                    end//execute
                end
            end //if valid
        end //else
        //valid = 0;
    end //always

    assign res_out = temp_res_out;
endmodule
`include "alu_reg.sv"

class ref_model;
    parameter A = 0;
    parameter B = 1;
    parameter OPER = 2;
    parameter EXECUTE = 3;
    
    my_transaction t_out;
    // store the privious result
    bit [16-1:0] privious_res_out;
    // create an object of the alu_reg class
    alu_reg alu_reg_h;
    function new();
        alu_reg_h = new();
        t_out = new();
    endfunction


    function my_transaction step(my_transaction t_in);
        this.t_out = t_in;
        this.t_out.is_data_valid = 0;
        // reset the register
        if(t_in.reset == 1) begin
            alu_reg_h.reset();
            t_out.rd_data = 0;
            t_out.res_out = 0;
            return t_out;
        end

        // write and read the register
        if(t_in.rd_wr == 0) begin
            if(t_in.enable == 1) begin
                if(t_in.addr<2)
                alu_reg_h.write(t_in.addr, t_in.wr_data);
                else if (t_in.addr==2)
                alu_reg_h.write(t_in.addr, t_in.wr_data[2:0]);
                else if (t_in.addr==3)
                alu_reg_h.write(t_in.addr, t_in.wr_data[0]);
            end
        end
        else begin
            if(t_in.enable == 1)
            alu_reg_h.read(t_in.addr, t_out.rd_data);
            t_out.is_data_valid = 1;
        end
        
        // execute the operation
        if(alu_reg_h.read(EXECUTE))begin
            if(alu_reg_h.read(OPER)==0) begin
                t_out.res_out=0;
                privious_res_out = t_out.res_out;
            end else if (alu_reg_h.read(OPER)==1)begin
                t_out.res_out=alu_reg_h.read(A)+alu_reg_h.read(B);
                privious_res_out = t_out.res_out;
            end else if (alu_reg_h.read(OPER)==2)begin
                t_out.res_out=alu_reg_h.read(A)-alu_reg_h.read(B);
                privious_res_out = t_out.res_out;
            end else if (alu_reg_h.read(OPER)==3)begin
                t_out.res_out=alu_reg_h.read(A)*alu_reg_h.read(B);
                privious_res_out = t_out.res_out;
            end else if (alu_reg_h.read(OPER)==4)
                if(alu_reg_h.read(B)!=0) begin
                    t_out.res_out=alu_reg_h.read(A)/alu_reg_h.read(B);
                    privious_res_out = t_out.res_out;
                end else begin
                    t_out.res_out=16'hdead;
                    privious_res_out = t_out.res_out;
                end
        end
      return t_out;
    endfunction

endclass
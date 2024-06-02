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
    t_out = t_in;

    if(t_in.enable)begin
    
    if(alu_reg_h.get_exe())begin
      case(alu_reg_h.read(OPER))
        0: t_out.res_out = 0;
        1: t_out.res_out = alu_reg_h.read(A)+alu_reg_h.read(B);
        2: t_out.res_out = alu_reg_h.read(A)-alu_reg_h.read(B);
        3: t_out.res_out = alu_reg_h.read(A)*alu_reg_h.read(B);
        4: if(alu_reg_h.read(B)!=0)
            t_out.res_out = alu_reg_h.read(A)/alu_reg_h.read(B);
           else
            t_out.res_out = 16'hdead;
        default: t_out.res_out = privious_res_out;
      endcase

      // store the privious result
      privious_res_out = t_out.res_out;
    end

      if(t_in.rd_wr)begin
        t_out.rd_data = alu_reg_h.read(t_in.addr);
      end
      else begin
        alu_reg_h.write(t_in.addr, t_in.wr_data);
      end

    end
  
  return t_out;
  
  endfunction

endclass

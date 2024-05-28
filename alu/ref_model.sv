class ref_model;
 

 function my_transaction step(my_transaction tr);

// reset 
 if (!tr.rst_n) begin
    tr.Y = 0;
    return tr;
 end
    case (tr.mode)
        2'b00: tr.Y = plus(tr.A, tr.B);
        2'b01: tr.Y = minus(tr.A, tr.B);
        2'b10: tr.Y = inc(tr.A);
        2'b11: tr.Y = inc(tr.B);
    endcase
    return tr;

 endfunction

   function bit[4:0] plus(bit[3:0] A, B);
        return A + B;
   endfunction

    function bit[4:0] minus(bit[3:0] A, B);
        return A - B;
    endfunction

    function bit[4:0] inc(bit[3:0] T);
        return T+1;
    endfunction
   
endclass
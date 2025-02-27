`include "interface.sv"
`include "tb_pkg.sv"
module top;
  import uvm_pkg::*;
  import tb_pkg::*;
  
  bit clk; // external signal declaration
  

  //instantiation of interface---> declared in interface.sv
  intf i_intf(clk);
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  RAM DUT(.clk(i_intf.clk),
                    .data_in(i_intf.data_in),
                    .data_out(i_intf.data_out),
                    .rst_p(i_intf.rst_p),
                    .addr(i_intf.addr),
                    .rdn_wr(i_intf.rdn_wr)
                     );
  //----------------------------------------------------------------------------               
  
  always #5 clk=~clk;

  initial begin
    clk=0;
  end
  
  //----------------------------------------------------------------------------
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  //----------------------------------------------------------------------------

  //setting the interface
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"","vif",i_intf);
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    run_test("test_write_read_all0");
  end
  //----------------------------------------------------------------------------
endmodule

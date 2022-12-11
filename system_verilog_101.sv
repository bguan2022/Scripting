interface ClockedBus (input Clk);
  logic[7:0] Addr, Data;
  logic RWn;
endinterface

module RAM (ClockedBus Bus);
  always @(posedge Bus.Clk)
    if (Bus.RWn)
      Bus.Data = mem[Bus.Addr];
    else
      mem[Bus.Addr] = Bus.Data;
endmodule


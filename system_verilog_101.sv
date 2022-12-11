// -------- Interface -----------
//
//-------------------------------
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

// ---------- Task -----------
//
//-------------------------------
  interface MSBus (input Clk);
    logic [7:0] Addr, Data;
    logic RWn;

    task MasterWrite (input logic [7:0] waddr,
                      input logic [7:0] wdata);
      Addr = waddr;
      Data = wdata;
      RWn = 0;
      #10ns RWn = 1;
      Data = 'z;
    endtask

    task MasterRead (input  logic [7:0] raddr,
                     output logic [7:0] rdata);
      Addr = raddr;
      RWn = 1;
      #10ns rdata = Data;
    endtask
  endinterface




// ------------------------------ Interface ---------------------------------
//
//---------------------------------------------------------------------------
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

// ---------------------------------- Task ----------------------------------
//
//---------------------------------------------------------------------------
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


//-----------------------------------------Mailbox-------------------------------------
// One process can put data into a mailbox that stores data internally and can be retrieved by another process. 
// Mailbox behaves as first-in, first-out (FIFO).
//
// Task: put (store data)   get (read out)  peek (make a copy)
//
// you can have bounded (limited fifo size) or unbounded (unlimited fifo size)
//-------------------------------------------------------------------------------------

module mailbox_example();
  mailbox mb = new(3);
  
  task process_A();
    int value = 5;
    string name = "STRING";
    mb.put(value);
    $display("Put data = %0d", value);
    mb.put("STRING");
    $display("Put data = %s", name);
  endtask

  task process_B();
    int value;
    string name;
    mb.get(value);
    $display("Retrieved data = %0d", value);
    mb.get(name);
    $display("Retrieved data = %s", name);
  endtask
  
  initial begin
    fork
      process_A();
      process_B();
    join
  end
endmodule





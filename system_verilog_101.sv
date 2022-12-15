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


// ------------------------------ Assertion ---------------------------------
// 1. Immediate Assertions
// 2. Concurrent Assertions
// 3. Implication
// 4. Properties and Sequences
// 5. Assertion Clocking
//---------------------------------------------------------------------------
 
// 1. Immediate Assertions
    assert (A == B) $display ("OK. A equals B");
                  else $error("It's gone wrong");


// 2. Concurrent Assertions 
  assert property (@(posedge Clock) Req |-> ##[1:2] Ack);
  
//Req is asserted, Ack must be asserted on the next clock, or the following clock.
      
// 3. Implication 
      //There are two forms of implication: overlapped using operator |->, and non-overlapped using operator |=>.
       
      s1 |=> s2;
      
      //if the sequence s1 matches, then sequence s2 must also match. If sequence s1 does not match, then the result is true.

// 4. Properties and Sequences
        property not_read_and_write;
                not (Read && Write);
        endproperty assert property (not_read_and_write);
            
// 5. Assertion Clocking
        sequence s;
            @(posedge clk) a ##1 b;
        endsequence
        
        property p;
            a |-> s;
        endproperty
        assert property (p);     

            
// ----------------------Thread--------------------------------------------
//
//-------------------------------------------------------------------------     
 initial begin 
            fork
                thread_1; 
                thread_2;
                thread_3;
            join 
     some_other_task;
 end 

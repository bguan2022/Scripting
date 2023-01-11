module edge_detect #(
    parameter EDGE_DETECTED = "rising"
) (
   input        clk,
   input        in,
   output logic edge_out
);

   logic in_d1;

   always_ff @ (posedge clk) begin
      in_d1 <= in;
   end

   always_comb begin
      if(EDGE_DETECTED == "rising") begin
         edge_out = in && !in_d1;
      end else if(EDGE_DETECTED == "falling") begin
         edge_out = !in && in_d1;
      end else if(EDGE_DETECTED == "both") begin
         edge_out = in ^ in_d1;
      end
   end

endmodule

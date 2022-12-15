   // binary to gray conversion to help CDC
   function [GW-1:0] bin2gray (input [GW-1:0] b);
      integer i;
      begin
         for(i=GW-1;i>=0;i=i-1) begin
            if (i==(GW-1)) begin
               bin2gray[i] = b[i];
            end else begin
               bin2gray[i] = b[i] + b[i+1];
            end
         end
      end
   endfunction

   // gray to binary conversion to help CDC
   function [GW-1:0] gray2bin (input [GW-1:0] g);
      integer i;
      begin
         for(i=GW-1;i>=0;i=i-1) begin
            if (i==(GW-1)) begin
               gray2bin[i] = g[i];
            end else begin
               gray2bin[i] = g[i] + gray2bin[i+1];
            end
         end
      end
   endfunction

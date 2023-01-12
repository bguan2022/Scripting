DMA modes (cycle stealing, transparent and burst)

 The fundamental difference between bus mastering and the use of a DMA controller is that DMA compatible devices must contain a DMA engine driving the memory transfers. As multiple PCI devices can master the bus,arbitration scheme is required to avoid that more than one device drives the bus simultaneously.
 
Today’s computers don’t contain DMA controllers anymore. PCIe connects each device with a dedicated, bi-directional link to a PCIe switch. As a result, PCIe supports full duplex DMA transfers of multiple devices at the same time. 

First, the peripheral device’s DMA engine is programmed with the source and destination addresses of the memory ranges to copy. Second, the device is signaled to begin the DMA transfer.he device raises interrupts to inform the CPU about transfers that have finished. For each interrupt an interrupt handler, previously installed by the driver, is called and the finished transfer can be acknowledged accordingly by the OS.

 Virtual memory is usually organized in chunks of 4 KiB, called pages. Virtual memory is continuous as seen from a process’ point-of-view thanks to page tables and the memory management unit (MMU). Usually, in a single DMA transfer only one page could be copied at a time. To overcome this limitation OS usually provide a scatter/gather API. Such an API chains together multiple page-sized memory transfers by creating a list of addresses of pages to be transferred.

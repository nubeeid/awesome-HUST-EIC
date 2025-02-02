## SPI及综合

1. 在标准 SPI 外部总线中，SS（Slave Select）信号线用于选择从设备，通常由主设备控制。在 SPI 总线通信期间，需要将要通信的从设备的 SS 信号维持低电平，以表明该从设备正在被选择并进行通信。当通信结束后，主设备会将 SS 信号恢复为高电平，表示该从设备不再被选择 

2. **MOSI**（Master Output, Slave Input）：主机输出从机输入信号（数据由主机发出） **MISO**（Master Input, Slave Output）：主机输入从机输出信号（数据由从机发出） 

3. 理由同上

4. 数据从主设备发送到从设备，要实现AXI QSPI IP核作为主设备，中断方式控制数据传输，此时数据将要被写入到`SPIDTR`中，这时将会触发`数据发送寄存器空`中断

5. 如果需要设置`QSPI IP`核的工作方式，需要写`SPICR`,`SPISR`用于指示SPI工作状态

6. `CPOL`表示空闲时时钟为高电平还是低电平，`CPHA`表示数据信号在时钟第二个边沿稳定有效还是第一个边沿， 时序图中下降沿采样数据,空闲时可以有时钟信号,表示空闲时既可以是高电平,也可以是低电平,当`CPOL=1`,空闲时高电平时,下降沿为第一个边沿,即`CPHA=0`; 当`CPOL=0`,空闲时低电平时,下降沿为第二个边沿,即`CPHA=1`; 

   并且需要着重说明，从图中可以看出，当CP时钟的上升沿到来时，数据获取将会发生反转，当下降沿来临时，数据将会保持，这时才能从寄存器中将数据读取出来，即采样信号动作完成

7. 理由同上，时序图中下降沿采样数据,空闲时可以有时钟信号,表示空闲时既可以是高电平,也可以是低电平,当CPOL=1,空闲时高电平时,下降沿为第一个边沿,即CPHA=0; 当CPOL=0,空闲时低电平时,下降沿为第二个边沿,即CPHA=1; 

8. 产生中断的原因有很多，除了一些接口设置或者协议的错误外，常见的中断包括：

   - 数据接收寄存器/FIFO过载 （过载表示，数据接收端接受了超过自身容量的数据，即将发生溢出）
   - 数据接收寄存器/FIFO满 
   - 数据发送寄存器/FIFO欠载 （欠载表示，发送寄存器无数据，将要发生执行空发送的情况）
   - 数据发送寄存器/FIFO空 

9.  设置IP核设备选择寄存器时，注意是`SPISSR`而非`SPICR`，来完成从设备的选择，并且输出的一般是`SS`，高电平表示选中

10. 屏蔽中断的时候考虑使用`IER`来完成中断的允许，并且只需要设置对应标志位即可

11. 快速中断需要将函数句柄填入`INTC`的`IVAR`寄存器中，来完成函数的注册工作，其中`Timer`中断函数的偏移地址为`0x10`，`SPI`的偏移地址为`0x24`一般用宏来完成设置

12. 根据功能选择即可


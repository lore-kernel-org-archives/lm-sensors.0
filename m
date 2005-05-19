From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: New bus driver for Xilinx Virtex-II Pro (FPGA with a PowerPC 405)
Message-Id: <3D8D1876.E532B289@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D7FAE37.D4D6D006@mvista.com>
In-Reply-To: <3D7FAE37.D4D6D006@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I skimmed the code referenced below. It does not use the linux i2c stack
at all.
There is obviously a large amount of duplication between this code and
the
linux i2c stack. For example, the bus scanning in i2c-algo-xilinx.c, and
most of xiic_master.c.

I suggest you familiarize yourself with our i2c stack and the interface
to it,
then you should be able to write a much smaller driver. There are plenty
of examples
in kernel/busses in our package.
You may not even need separate algo and adap drivers.

good luck.
mds

Scott Anderson wrote:
> 
> Hi all,
> 
> I developed a I2C bus driver for Xilinx for that Virtex-II Pro product.
> The I2C interface is implemented as IP in the FPGA.  Xilinx provides OS
> independent drivers that they encourage using due to the fluid nature of
> the FPGA implementation.  Then an OS dependent driver is crafted to call
> the OS independent functions.  This fit quite well with the I2C
> adapter/algorithm split.  I treated their code as the adapter and wrote
> an algorithm to sit on top of that.
> 
> Recently, Xilinx gave their permission to allow the code to be pushed
> out to public trees.  As part of pushing out the support for the
> platform, I pushed out my initial I2C bus driver into a Linux PowerPC
> tree:
> http://ppc.bkbits.net:8080/linuxppc_2_4_devel/src/drivers/i2c/xilinx_iic?nav=index.html|src/.|src/drivers|src/drivers/i2c
> 
> I am now able to start the process of making it "official", so I am in
> need of having a couple of IDs reserved: one for the adapter and one for
> the algorithm.  I was thinking that I2C_HW_XILINX and I2C_ALGO_XILINX
> might make sense.  Then I can start working through the rest of the list
> posted at:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/new_drivers
> 
> Let me know if you have any questions/concerns and I'll try to address
> them.  Thanks much,
>     Scott Anderson
>     scott_anderson@mvista.com   MontaVista Software Inc.
>     (408)328-9214               1237 East Arques Ave.
>     http://www.mvista.com       Sunnyvale, CA  94085

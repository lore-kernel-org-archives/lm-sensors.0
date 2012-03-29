From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Mar 2012 12:56:00 +0000
Subject: Re: [lm-sensors] Question regarding designing hardware for use with lm-sensors
Message-Id: <20120329145600.148fcf8e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F63B087.6010205@dinigroup.com>
In-Reply-To: <4F63B087.6010205@dinigroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivan,

On Fri, 16 Mar 2012 14:28:39 -0700, Ivan Yulaev wrote:
> Dear lm-sensors mailing list members,
> 
> I'm an engineer currently working on the design of a small FPGA board that will be hosted in a PCIe slot. For our previous products we've rolled our own temperature monitoring software. For a new project, I'd like to try designing our board such that lm-sensors can query the temperature of the board. I'm very shaky on my understanding of how lm-sensors queries the temperature of a PCIe card, f.ex. a graphics card. Here is my mental model, which needs filling in:
> 
> lm-sensors ---> ????? --- (iic bus) --> iic temp sensor

If you are going for an I2C/SMBus temperature sensor:

sensors(1) --> libsensors --> sysfs --> temperature sensor driver --> i2c bus driver --> i2c bus --> temperature sensor chip

But you may also implement the whole thing without involving I2C/SMBus:

sensors(1) --> libsensors --> sysfs --> temperature sensor driver --> temperature sensor chip

This is what most recent AMD Radeon and Nvidia Geforce graphics
adapters do. The temperature sensor is embedded in the graphics chip
and accessed through PCI directly.

> My first impulse was to host the temperature sensor on the SMBus pins on the PCIe slot directly, ADM1033 comes to mind. However, it looks like I need to use a sensor that implements ARP, which is not very common. Also it looks like lm-sensors does not really support ARP so this seems like it would be an uphill fight.

The Linux kernel doesn't support SMBus ARP, correct. It doesn't yet
support the ADM1033 either, but there are so many supported chips that
I'm sure you can find one suiting your needs:
  http://www.lm-sensors.org/wiki/Devices
If you really want the ADM1033, the datasheet is publicly available so
writing a driver is possible. Be aware though that the ADM1033 uses the
same address range as SPD EEPROMs so connecting an ADM1033 to the SMBus
directly isn't an option.

> For graphics cards and other PCIe subsystems, is the iic temp sensor hosted on the card's PCIe controller chip and queried through the main PCIe data interface then? And the "dedicated" SMbus lines on the PCIe interface are unused? If so, is the model then something like this?
> 
> lm-sensors ---> vendor-provided driver for PCIe product ---> PCIe data interface ---> PCIe controller on daughter card --- (iic bus) ---> temp sensor

Yes, this is what PCIe cards usually do when they don't embedded the
thermal sensor directly. This is relatively natural for graphics
adapters because they already need to support I2C to be able to talk
(over DDC) to the display. Adding an SMBus temperature sensor chip
almost comes for free.

The advantage here is that you no longer need ARP, as you control the
address of every chip on your I2C bus.

> If so, it seems like I'd have to provide some (standard?) hooks in my PCIe driver for the temperature sensor, that allow me to communicate to the IIC bus on the card. And I need to have corresponding registers on my card's controller that can be used to talk to the IIC lines there.

This is one possibility. The other, cheaper possibility is to simply
use 2 bidirectional (otherwise 4) GPIO pins on your chip for I2C bus
connection, and use the generic i2c-algo-bit software bit-banging
driver. This is more CPU intensive and can be problematic in high
latency environments, but it is also a lot more simple to design from a
hardware perspective. FWIW, most graphics adapter drivers support both,
using hardware engines when the driver and the hardware support it
properly, and falling back to software bit banging when not.

> I'd also appreciate it if you could refer me to any documentation that would be useful for understanding the general field of this inquiry, the PCI Express specification wasn't very useful in this regard.

I'm afraid we do not have documentation available addressing this point
specifically.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

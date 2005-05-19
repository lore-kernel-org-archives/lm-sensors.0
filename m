From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: gs10
Message-Id: <20041004083529.M40390@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041003231641.M43741@palei.com>
In-Reply-To: <20041003231641.M43741@palei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

> If I do a modprobe pc87360 it returns
> 
> /lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o:
> init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters, including
> invalid IO or IRQ parameters.
>      You may find more information in syslog or the output from dmesg
> /lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o:
> insmod /lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o
> failed
> /lib/modules/2.4.22-1.2115.nptl/kernel/drivers/i2c/chips/pc87360.o: insmod
> pc87360 failed
> 
> (...)
> 
> Driver `pc87360' (should be inserted):
>  Detects correctly:
>  * ISA bus address 0x0820 (Busdriver `i2c-isa')
>    Chip `Nat. Semi. PC87366 Super IO Fan Sensors' (confidence: 9)
>  * ISA bus address 0x0830      (Busdriver `i2c-isa')
>    Chip `Nat. Semi. PC87366 Super IO Voltage Sensors' (confidence: 9)
>  * ISA bus address 0x0860 (Busdriver `i2c-isa')
>    Chip `Nat. Semi. PC87366 Super IO Thermal Sensors' (confidence: 9)

I suspect that the PC87366 chip is located on the secondary Super-I/O address.
The sensors-detect script supports that, but the pc87366 driver doesn't (yet).
You can check the output of sensors-detect for confirmation, as both Super-I/O
addresses are checked sequentially.

Untested patch to pc87360.c attached, may or may not work. Let me know ;)

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87360.c.diff
Type: application/octet-stream
Size: 3705 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041004/23bee724/pc87360.c.obj

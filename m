From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Sep 2009 07:56:19 +0000
Subject: Re: [lm-sensors] Supermicro X7DWN+ info
Message-Id: <20090919095619.7e36cd3d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AA55777.6050806@cern.ch>
In-Reply-To: <4AA55777.6050806@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Adrian,

On Mon, 7 Sep 2009 21:56:55 +0300, Adrian Sevcenco wrote:
> I would need some advice about creating the sensors3.conf for Supermicro 
>   X7DWN+ motherboard ..
> 
> what chip should i use? in my centos 5.3 i have driver only up to w83792d
> 
> also is not very clear to me what do i do with the offsets of various 
> data (in sensors example the line with offsets is only a comment ... )
> 
> i have the following info from vendor :
> (it seems that the info is common for X7DW3, X7DWN, X7DWA, X7DBI, X7DBU, 
> X7DBN)
> 
> Bus Type = SMBus
> One W83793G

So, the board has a Winbond W83783G and your OS doesn't support this
chip. It should be pretty clear at this point that it's simply not
going to work, no matter what you put in sensors3.conf.

You either need to upgrade to a more recent OS, or backport the w83793
driver to your OS. The latter shouldn't be too difficult, I know a
number of people have done that already, as apparently boards with
Winbond W83793G chips are popular amongst RHEL 5 / CentOS 5 users.

If you don't know how to do this, you can try to find a kernel
developer who will do it for you. That could be me, if you have a piece
of hardware you no longer need and you wouldn't mind shipping it to me:
http://khali.linux-fr.org/wishlist.html

> Windbond W83793G, Slave Address=0x2f (0x5E in 8-Bit format)
> ==============================> Fan1 Fan Speed, Offset 0x23, 0x24		RPM = 1350000/Data
> Fan2 Fan Speed, Offset 0x25, 0x26		RPM = 1350000/Data
> Fan3 Fan Speed, Offset 0x27, 0x28		RPM = 1350000/Data
> Fan4 Fan Speed, Offset 0x29, 0x2a		RPM = 1350000/Data
> Fan5 Fan Speed, Offset 0x2b, 0x2c		RPM = 1350000/Data
> Fan6 Fan Speed, Offset 0x2d, 0x2e		RPM = 1350000/Data
> Fan7/CPU1 Fan Speed, Offset 0x2f, 0x30		RPM = 1350000/Data
> Fan8/CPU2 Fan Speed, Offset 0x31, 0x32		RPM = 1350000/Data
> CPU1 Core Voltage, Offset 0x10			Voltage = Data* 0.008		
> CPU2 Core Voltage, Offset 0x11			Voltage = Data* 0.008
> 
> -12V Voltage, Offset 0x14	Voltage > ((Data*0.016) - (2.048*(232./260.)))/(1-(232./260.))
> 
> +1.5V Voltage, Offset 0x15			Voltage = Data* 0.016
> +3.3V Voltage, Offset 0x16			Voltage = Data* 0.016
> +12V Voltage, Offset 0x17           Voltage = Data* 0.008/ (10./120.)
> +5V Voltage, Offset 0x18			Voltage = Data* 0.024
> 5Vsb Voltage, Offset 0x19			Voltage = Data* 0.024
> Battery Voltage, Offset 0x1a			Voltage = Data* 0.016
> 
> CPU1 CoreA (PECI Agent1) Temperature, Offset 0x1c	Temperature = Data
> 
> CPU1 CoreB (PECI Agent2) Temperature, Offset 0x1d	Temperature = Data
> 
> CPU2 CoreA (PECI Agent3) Temperature, Offset 0x1e	Temperature = Data
> 
> CPU2 CoreB (PECI Agent4) Temperature, Offset 0x1f	Temperature = Data
> 
> System Temperature, Offset 0x20			Temperature = Data
> Chassis Intrusion, Offset 0x44, BitMask 0x40	1 = Bad, 0 = Good

That's the nice thing with Supermicro: they provide all the technical
data one needs to refine the sensors configuration. With the above you
can write a perfect custom sensors3.conf file for your board. All you
have to do is cross-check the register addresses (named "offset" in the
above document) with either the driver source code or the datasheet.

> Windbond W83627HF
> ==============================> Power Supply Failure, GP11(From W83627HF)	1 = Good, 0 = Bad

This last feature we unfortunately do not support (yet).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

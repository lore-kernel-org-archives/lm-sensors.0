From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Fri, 18 Feb 2011 19:35:10 +0000
Subject: Re: [lm-sensors] w83795 & Supermicro H8DTI
Message-Id: <153DDBFB46D344D2ACBD67612E414194@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-2945170@free.net>
In-Reply-To: <web-2945170@free.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



--------------------------------------------------
From: "Mikhail Kuzminsky" <kus@free.net>
Sent: Friday, February 18, 2011 8:15 PM
To: <lm-sensors@lm-sensors.org>
Subject: [lm-sensors] w83795 & Supermicro H8DTI

> We use 64 bit OpenSuSE kernel 2.6.27 (patched for right numactl work) 
> w/OpenSuSE sensors 3.0.3 (w/libsensors4) packages installed.
>
> Motherboard Supermicro X8DTI has w83795adg (I beleive) chip, and I 
> obtained from Supermicro Tech Support the necessary data (see below) for 
> /etc/sensors3.conf
>
> 1) 1st of all, I need to install "stand-alone" w83795 driver for my 
> kernel.    Do I understand correctly that simple issuing of "make all" 
> under root is enough ?
> (of course, I do not say about w83795 loading).
>
> 2) Am I right in a pair of "compute" statements for in3 and in4 values:
>
> compute in3 @*0.032, @/0.032
> compute in4 @*0.008*6.62, @/0.008/6.62
>
> if I base on data supplied by Supermicro (below, they are for 5V and 12V) 
> ?
> ==Supermicro data=========> Bus Type = SMBus
> One W83795AG
>
> Windbond W83795AG, Slave Address=0x2f (0x5E in 8-Bit format)
> ==============================> Fan1 Fan Speed, Offset 0x2e RPM = 84375/Data
> Fan2 Fan Speed, Offset 0x30 RPM = 84375/Data
> Fan3 Fan Speed, Offset 0x35 RPM = 84375/Data
> Fan4 Fan Speed, Offset 0x31 RPM = 84375/Data
> Fan5 Fan Speed, Offset 0x34 RPM = 84375/Data
> Fan6 Fan Speed, Offset 0x32 RPM = 84375/Data
> Fan7 Fan Speed, Offset 0x2f RPM = 84375/Data
> Fan8 Fan Speed, Offset 0x33 RPM = 84375/Data
> CPU1 Voltage, Offset 0x11 Voltage = Data* 0.008
> CPU2 Voltage, Offset 0x10 Voltage = Data* 0.008
> +5V Voltage, Offset 0x13 Voltage = Data* 0.008 * (40/10)
> +12V Voltage, Offset 0x14 Voltage = Data* 0.008/ (10./66.2)
> CPU1 DIMM Voltage, Offset 0x17 Voltage = Data* 0.008
> CPU2 DIMM Voltage, Offset 0x16 Voltage = Data* 0.008
> +1.5V Voltage, Offset 0x12 Voltage = Data* 0.008
> +3.3V Voltage, Offset 0x1c Voltage = Data* 0.024
> +3.3VSB Voltage, Offset 0x1d Voltage = Data* 0.024
> Battery Voltage, Offset 0x1e Voltage = Data* 0.024
> CPU1 Temperature, Offset 0x26 Temperature = Data
> CPU2 Temperature, Offset 0x27 Temperature = Data
> System Temperature, Offset 0x1f Temperature = Data
> Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40 1 = Bad, 0 = Good
> (Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)
>
>
> Power Supply Failure, GP11(From W83627HF) 1 = Good, 0 = Bad
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

Hi,

just download the driver, the make file and i2c-compat.h  from 
http://khali.linux-fr.org/devel/misc/w83795/ the do a make && make install

That should be enough to install the driver for your kernel. A modprobe 
w83795 should then load the driver and sensors should show values :)

Regards
Ian Dobson 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

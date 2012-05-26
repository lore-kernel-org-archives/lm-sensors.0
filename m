From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 May 2012 07:40:45 +0000
Subject: Re: [lm-sensors] Supermicro X8DTN config file
Message-Id: <20120526094045.70e75e8a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120525111056.3b0ec381.gem@rellim.com>
In-Reply-To: <20120525111056.3b0ec381.gem@rellim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gary,

On Fri, 25 May 2012 11:10:56 -0700, Gary E. Miller wrote:
> Yo lm-sesors!
> 
> See below for a working sensors3.conf file for the Supermicro X8DTN
> motherboard.
> 
> How do I get it posted on the wiki for others to use?

I've just done it [1], thanks for your contribution. See my comments
inline below.

[1] http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X8DTN

> # /etc/sensors.d/X8DTN
> # settings for the supermicro X8DTN
> # originally written by Gary E. Miller <gem@rellim.com>
> # use at your own risk !
> # Date: 25 May 2012
> 
> # Here's the info as supplied by Supermicro:
> 
> #
> # Bus Type = ISAIO/SMBus
> # One W83795AG
> # 
> # Windbond W83795AG, Slave Address=0x2f (0x5E in 8-Bit format)
> # ==============================> # Fan1 Fan Speed, Offset 0x2e		RPM = 84375/Data
> # Fan2 Fan Speed, Offset 0x2f		RPM = 84375/Data
> # Fan3 Fan Speed, Offset 0x30		RPM = 84375/Data
> # Fan4 Fan Speed, Offset 0x31		RPM = 84375/Data
> # Fan5 Fan Speed, Offset 0x32		RPM = 84375/Data
> # Fan6 Fan Speed, Offset 0x33		RPM = 84375/Data
> # Fan7 Fan Speed, Offset 0x34		RPM = 84375/Data
> # Fan8 Fan Speed, Offset 0x35		RPM = 84375/Data
> # CPU1 Voltage, Offset 0x10		Voltage = Data* 0.008
> # CPU2 Voltage, Offset 0x11		Voltage = Data* 0.008
> # +1.5V Voltage, Offset 0x12		Voltage = Data* 0.008
> # +5V Voltage, Offset 0x13		Voltage = Data* 0.008 * (40/10)
> # +12V Voltage, Offset 0x14		Voltage = Data* 0.008/ (10./66.2)
> # +5VSB Voltage, Offset 0x15		Voltage = Data* 0.008 * (40/10)
> # +3.3V Voltage, Offset 0x1c		Voltage = Data* 0.024
> # +3.3VSB Voltage, Offset 0x1d		Voltage = Data* 0.024
> # Battery Voltage, Offset 0x1e		Voltage = Data* 0.024
> # CPU1 Temperature, Offset 0x27		Temperature = Data
> # CPU2 Temperature, Offset 0x26		Temperature = Data
> # System Temperature, Offset 0x1f		Temperature = Data
> # Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40	1 = Bad, 0 = Good
> #		 (Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)
> # 
> # 
> # Power Supply Failure, GP11(From W83627HF)		1 = Good, 0 = Bad
>  
> chip "w83627hf-isa-0a00"
>     # I'm not sure which is GP11, so I turned off everything.

It is neither. GP11 is a GPIO pin, not supported by the w83627hf driver.

If you are going to ignore all the inputs then it is more efficient to
not load the w83627hf driver at all.

>     ignore in0
>     ignore in1
>     ignore in2
>     ignore in3
>     ignore in4
>     ignore in5
>     ignore in6
>     ignore in7
>     ignore in8
>     ignore cpu0_vid
>     ignore fan1
>     ignore fan2
>     ignore fan3
>     ignore temp1
>     ignore temp2
>     ignore temp3
>  
> bus "i2c-0" "SMBus I801 adapter at 0400"
> 
> chip "w83795adg-i2c-0-2f"
> 
> # Voltages ; note that in the table above, the .008 and .024 factors are
> # already computed in the driver...
> 
>     label in0 "CPU1"
>     label in1 "CPU2"
>     label in2 "+1.5V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "5VSB"
>     label in11 "Vtt"

It seems pointless to define a label for an input you ignore a few
lines below. To avoid this kind of issue, I tend to interleave label
and ignore statements in my configuration files.

>     label in12 "+3.3V"
>     label in13 "3VSB"
>     label in14 "Vbat"
> 
>     compute in3 @*4, @/4
>     compute in4 @*6.62, @/6.62
>     compute in5 @*4, @/4
>     compute in6 @*3, @/3

Likewise, it seems pointless to define a compute statement for an input
you ignore a few lines below.

> 
>     label temp3 "unused"
>     label temp4 "unused"

Here again...

>     label temp5 "mobo"
>     label temp7 "CPU1"
>     label temp8 "CPU2"

The information provided by the vendor suggests that temp7 is CPU2 and
temp8 is CPU1.

> 
>     ignore in6
>     ignore in7
>     ignore in11
>     ignore temp3
>     ignore temp4
>     ignore fan4
>     ignore fan5
>     ignore fan6
>     ignore fan7
>     ignore fan8

I've dropped the ignore statements for fan inputs, as I seem to
understand fan headers do exist on the board, just you aren't using
them.

> 
>     set in0_min  0.82
>     set in0_max  1.35
>     set in1_min  0.82
>     set in1_max  1.35
>     set in12_min  3.3 * 0.90
>     set in12_max  3.3 * 1.10

You're being too tolerant at least for +3.3V, the ATX standard
specifies a +/- 5% margin.

>     set in13_min  3.3 * 0.90
>     set in13_max  3.3 * 1.10
>     set in14_min  3.0 * 0.90
>     set in14_max  3.3 * 1.10


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

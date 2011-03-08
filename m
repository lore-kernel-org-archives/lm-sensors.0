From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Mar 2011 17:29:52 +0000
Subject: Re: [lm-sensors] w83795 & Supermicro H8DTI
Message-Id: <20110308182952.3cd1ad21@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-2945170@free.net>
In-Reply-To: <web-2945170@free.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mikhail,

Sorry for the late answer. I am the (co-)author of the w83795 Linux
driver.

On Fri, 18 Feb 2011 22:15:46 +0300, Mikhail Kuzminsky wrote:
> We use 64 bit OpenSuSE kernel 2.6.27 (patched for right numactl work) 
> w/OpenSuSE sensors 3.0.3 (w/libsensors4) packages installed.
> 
> Motherboard Supermicro X8DTI has w83795adg (I beleive) chip, and I 
> obtained from Supermicro Tech Support the necessary data (see below) 
> for /etc/sensors3.conf
> 
> 1) 1st of all, I need to install "stand-alone" w83795 driver for my 
> kernel.    
> Do I understand correctly that simple issuing of "make all" under root 
> is enough ?
> (of course, I do not say about w83795 loading).

Not sure what you mean with "under root". If you meant "as root user",
then please no, _never_ build software as root user. Build as a regular
user and only install as root. Other than this, yes, "make" as a
regular user and "make install" as root should be enough, although you
may have to do it again whenever you upgrade your kernel.

> 2) Am I right in a pair of "compute" statements for in3 and in4 
> values:
> 
> compute in3 @*0.032, @/0.032
> compute in4 @*0.008*6.62, @/0.008/6.62
>
> if I base on data supplied by Supermicro (below, they are for 5V and 
> 12V) ? 

No. The 0.008 above corresponds to the ADC resolution, and the driver
handles it. The only part of the conversion which goes in the
configuration file is the external scaling factor.

So you want:

   compute  in3  @ * 4,    @ / 4
   compute  in4  @ * 6.62, @ / 6.62

> 
> ==Supermicro data=========> Bus Type = SMBus
> One W83795AG
> 
> Windbond W83795AG, Slave Address=0x2f (0x5E in 8-Bit format)
> ==============================> Fan1 Fan Speed, Offset 0x2e		RPM = 84375/Data
> Fan2 Fan Speed, Offset 0x30		RPM = 84375/Data
> Fan3 Fan Speed, Offset 0x35		RPM = 84375/Data
> Fan4 Fan Speed, Offset 0x31		RPM = 84375/Data
> Fan5 Fan Speed, Offset 0x34		RPM = 84375/Data
> Fan6 Fan Speed, Offset 0x32		RPM = 84375/Data
> Fan7 Fan Speed, Offset 0x2f		RPM = 84375/Data
> Fan8 Fan Speed, Offset 0x33		RPM = 84375/Data

Apparently the SuperMicro engineers had fun with the fan numbering ;)
This can be translated to the following configuration statements:

   label  fan1  "Fan 1"
   label  fan2  "Fan 7"
   label  fan3  "Fan 2"
   label  fan4  "Fan 4"
   label  fan5  "Fan 6"
   label  fan6  "Fan 8"
   label  fan7  "Fan 5"
   label  fan8  "Fan 3"

> CPU1 Voltage, Offset 0x11		Voltage = Data* 0.008
> CPU2 Voltage, Offset 0x10		Voltage = Data* 0.008
> +5V Voltage, Offset 0x13		Voltage = Data* 0.008 * (40/10)
> +12V Voltage, Offset 0x14		Voltage = Data* 0.008/ (10./66.2)
> CPU1 DIMM Voltage, Offset 0x17		Voltage = Data* 0.008
> CPU2 DIMM Voltage, Offset 0x16		Voltage = Data* 0.008
> +1.5V Voltage, Offset 0x12		Voltage = Data* 0.008

No scaling needed except for +5V and +12V, already discussed above.

> +3.3V Voltage, Offset 0x1c		Voltage = Data* 0.024
> +3.3VSB Voltage, Offset 0x1d		Voltage = Data* 0.024
> Battery Voltage, Offset 0x1e		Voltage = Data* 0.024

These are already handled by the driver.

> CPU1 Temperature, Offset 0x26		Temperature = Data
> CPU2 Temperature, Offset 0x27		Temperature = Data
> System Temperature, Offset 0x1f		Temperature = Data

These correspond to temp7, temp8 and temp5, respectively. So:

   label  temp5  "Sys Temp"
   label  temp7  "CPU1 Temp"
   label  temp8  "CPU2 Temp"

> Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40	1 = Bad, 0 = Good
> 			(Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)

Supported by the driver, no configuration needed.

> Power Supply Failure, GP11(From W83627HF)		1 = Good, 0 = Bad

We don't have support for this feature.

I have come up with the following configuration file, please give it a
try:
http://khali.linux-fr.org/devel/lm-sensors/sensors3-Supermicro-H8DTI.conf

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

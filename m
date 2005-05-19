From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Problem with SiS950 on ECS MB
Message-Id: <3E6A8836.9010709@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6265CB.6030005@bellsouth.net>
In-Reply-To: <3E6265CB.6030005@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it87 alarm handling was changed long ago in sensors 2.6.2. You have a 'sensors'/libsensors mismatch,
one of them is very very old. Check /usr/lib for old libsensors files.
This may or may not fix your temps too.

Jeffrey B. Layton wrote:
> Hello,
> 
>   I'm trying to get sensors running on an ECS P6SSTP-FN
> motherboard (OK, I got them cheap :) The motherboard
> uses a SiS 630 chipset and looking at the board I see a SiS950
> chip, which I gather is a it87 clone.
>   The sensors-detect script seems to have some trouble
> since it keeps finding the sis5595 instead of the it87
> (well, the it87 has a lower confidence).
>   OK, no problem, so I load the it87 module. /etc/rc.d/rc.local
> looks like:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-isa
> modprobe i2c-proc
> modprobe i2c-dev
> # I2C chip drivers
> modprobe it87
> #----cut here----
> 
> and /etc/modules.conf looks like:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> Then I run /usr/bin/sensors and the output looks like:
> 
> it87-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> ERROR: Can't get fan alarm data!
> ERROR: Can't get vin alarm data!
> ERROR: Can't get temp alarm data!
> VCore 1:   +1.96 V  (min =  +1.53 V, max =  +1.87 V)
> VCore 2:   +2.46 V  (min =  +2.25 V, max =  +2.75 V)
> +3.3V:     +6.80 V  (min =  +2.96 V, max =  +3.60 V)
> +5V:       +5.07 V  (min =  +4.50 V, max =  +5.48 V)
> +12V:     +12.28 V  (min = +11.36 V, max = +13.80 V)
> -12V:     -24.41 V  (min = -10.80 V, max = -13.10 V)
> -5V:       -5.99 V  (min =  -4.54 V, max =  -5.43 V)
> Stdby:     +4.89 V  (min =  +4.50 V, max =  +5.48 V)
> in8:       +3.34 V
> fan1:     4753 RPM  (min = 3000 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)
> Temp1/MB:    -55?C  (min =  +20?C, max =  +60?C)
> Temp2/CPU:  -125?C  (min =  +20?C, max =  +60?C)
> 
> 
>   I would guess the temperatures are off by a bit. Does
> anyone have any suggestions?
>   Oh, BTW, this is a RH 7.3 install and I'm running a
> 2.4.21pre3 kernel with patches from JAM
> (http://giga.cps.unizar.es/~magallon/linux/kernel/) that
> contain lm-sensors from the 2.7.0 cvs tree on 1/23/03.
> I built the kernel and modules using gcc 3.2.2. I'm also
> attaching a gzipped file containing the output from
> sensors-detect (if it makes it past the email filters).
> 
> TIA!
> 
> Jeff
> 
> 
> 

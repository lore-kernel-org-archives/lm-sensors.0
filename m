From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Feedback + problem with cooling.
Message-Id: <3D0CDD0D.B07B819C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020616173854.151fa923.Jerome.KIEFFER@crans.org>
In-Reply-To: <20020616173854.151fa923.Jerome.KIEFFER@crans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

None of our drivers support auto-fan-speed.
In addition, the it87 driver resets the chip at initialization which
presumably sets the fans to max. Sorry.
You can either modify the driver to remove the chip reset and
other fan initializations, or if you like add auto-fan support
to the driver and submit a patch to us.


Jerome KIEFFER wrote:
> 
> Hello,
> 
> Here is a feed-back :
> lm-sensors (2.6.3) work under linux-2.4.19-pre10-ac2-preemp (please do
> not kick because I use an alpha version of the kernel) on the Shuttle
> FS40 Mobo ( http://www.shuttleonline.com/spec.php3?model=ss40 ) based on
> the SiS 740 Chipset (
> http://www.sis.com/products/chipsets/integrated/socketa/740fea.htm )
> This computer is an all in one barebone.
> 
> I loaded the following modules to make the sensors work :
> it87                    7104   0
> i2c-proc                6368   0  [it87]
> i2c-isa                 1220   0  (unused)
> 
> jerome@taz:~$ sensors
> it87-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.74 V  (min =  +1.53 V, max =  +1.87 V)
> VCore 2:   +1.93 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
> +3.3V:     +3.32 V  (min =  +1.48 V, max =  +1.80 V)   ALARM
> +5V:       +5.21 V  (min =  +4.50 V, max =  +5.48 V)
> +12V:     +11.52 V  (min = +11.36 V, max = +13.80 V)
> Stdby:     +5.16 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +0.00 V
> fan1:     3629 RPM  (min = 3000 RPM, div = 2)
> Temp1/MB:    +38?C  (min =  +20?C, max =  +60?C)
> Temp2/CPU:   +46?C  (min =  +20?C, max =  +60?C)
> Temp3/PSU:   +36?C  (min =  +20?C, max =  +60?C)
> 
> Well everything seems to work EXCEPT the "CPU-fan-auto-gardian", a
> system that modifies the fan speed according
> to the CPU temperature (set up in the bios). Now the fan is all the time
> at full speed and very loud (should be at 2000 rpm at 46?C.
> The fan speeds-up when I load the 2 modules so I think my problem has
> something to do with these modules and maybe your the right person to
> ask. I hope I gave all the details you may need.
> 
> Best regards and thanks for your work on lm-sensors.
> 
> --
> J?r?me @taz : Tbird900 + 512Mo DDR in a 10L SS40G
> "Windows 95 is a 32-bit shell for a 16-bit extension to an 8-bit
> operating system designed for a 4-bit microprocessor by a 2-bit company
> that can't stand one bit of competition."

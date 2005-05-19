From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: IT8705F Data Sheet and Help
Message-Id: <3BDF5651.775273C3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0110291635210.8084-100000@penguin.linuxhardware.org>
In-Reply-To: <Pine.LNX.4.21.0110291635210.8084-100000@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ITE http://www.ite.com.tw

See figure 10-4 and the following formulas in the 8705 and 8712
datasheets.
The 8705 datasheet I have has the wrong formula, the 8712 is right.
You need to know Rin, Rf, and Vref to compute the correct formula.
Unfortunately, since the datasheet doesn't give the board designer a
recommendation, you will have to find and measure the values on
your board.

I'll put the formulas in sensors.conf.eg so others can find it.

mds


Kris Kersey wrote:
> 
> Guys,
> 
> Could you help me get the math right on several of the IT8705F
> sensors?  The readout of my sensors is below.  There are definate problems
> with -12V, -5V, and Temp2/CPU.  It also seems that the Vcore 1 could be
> slightly off.  On my motherboard (SOYO K7V DRAGON Plus!) I also wanted
> note that there was no need to compute in2.  Finally, in the headers,
> there is an IN8 define and it doesn't appear that it should be
> there.  Help is appreciated but a link to the datasheet would also be nice
> if you don't have the time.
> 
> it87-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.85 V  (min =  +1.66 V, max =  +1.82 V)   ALARM
> VCore 2:   +2.48 V  (min =  +2.40 V, max =  +2.60 V)
> +3.3V:     +3.31 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +5.02 V  (min =  +4.72 V, max =  +5.24 V)
> +12V:     +12.00 V  (min = +11.36 V, max = +12.60 V)
> -12V:      -7.34 V  (min = -11.38 V, max = -12.53 V)   ALARM
> -5V:       -6.61 V  (min =  -4.70 V, max =  -5.15 V)   ALARM
> Stdby:     +4.99 V  (min =  +4.72 V, max =  +5.24 V)
> fan1:        0 RPM  (min =    0 RPM, div = 2)
> fan2:     5818 RPM  (min = 3000 RPM, div = 2)
> Temp1/MB:    +40C  (min =  +20C, max =  +40C)
> Temp2/CPU:  +114C  (min =  +25C, max =  +45C)
> 
> I used the latest sensors.conf.eg from CVS for above.  Note the changes
> mentioned.
> 
> Thanks,
> Kris Kersey
> LinuxHardware.org Site Manager
> augustus@linuxhardware.org

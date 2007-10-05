From: Stian Jordet <liste@jordet.net>
Date: Fri, 05 Oct 2007 16:40:22 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <1191602422.7443.10.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On fre, 2007-10-05 at 12:17 -0400, Yani Ioannou wrote:
> Hi Stian,
> 
> The reason I haven't merged ipmisensors into the kernel yet is this
> exactly, on some BMCs the code to convert sensor readings into human
> readable forms is just not working - this is practically the only code
> left over from bmcsensors  and I began re-writing it a few months ago
> but got busy with other stuff. I'd like to start that again though, so
> perhaps you could help ne test the new code when it is finished?
> 
> There are in fact some sensors we may never be able to convert
> completely in the kernel - they require complex transformations
> involving logarithms. etc, that kernel code simply can't (and
> shouldn't) calculate, so I think the real solution to this will have
> to involve userspace support.
> For now could you list the results from lmsensors and ipmitool so they
> can be compared?

Yani,

I see. I would very much like to test new code :) I'm now running a
lm-sensors svn snapshot from yesterday, after Jean Delvare said that
there was an bug in the earlier lm-sensors causing sensor channel
numbers to be shifted. Upgrading to latest svn snapshot made my voltages
look better (but still not good), while all but one temperature got
divided by 10 (!).

ipmitool doesn't work, I guess because my board only supports IPMI 0.9.
But ipmiutil somehow works (partly). I cuts some of the sensor names,
and doesn't give human readable values, but when I for instance remove a
fan, the value changes to 0000 at the end. (And the name of the fan is
the same as the name on the pcb where I unplug it (same goes with
PSU's), so it surely makes some sense).

This is from lm-sensors:

bmc-isa-0003
Adapter: ISA adapter
SCSI-N Volt:
           +1.33 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 1.5V:
           +1.98 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 2.5V:
           +1.87 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 3.3V:
           +3.06 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 12V:
          +15.68 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 5V:
           +4.79 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard -12V:
          -12.11 V  (min =  +0.00 V, max =  +0.00 V)
PwrShare Fan 3:
          4740 RPM  (min =    0 RPM)
PwrShare Fan 2:
          2550 RPM  (min =    0 RPM)
PwrShare Fan 1:
          2550 RPM  (min =    0 RPM)
Baseboard Fan 6:
          2610 RPM  (min =    0 RPM)
Baseboard Fan 7:
          2730 RPM  (min =    0 RPM)
Baseboard Fan 8:
          2850 RPM  (min =    0 RPM)
Baseboard Fan 5:
          2880 RPM  (min =    0 RPM)
Baseboard Fan 3:
          2730 RPM  (min =    0 RPM)
Baseboard Fan 4:
          3000 RPM  (min =    0 RPM)
Baseboard Fan 1:
          2760 RPM  (min =    0 RPM)
PwrShare Temp:
           -12.8 C  (high =    +0 C, hyst =    +0 C)  
Processor 4 Temp:
            +6.1 C  (high =    +0 C, hyst =    +0 C)  
Processor 3 Temp:
            +2.6 C  (high =    +0 C, hyst =    +0 C)  
Processor 2 Temp:
            +2.7 C  (high =    +0 C, hyst =    +0 C)  
Processor 1 Temp:
            +2.5 C  (high =    +0 C, hyst =    +0 C)  
Basebrd PXB Temp:
            +2.5 C  (high =    +0 C, hyst =    +0 C)  
Basebrd PCI Temp:
            +3.1 C  (high =    +0 C, hyst =    +0 C)  


And here is the ipmiutil sensor output. As you can see, the "comp"
sensors gets their name cut. But ipmisensors can read the whole name,
like: ipmisensors: skipping non-threshold sensor "PwrShare Sup 1"

ipmiutil ver 2.0
sensor: version 1.59
-- BMC version 0.35, IPMI version 0.1 
_ID_ SDR_Type_xx Sz Own Typ S_Num Sens_Description   Hex & Interp Reading
0020 SDR Full 01 39 20 a f8 snum 04 Baseboard -12V   = 6a OK*  2520000212.00 unspecified
4020 SDR Full 01 3b 20 a f8 snum 14 Basebrd PCI Temp = 9a OK*  2360079156.00 unspecified
8020 SDR Full 01 3b 20 a f8 snum 15 Basebrd PXB Temp = 9f OK*  2360081726.00 unspecified
c020 SDR Full 01 3b 20 a f8 snum 16 Processor 1 Temp = 99 OK*  2360078642.00 unspecified
0021 SDR Full 01 3b 20 a f8 snum 17 Processor 2 Temp = 99 OK*  2360078642.00 unspecified
4021 SDR Full 01 3b 20 a f8 snum 18 Processor 3 Temp = a1 OK*  2360082754.00 unspecified
8021 SDR Full 01 3b 20 a f8 snum 19 Processor 4 Temp = 9b OK*  2360079670.00 unspecified
c021 SDR Full 01 37 20 a f8 snum 01 Baseboard 5V     = bd OK*  440012474.00 unspecified
0022 SDR Full 01 38 20 a f8 snum 02 Baseboard 12V    = ab OK*  440000342.00 unspecified
4022 SDR Full 01 39 20 a f8 snum 03 Baseboard 3.3V   = df OK*  440000446.00 unspecified
8022 SDR Full 01 39 20 a f8 snum 0c Baseboard 2.5V   = cb OK*  440000406.00 unspecified
c022 SDR Full 01 39 20 a f8 snum 0b Baseboard 1.5V   = 9b OK*  440000310.00 unspecified
0023 SDR Full 01 36 20 a f8 snum 13 SCSI-N Volt      = ca OK*  440000404.00 unspecified
4023 SDR Full 01 3a 20 a f8 snum 1a Baseboard Fan 2  = 5e OK*  80000188.00 unspecified
8023 SDR Full 01 3a 20 a f8 snum 1b Baseboard Fan 1  = 63 OK*  80000198.00 unspecified
c023 SDR Full 01 3a 20 a f8 snum 1c Baseboard Fan 4  = 5b OK*  80000182.00 unspecified
0024 SDR Full 01 3a 20 a f8 snum 1d Baseboard Fan 3  = 63 OK*  80000198.00 unspecified
4024 SDR Full 01 3a 20 a f8 snum 1e Baseboard Fan 5  = 5c OK*  80000184.00 unspecified
8024 SDR Full 01 3a 20 a f8 snum 1f Baseboard Fan 8  = 60 OK*  80000192.00 unspecified
c024 SDR Full 01 3a 20 a f8 snum 20 Baseboard Fan 7  = 5f OK*  80000190.00 unspecified
0025 SDR Full 01 3a 20 a f8 snum 21 Baseboard Fan 6  = 5b OK*  80000182.00 unspecified
4025 SDR Full 01 39 20 a f8 snum 22 PwrShare Fan 1   = 57 OK*  80000174.00 unspecified
8025 SDR Full 01 39 20 a f8 snum 23 PwrShare Fan 2   = 55 OK*  80000170.00 unspecified
c025 SDR Full 01 39 20 a f8 snum 24 PwrShare Fan 3   = 55 OK*  80000170.00 unspecified
0026 SDR Full 01 38 20 a f8 snum 2d PwrShare Temp    = 9e OK*  2360081212.00 unspecified
4026 SDR Comp 02 25 20 a 49 snum 2c 3-4 L2 VID       = c0 c0 fb b7 Deassert
7026 SDR Comp 02 25 20 a 49 snum 2b 1-2 L2 VID       = c0 00 00 00 OK  
a026 SDR Comp 02 22 20 a 49 snum 31 oc Term          = c0 00 00 00 OK  
d026 SDR Comp 02 26 20 a 09 snum 27 ssor 1 Stat      = 80 80 00 00 Enabled 
0027 SDR Comp 02 26 20 a 09 snum 28 ssor 2 Stat      = 80 80 00 00 Enabled 
3027 SDR Comp 02 26 20 a 09 snum 29 ssor 3 Stat      = 80 80 00 00 Enabled 
6027 SDR Comp 02 26 20 a 09 snum 2a ssor 4 Stat      = 80 80 00 00 Enabled 
9027 SDR Comp 02 25 20 a 49 snum 25 edund Lost       = 00 80 00 00 OK  
c027 SDR Comp 02 20 20 a 09 snum 26  Unit            = 00 00 00 00 NotAvailable
f027 SDR Comp 02 24 20 a 49 snum 32 Post Code        = c0 00 00 00 OK  
2028 SDR Comp 02 26 20 a 49 snum 41 MP Password      = c0 00 00 00 OK  
5028 SDR Comp 02 26 20 a 49 snum 33 ntrusion ID      = c1 00 00 00 OK  
8028 SDR Comp 02 24 20 a 49 snum 36 rtPnl NMI        = 00 80 00 00 OK  
b028 SDR Comp 02 22 20 a 49 snum 37 atchdog          = 00 80 00 00 OK  
e028 SDR Comp 02 25 20 a 49 snum 34  Violation       = c0 00 00 00 OK  
1029 SDR Comp 02 1f 20 a 43 snum 35 tate             = c0 00 00 00 OK  
4029 SDR Comp 02 24 20 a 49 snum 2e are Sup 1        = 01 80 00 00 OK  
7029 SDR Comp 02 24 20 a 49 snum 2f are Sup 2        = 01 80 00 00 OK  
a029 SDR Comp 02 24 20 a 49 snum 30 are Sup 3        = 01 80 00 00 OK  
d029 SDR Comp 02 1f 20 a 49 snum 38 tate             = c0 00 00 00 OK  
002a SDR Comp 02 26 20 a 49 snum 0d Term Vlt A1      = c0 00 00 00 OK  
302a SDR Comp 02 26 20 a 49 snum 0e Term Vlt A2      = c0 00 00 00 OK  
602a SDR Comp 02 26 20 a 49 snum 0f Term Vlt A3      = c0 00 00 00 OK  
902a SDR Comp 02 26 20 a 49 snum 10 Term Vlt B1      = c0 00 00 00 OK  
c02a SDR Comp 02 26 20 a 49 snum 11 Term Vlt B2      = c0 00 00 00 OK  
f02a SDR Comp 02 26 20 a 49 snum 12 Term Vlt B3      = c0 00 00 00 OK  
202b SDR Comp 02 24 c0 a 49 snum 01 rv Status        = bc c0 00 00 OK  
502b SDR Comp 02 26 c0 a 49 snum 07 rv Presence      = 00 00 00 00 NotAvailable
802b SDR DLoc 10 1b dev: 20 00 00 05 00 bd Basbrd Mgmt Ctlr
a02b SDR DLoc 10 1a dev: ae 50 00 20 08 00 Processor 1 FRU
c02b SDR DLoc 10 1a dev: aa 50 00 20 08 00 Processor 2 FRU
e02b SDR DLoc 10 1a dev: a6 50 00 20 08 00 Processor 3 FRU
002c SDR DLoc 10 1a dev: a2 50 00 20 08 00 Processor 4 FRU
202c SDR DLoc 10 17 dev: d0 40 00 20 09 02 PwrShare FRU
402c SDR DLoc 10 18 dev: c0 00 00 02 00 85 Hot Swap Ctlr
602c SDR DLoc 10 1b dev: aa 40 00 20 09 02 Memory Board FRU
802c SDR DLoc 10 1b dev: d2 40 00 20 09 02 Pwr Supply 1 FRU
a02c SDR DLoc 10 1b dev: d4 40 00 20 09 02 Pwr Supply 2 FRU
c02c SDR DLoc 10 1b dev: d6 40 00 20 09 02 Pwr Supply 3 FRU
e02c SDR OEM  c0 10 manufS91443: 20 56 65 72 73 69 6f 6e 20 31 2e 33 37 
sensor: completed successfully

If you feel very interested, and it would help you, you can get access to this system for debug and/or testing.

Thanks for a great module, and hopefully you will with time get this working as well ;)

Really appreciated!

-Stian




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

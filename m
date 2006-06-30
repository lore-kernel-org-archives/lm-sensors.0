From: grimm@nickellson.com (Nick Ellson)
Date: Fri, 30 Jun 2006 21:22:17 +0000
Subject: [lm-sensors] ipmi-smb, missing in my kernel config?
Message-Id: <Pine.LNX.4.64.0606301420560.2698@gubbie.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0606300800320.2191@gubbie.home>
In-Reply-To: <Pine.LNX.4.64.0606300800320.2191@gubbie.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



I used the openIPMI with the 2.6.17 patches from Corey and success!


gubbie /usr/src/linux/drivers/char/ipmi # sensor
sensor: version 1.29
-- mBMC version 2.40, IPMI version 1.5
_ID_ SDR_Type_xx Sz Own Typ S_Num Sens_Description   Hex & Interp Reading
0001 SDR EvtO 03 15 20 01 snum 01 LAN Scrty        = 00 00 00 00 OK
0002 SDR EvtO 03 14 20 01 snum 02 Password         = 00 00 00 00 OK
0003 SDR EvtO 03 14 20 01 snum 03 PWRGOOD#         = 00 00 00 00 OK
0004 SDR EvtO 03 12 20 01 snum 04 Button           = 00 00 00 00 OK
0005 SDR EvtO 03 15 20 01 snum 05 Watchdog2        = 00 00 00 00 OK
0006 SDR EvtO 03 19 20 01 snum 06 SyS Boot Init    = 00 00 00 00 OK
0007 SDR EvtO 03 14 20 01 snum 07 Sys Evnt         = 00 00 00 00 OK
0008 SDR EvtO 03 17 20 01 snum 08 Pltfrm Evnt      = 00 00 00 00 OK
0009 SDR IPMB 12 17 dev: 20 00 07 01 PC87431 mBMC
000a SDR Full 01 33 20 02 snum 0a CPU1 12V         = c5 OK   12.31 Volts
000b SDR Full 01 39 20 02 snum 0c Baseboard 1.5V   = c1 OK   1.51 Volts
000c SDR Full 01 39 20 02 snum 0d Baseboard 2.5V   = bf OK   2.50 Volts
000d SDR Full 01 39 20 02 snum 0e Baseboard 3.3V   = c3 OK   3.35 Volts
000e SDR Full 01 39 20 02 snum 0f Baseboard 5.0V   = c3 OK   5.08 Volts
000f SDR Full 01 38 20 02 snum 10 Baseboard 12V    = c6 OK   12.37 Volts
0010 SDR Full 01 39 20 02 snum 11 Baseboard -12V   = 4c OK   -12.00 Volts
0011 SDR Full 01 32 20 02 snum 12 FSB Vtt          = c0 OK   1.20 Volts
0012 SDR Full 01 32 20 02 snum 13 MCH Vtt          = 00 OK   0.01 Volts
0013 SDR Full 01 36 20 01 snum 2a System Temp      = 1f OK   31.00 degrees 
C
0014 SDR Comp 02 2b 20 13 snum 23 Interrupt Button = 00 c0 00 00 OK
0015 SDR Comp 02 24 20 14 snum 24 ID Button        = 00 c0 00 00 OK
0016 SDR Comp 02 2b 20 07 snum 29 CPU Config Error = 00 c0 00 00 OK
0017 SDR FRU  11 13 dev: 01 00 07 01 HOST FRU
0018 SDR OEM  c0 13 manuf=Intel: SDR Package 1.30

I got a command line that can read them. If I can narrow it to a single 
return value for what I want, I can grapgh it in MRTG.

Nick


-- 
Nick Ellson
CCDA, CCNP, CCSP, CCAI,
MCSE 2000, Security+, Network+
Network Hobbyist, VFR Private Pilot.


On Fri, 30 Jun 2006, Yani Ioannou wrote:

> Hi Nick,
>
> On 6/30/06, Nick Ellson <grimm at nickellson.com> wrote:
>>
>>  Just curious if anyone has tried setting up OpenIPMI to help get
>>  lm-sensors to see the Intel BMC chip on the SMB bus?
>
> At the moment lm-sensors for 2.6 doesn't support IPMI, I'm working on
> a new driver ipmisensors which I hope to have a released version you
> can test in a couple of weeks at most. You can check the website to
> see the current status  (http://bmcsensors-26.sourceforge.net/). For
> now you might want to try using something like ipmitool to check
> sensor readings.
>
> Yani
>


From: d.nuetzel@wearabrain.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Message-Id: <200308061849.01416.d.nuetzel@wearabrain.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308060621.06216.d.nuetzel@wearabrain.de> <20030806100815.GH16091@fs.tum.de>
In-Reply-To: <20030806100815.GH16091-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>, phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Linux Kernel List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sensors-LT64U7CwzWEZMC/lefXSXFaTQe2KTcn/@public.gmane.org

Am Mittwoch, 6. August 2003 12:08 schrieb Adrian Bunk:
> On Wed, Aug 06, 2003 at 06:21:06AM +0200, Dieter N?tzel wrote:
> > Hello,
>
> Hi Dieter,
>
> > I had it running very well on my dual Athlon MP 1900+ for several months
> > before. Latest Kernel was 2.4.22-pre5+ACPI patch.
> >
> > Any changes?
> > I changed lm_sensors from 2.7.0 (?) to 2.8.0

This one is the culprit.
Reverting to 2.7.0 cure my problems.

i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-amd756.o version 2.7.0 (20021208)
i2c-amd756.o: Found AMD768 SMBus controller.
i2c-amd756.o: AMD768 bus detected and initialized

amd76x_pm: Version 20020730
amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] System Controller
amd76x_pm: Initializing southbridge Advanced Micro Devices [AMD] AMD-768 
[Opus] ACPI
i2c-isa.o version 2.7.0 (20021208)
i2c-isa.o: ISA bus access for i2c modules initialized.
eeprom.o version 2.7.0 (20021208)
w83781d.o version 2.7.0 (20021208)

> > System:
> > dual Athlon MP 1900+
> > MSI K7D Master-L
> >
> > 2.4.22-rc1
> > acpi-20030730-2.4.22-pre8.diff
> > preempt-kernel-rml-2.4.21-1.patch
> >...

Work all fine, now.

>
> does an unpatched 2.4.22-rc1 work?

I think it do;-)

amd76x_pm is GREAT!

/home/nuetzel> sensors
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.72 V  (min =  +1.61 V, max =  +1.77 V)
VCore 2:   +2.49 V  (min =  +2.36 V, max =  +2.62 V)
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.99 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.01 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.39 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.10 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.44 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.47 V  (min =  +2.40 V, max =  +3.60 V)
U160:     2327 RPM  (min = 1500 RPM, div = 4)
CPU 0:    4090 RPM  (min = 3000 RPM, div = 2)
CPU 1:    4115 RPM  (min = 3000 RPM, div = 2)
System:   +37.0?C   (limit = +40?C, hysteresis = +37?C) sensor = thermistor
CPU 1:    +29.0?C   (limit = +52?C, hysteresis = +47?C) sensor = 3904 
transistor
CPU 0:    +31.0?C   (limit = +52?C, hysteresis = +47?C) sensor = 3904 
transistor
vid:      +18.50 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm disabled


Cheers,
	Dieter

-- 
Dieter N?tzel
Leiter F&E, WEAR-A-BRAIN GmbH, Wiener Str. 5, 28359 Bremen, Germany
Mobil: 0162 673 09 09


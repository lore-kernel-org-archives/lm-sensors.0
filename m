From: Phillip Pi <ant@zimage.com>
Date: Fri, 05 Mar 2010 22:20:16 +0000
Subject: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100305222015.GR11436@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello.

This morning, I rebooted my old Debian box to start using its new Kernel
2.6.32 from 2.6.30, but I noticed my lm_sensors didn't show everything
(voltages, fan RPMs, etc.) anymore compared to 2.6.30 and earlier. I am
using a MSI K8N NEO4-F (MS-7125) motherboard. You can see
http://alpha.zimage.com/~ant/antfarm/about/computers.txt for the
detailed hardware setup.

$ sensors -f
acpitz-virtual-0
Adapter: Virtual device
temp1:       +71.2�F  (crit = +206.2�F)

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +87.8�F
Core1 Temp:  +64.4�F


Kernel 2.6.30 and earlier used to say something like this:
$ sensors -f
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp: +80.6�F

...
Adapter: ISA adapter
VCore: +1.12 V (min = +2.11 V, max = +2.48 V)
+3.3V: +3.28 V (min = +1.46 V, max = +0.21 V)
+5V: +4.97 V (min = +0.89 V, max = +0.22 V)
+12V: +11.43 V (min = +0.24 V, max = +9.67 V)
-12V: +0.72 V (min = -5.37 V, max = +0.63 V)
-5V: +5.10 V (min = +1.18 V, max = -7.66 V)
V5SB: +5.59 V (min = +0.13 V, max = +0.48 V)
VBat: +1.55 V (min = +2.24 V, max = +3.46 V)
fan1: 2360 RPM (min = 1622 RPM, div = 4)
fan2: 2376 RPM (min = 1985 RPM, div = 4)
temp1: +82.4�F (high = +201.2°F, hyst = +221.0°F) sensor = thermistor
temp2: +86.0�F (high = +176.0°F, hyst = +167.0°F) sensor = thermistor
beep_enable:enabled 

I even reran sensors-detect command as shown in http://pastie.org/856408 
(too long to show in this post/e-mail).

I looked at the FAQ and saw 
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31 
which look like my issue and matches dmesg: http://pastie.org/856424 ...

I am scared to use the lax method since it is not recommended. Is there 
another way to show the datas safely? Or do I have to use this trick or 
live without them?

Thank you in advance. :)
-- 
Quote of the Week: "Not all ants use violence to dominate their world,
some use more subtle methods..." --E.O. Wilson on NOVA
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

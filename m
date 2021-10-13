From: riveravaldez <riveravaldezmail@gmail.com>
Date: Wed, 13 Oct 2021 17:17:02 +0000
Subject: Trying to understand `sensors` output (Debian 11 LXDE)
Message-Id: <CAD8U+g9D2=0WCL1QP1z=xb2b8iktnS8AnW1j9=P6vnfhsAxfjQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi, I'm not subscribed to the list, so, please add me in replies.
Thanks a lot in advance.

I'm trying to understand the readings of `sensors` in terminal.
This is a Debian 11 machine in a Gigabyte AM1M-S2H motherboard.
CPU: AMD Athlon(tm) 5150 APU with Radeon(tm) R3
VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Kabini [Radeon HD 8400 / R3 Series]

LXDE shows a temperature monitor in the taskbar.
Before installing/configuring lm-sensors package the reading was ~20ºC at idle.
After `sudo sensors-detect` an it87 module was added and now I have
these readings:

$ sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +20.9°C  (high = +70.0°C)
                       (crit = +70.0°C, hyst = +69.0°C)

radeon-pci-0008
Adapter: PCI adapter
temp1:        +21.0°C  (crit = +120.0°C, hyst = +90.0°C)

fam15h_power-pci-00c4
Adapter: PCI adapter
power1:           N/A  (crit =  24.98 W)

it8620-isa-0228
Adapter: ISA adapter
in0:           1.12 V  (min =  +0.00 V, max =  +3.06 V)
in1:           1.52 V  (min =  +0.00 V, max =  +3.06 V)
in2:           2.02 V  (min =  +0.00 V, max =  +3.06 V)
in3:           2.05 V  (min =  +0.00 V, max =  +3.06 V)
in4:           2.04 V  (min =  +0.00 V, max =  +3.06 V)
in5:           2.23 V  (min =  +0.00 V, max =  +3.06 V)
in6:           2.23 V  (min =  +0.00 V, max =  +3.06 V)
3VSB:          3.31 V  (min =  +0.00 V, max =  +6.12 V)
Vbat:          3.12 V
fan1:        2008 RPM  (min =   10 RPM)
fan2:           0 RPM  (min =    0 RPM)
fan3:           0 RPM  (min =    0 RPM)
fan4:           0 RPM  (min =    0 RPM)
fan5:           0 RPM  (min =    0 RPM)
temp1:        +31.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermistor
temp2:        +38.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermistor
temp3:        +37.0°C  (low  =  +0.0°C, high = +70.0°C)  sensor = Intel PECI
temp4:        +45.0°C
temp5:        +45.0°C
temp6:        +45.0°C
intrusion0:  ALARM

The LXDE monitor now shows ~45ºC at idle, but htop keeps showing ~20ºC at the
same time.

Could anyone please indicate me which temperature correspond to which
hardware component?, or point me in the right direction (link, I suppose)
to read about? I'm trying to understand those values.

Thanks a lot again, and in general for all your very useful work. :)

Kind regards!

From: Ben Norwood <mittfh@googlemail.com>
Date: Mon, 16 Mar 2009 11:28:40 +0000
Subject: [lm-sensors] ECS GeForce 6100 PM-M2 - labels/calculations
Message-Id: <49BE37E8.90301@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

My Motherboard is an ECS GeForce 6100 PM-M2, with a IT8726 I/O chip.
After extensive web searching, I haven't (yet!) discovered the 
appropriate labels or calculations for the readings given in sensors.
Vcore and VDIMM are based on readings from the BIOS, the 3.3V label 
seemed logical, the M/B temp is based on Systemp in BIOS, and Fake Temp 
is so called because it reads a constant 25°C - even when I'm torturing 
the CPU! Talking of temperatures, they do seem a little dodgy - is the 
CPU really 10°C cooler than room temp, and the motherboard 10°C hotter?
Oh, and I have a fan hooked up to the SYSFAN header (which gives an RPM 
reading if I plug it into the CPUFAN header), but it looks as though ECS 
haven't connected the RPM pin to the chip :(

If anyone can make head or tail of this lot I'd be grateful!

[ben@LinuxBox ~]$ sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp: +13.0°C
Core0 Temp: +3.0°C
Core1 Temp: +6.0°C
Core1 Temp: +2.0°C

acpitz-virtual-0
Adapter: Virtual device
temp1: +16.0°C (crit = +70.0°C)

it8716-isa-0290
Adapter: ISA adapter
Vcore?: +1.30 V (min = +0.00 V, max = +4.08 V)
in1: +2.48 V (min = +0.00 V, max = +4.08 V)
VDIMM?: +1.84 V (min = +0.00 V, max = +4.08 V)
+3.3V?: +3.31 V (min = +0.00 V, max = +4.08 V)
in4: +1.20 V (min = +0.00 V, max = +4.08 V)
in5: +1.15 V (min = +0.00 V, max = +4.08 V)
in6: +2.94 V (min = +0.00 V, max = +4.08 V)
in7: +3.06 V (min = +0.00 V, max = +4.08 V)
VBat: +3.01 V
fan1: 2360 RPM (min = 11 RPM)
fan2: 0 RPM (min = 0 RPM)
CPU temp: +16.0°C (low = -1.0°C, high = +127.0°C) sensor = thermal diode
M/B temp: +35.0°C (low = -1.0°C, high = +127.0°C) sensor = transistor
Fake temp: +25.0°C (low = -1.0°C, high = +127.0°C) sensor = transistor
cpu0_vid: +1.525 V


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

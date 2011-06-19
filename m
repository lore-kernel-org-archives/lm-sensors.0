From: Vincent Pelletier <plr.vincent@gmail.com>
Date: Sun, 19 Jun 2011 21:14:39 +0000
Subject: [lm-sensors] IT8721F on Asus M5A88-V EVO
Message-Id: <201106192314.40074.plr.vincent@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi.

I bought a motherboard, which has an IT8721F on it, and as asked on the wiki I 
report about it :) .

$ sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +29.4°C  (high = +70.0°C)
                       (crit = +70.0°C, hyst = +65.0°C)

it8721-isa-0290
Adapter: ISA adapter
in0:          +2.92 V  (min =  +1.82 V, max =  +0.17 V)  ALARM
in1:          +2.89 V  (min =  +2.34 V, max =  +2.06 V)  ALARM
in2:          +1.14 V  (min =  +2.10 V, max =  +2.68 V)  ALARM
+3.3V:        +3.29 V  (min =  +2.38 V, max =  +2.90 V)  ALARM
in4:          +1.70 V  (min =  +2.82 V, max =  +1.31 V)  ALARM
in5:          +2.63 V  (min =  +2.10 V, max =  +1.40 V)  ALARM
in6:          +1.01 V  (min =  +1.99 V, max =  +1.25 V)  ALARM
3VSB:         +4.27 V  (min =  +1.30 V, max =  +2.76 V)  ALARM
Vbat:         +3.34 V  
fan1:        2657 RPM  (min =   14 RPM)
fan2:        1344 RPM  (min =   24 RPM)
fan3:        1658 RPM  (min =   21 RPM)
temp1:        +38.0°C  (low  =  -6.0°C, high = +82.0°C)  sensor = thermistor
temp2:        +36.0°C  (low  = +126.0°C, high = +117.0°C)  sensor = thermistor
temp3:       -128.0°C  (low  = +17.0°C, high = -15.0°C)  sensor = disabled

Voltage:
- obviously lacks scaling/offseting (indeed, it's not configured)
- alarm levels are funny (max < min for most)
- 3VSB is not 3V (scaling again ?)
Fan speed:
- seems correct, although I cannot easily check
- alarm level lacks scaling (non-configuration again ?)
- cannot be seen here, but pwm control works only for fan2 (chassis fan), both
  in automatic and manual modes. Other fans (cpu & "power" fan, actually used
  for chassis front fan) are at full speed constantly. Setting values and
  reading them back returns what was set.
Temperature:
- Unsure about correctness at the moment: temp1 38° idle, 59° full load with
  fan at constant full speed seems a bit too narrow (min to high, max too low,
  not consistent with k10temp)...
  Then again, I'm not used to that CPU yet (Phenom II 1100T), and I cannot
  check actual temperature.
  No idea for temp2 (motherboard): 36° idle, 38° on load (then again, it does
  little as I don't use its integrated gpu).
- Low/high values are funny (non-configuration obviously, but I'm curious
  where those values come from...)

-- 
Vincent Pelletier

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

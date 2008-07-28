From: <kerry.thomas@charter.net>
Date: Mon, 28 Jul 2008 05:13:21 +0000
Subject: [lm-sensors] f71882fg -- FAULT Reading System Temperature
Message-Id: <20080728011321.TKD9Q.114320.root@fepweb06>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi folks.

I believe I have solved a problem that has plagued me for a couple of weeks. Sensors was reporting FAULT for the system temperature. See the bottom of the message for how I think I have solved the problem.

First, my setup:
=======AMD Phenom X4, 4GB RAM DDR2 800Mhz, MSI K9A2GM-FIH Mobo
Ubuntu Hardy Heron 8.04
2.6.24-19-generic #1 SMP x86_64 GNU/Linux

sesnsors output(NOTE the FAULT reading in the last section
===========kdt@kdt-lnx0:/etc/init.d$ sensors
f71882fg-isa-0600
Adapter: ISA adapter
3.3V:        +3.36 V
Vcore:       +1.26 V  (max =  +2.04 V)   
Vdimm:       +2.21 V
Vchip:       +1.74 V
+5V:         +5.42 V
12V:        +11.50 V
5VSB:        +3.86 V
3VSB:        +3.36 V
Battery:     +3.28 V
CPU:        1411 RPM
System:        0 RPM  ALARM
Power:         0 RPM  ALARM
Aux:           0 RPM  ALARM
CPU:         +39.0°C  (high = +85.0°C, hyst = +81.0°C)  
                      (crit = +100.0°C, hyst = +96.0°C)  sensor = transistor
System:        FAULT  (high = +85.0°C, hyst = +81.0°C)  
                      (crit = +100.0°C, hyst = +96.0°C)  sensor = transistor

Now, the sensors.conf (relevant portion)
=========chip "f71882fg-*"

# Temperature
    label temp1       "CPU"
    label temp2       "System"
    ignore temp3

# Fans
    label fan1        "CPU"
    label fan2        "System"
    label fan3        "Power"
    label fan4        "Aux"

# Voltage
    label in0         "3.3V"
    label in1         "Vcore"
    label in2         "Vdimm"
    label in3         "Vchip"
    label in4         "+5V"
    label in5         "12V"
    label in6         "5VSB"
    label in7         "3VSB"
    label in8         "Battery"

# never change the in0, in7 and in8 compute, these are hardwired in the chip!
    compute in0       (@ * 2), (@ / 2)
    compute in2       (@ * 2), (@ / 2)
    compute in3       (@ * 2), (@ / 2)
    compute in4       (@ * 5.25), (@ / 5.25)
    compute in5       (@ * 12.83), (@ / 12.83)
    compute in6       (@ * 5.25), (@ / 5.25)
    compute in7       (@ * 2), (@ / 2)
    compute in8       (@ * 2), (@ / 2)

I finally found a data sheet for the F71882 chip, which is used on this mobo:
http://www.datasheet4u.com/html/F/7/1/F71882_Fintek.pdf.html

Now, look at the sensors3.conf. It's saying to use temp2 as the system temperature. HOWEVER, in the data sheet it refers to line D3 as (System). Hmmmm... I set the sensors3.conf like this:
========# Temperature
    label temp1       "CPU"
    ignore temp2       "T2"
    label temp3       "System"

BINGO! Now I get a reading that occasionally changes and makes sense. Hope this helps anyone else in my situation.

Thanks much to the volunteers for their hard work on an outstanding and open product. I seriously doubt I would EVER have found this using closed-src.

--Kerry Thomas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

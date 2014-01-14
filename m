From: Andreas Hollmann <hollmann@in.tum.de>
Date: Tue, 14 Jan 2014 13:01:19 +0000
Subject: [lm-sensors] Sensors shows only 8 of 10 cores on 4-Socket Intel(R) Xeon(R) CPU E7- 4850 machine
Message-Id: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

2 cores are missing per socket in the sensors output.

Is there a hard coded number of max CPUs that limits
to output more then 8 CPUs?

CPUs are

4 x CPU0: Intel(R) Xeon(R) CPU E7- 4850  @ 2.00GHz
(10 cores with hyperthreading)

Mainboard:

Supermicro X8QB6-F

http://www.supermicro.com/products/motherboard/Xeon7000/7500/X8QB6.cfm?SAS=Y

sensors gives me following output

$: sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +43.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +45.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +43.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +42.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +42.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +45.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +38.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +43.0 C  (high = +86.0 C, crit = +94.0 C)

coretemp-isa-0001
Adapter: ISA adapter
Core 0:       +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +47.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +33.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +36.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +39.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +40.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +39.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +37.0 C  (high = +86.0 C, crit = +94.0 C)

coretemp-isa-0002
Adapter: ISA adapter
Core 0:       +37.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +39.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +46.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +41.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +37.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +35.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +37.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +37.0 C  (high = +86.0 C, crit = +94.0 C)

coretemp-isa-0003
Adapter: ISA adapter
Core 0:       +40.0 C  (high = +86.0 C, crit = +94.0 C)
Core 1:       +42.0 C  (high = +86.0 C, crit = +94.0 C)
Core 2:       +44.0 C  (high = +86.0 C, crit = +94.0 C)
Core 8:       +41.0 C  (high = +86.0 C, crit = +94.0 C)
Core 9:       +41.0 C  (high = +86.0 C, crit = +94.0 C)
Core 16:      +40.0 C  (high = +86.0 C, crit = +94.0 C)
Core 17:      +41.0 C  (high = +86.0 C, crit = +94.0 C)
Core 18:      +43.0 C  (high = +86.0 C, crit = +94.0 C)

w83795adg-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
in0:          +1.09 V  (min =  +0.54 V, max =  +1.49 V)
in1:          +1.01 V  (min =  +0.90 V, max =  +1.11 V)
in2:          +1.22 V  (min =  +1.08 V, max =  +1.33 V)
in3:          +1.82 V  (min =  +1.62 V, max =  +1.99 V)
in4:          +1.13 V  (min =  +0.98 V, max =  +1.21 V)
in5:          +1.11 V  (min =  +0.54 V, max =  +1.49 V)
in6:          +1.07 V  (min =  +0.54 V, max =  +1.49 V)
in7:          +1.10 V  (min =  +0.54 V, max =  +1.49 V)
in11:         +1.12 V  (min =  +0.92 V, max =  +1.35 V)
+3.3V:        +3.20 V  (min =  +2.96 V, max =  +3.63 V)
3VSB:         +3.19 V  (min =  +2.96 V, max =  +3.63 V)
Vbat:         +3.33 V  (min =  +2.70 V, max =  +3.63 V)
in15:         +1.87 V  (min =  +1.63 V, max =  +1.99 V)
in16:         +1.52 V  (min =  +1.35 V, max =  +1.65 V)
fan1:        4397 RPM  (min =  709 RPM)
fan2:           0 RPM  (min =  709 RPM)  ALARM
fan3:        4313 RPM  (min =  709 RPM)
fan4:           0 RPM  (min =  709 RPM)  ALARM
fan5:        4455 RPM  (min =  709 RPM)
fan6:           0 RPM  (min =  709 RPM)  ALARM
fan7:           0 RPM  (min =  709 RPM)  ALARM
fan8:        4671 RPM  (min =  709 RPM)
fan9:        4856 RPM  (min =  709 RPM)
fan10:       4856 RPM  (min =  709 RPM)
fan11:          0 RPM  (min =  329 RPM)  ALARM
fan12:       5793 RPM  (min =  709 RPM)
temp1:        +50.5 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp2:        +44.2 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp3:        +52.0 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp4:        +43.8 C  (high = +85.0 C, hyst = +80.0 C)
                       (crit = +75.0 C, hyst = +70.0 C)  sensor = thermal diode
temp7:        +52.2 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
temp8:        +52.0 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
temp9:        +50.0 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
temp10:       +50.0 C  (high = +95.0 C, hyst = +92.0 C)
                       (crit = +95.0 C, hyst = +92.0 C)  sensor = Intel PECI
intrusion0:  OK

Best regards and thanks for the great tool,
Andreas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

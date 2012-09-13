From: Super Groomers <supergroomers@gmail.com>
Date: Thu, 13 Sep 2012 18:31:02 +0000
Subject: [lm-sensors] acpitz-virtual-0
Message-Id: <CADsebomK8pjFc6MBZ8_Xdxztj7NmBsQoh9B=8VQ=eMRhNANimA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

I am running lm-sensors version 3.3.2 on kernel version 3.2.0-29
generic on an Intel DZ77GA-70K motherboard, cpu is Ivy Bridge I7-3770.
The sensors output is listed below.
sensors-detect detects coretemp and the Winbond chip, they each seem
to differ from the "virtual acpitz-virtual-0." How could I find out
what this interface corresponds to and what thermal zone is being
reported here?

thanks,
/Doobs

acpitz-virtual-0
Adapter: Virtual device
temp1:        +27.8°C  (crit = +106.0°C)
temp2:        +29.8°C  (crit = +106.0°C)

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +32.0°C  (high = +85.0°C, crit = +105.0°C)
Core 0:         +30.0°C  (high = +85.0°C, crit = +105.0°C)

nct6775-isa-0a00
Adapter: ISA adapter
Vcore:          +0.88 V  (min =  +0.00 V, max =  +1.74 V)
in1:            +0.78 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
AVCC:           +3.36 V  (min =  +2.98 V, max =  +3.63 V)
+3.3V:          +3.36 V  (min =  +2.98 V, max =  +3.63 V)
in4:            +1.27 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:            +0.74 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:            +1.06 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
3VSB:           +3.38 V  (min =  +2.98 V, max =  +3.63 V)
Vbat:           +3.26 V  (min =  +2.70 V, max =  +3.30 V)
fan1:             0 RPM  (min =    0 RPM, div = 128)
fan2:          1140 RPM  (min =    0 RPM, div = 32)  ALARM
fan3:             0 RPM  (min =    0 RPM, div = 128)
fan4:             0 RPM  (div = 128)
SYSTIN:         +30.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM
sensor = thermistor
CPUTIN:         +28.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor =
thermistor
PECI Agent 0:   +31.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor =
Intel PECI
PCH_CHIP_TEMP:  +49.0°C
PECI Agent 1:    +0.0°C  (high = +80.0°C, hyst = +75.0°C)
cpu0_vid:      +0.000 V
intrusion0:    ALARM

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

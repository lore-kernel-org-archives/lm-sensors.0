From: cybercorecentre@gmail.com (Jax)
Date: Thu, 03 Aug 2006 18:02:03 +0000
Subject: [lm-sensors] Tyan S2466N fan control help
Message-Id: <44D23A1B.5050401@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44CD6F57.3080001@gmail.com>
In-Reply-To: <44CD6F57.3080001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys!

I trying with fancontrol on my Tyan S2466N motherboard.
Sensors work properly but I can't control the FANs, this example both of
the fans speed is 0 because they disconnected atm :)

w83782d-i2c-0-2d
Adapter: SMBus AMD768 adapter at 80e0
VCore 1:   +1.63 V  (min =  +1.57 V, max =  +1.73 V)
VCore 2:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +1.54 V  (min =  +3.14 V, max =  +3.46 V)       ALARM
+5V:       +4.84 V  (min =  +4.73 V, max =  +5.24 V)
+12V:      +4.62 V  (min = +10.82 V, max = +13.19 V)       ALARM
-12V:      -2.33 V  (min = -13.18 V, max = -10.88 V)       ALARM
-5V:       +2.64 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +4.25 V  (min =  +4.73 V, max =  +5.24 V)       ALARM
VBat:      +3.26 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 21093 RPM, div = 4)              ALARM
fan2:        0 RPM  (min =   -1 RPM, div = 4)              ALARM
fan3:        0 RPM  (min = 168750 RPM, div = 4)              ALARM
temp1:       +81 C  (high =    +8 C, hyst =   -62 C)   sensor thermistor   ALARM
temp2:     +79.5 C  (high =   +80 C, hyst =   +75 C)   sensor thermistor
temp3:     +79.0 C  (high =   +80 C, hyst =   +75 C)   sensor thermistor
vid:      +1.650 V  (VRM Version 9.0)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

w83627hf-isa-0c00
Adapter: ISA adapter
VCore 1:   +1.62 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
VCore 2:   +1.65 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.08 V  (min =  +4.76 V, max =  +5.24 V)
+12V:      +9.42 V  (min = +10.82 V, max = +13.19 V)       ALARM
-12V:     -11.95 V  (min = -13.18 V, max = -10.80 V)
-5V:       +0.33 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +5.59 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
VBat:      +2.32 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
fan1:        0 RPM  (min = 7670 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 3479 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 4623 RPM, div = 2)              ALARM
temp1:       +77 C  (high =   +53 C, hyst =   +80 C)   sensor thermistor
temp2:     +79.0 C  (high =   +80 C, hyst =   +75 C)   sensor thermistor
temp3:     +76.5 C  (high =   +80 C, hyst =   +75 C)   sensor thermistor


Is there anyone who can make it work with my motherboard or somethink
like this from tyan?
The problem not lm-sensors specific because I get the same with speedfan
or motherboard monitor app in windows. I tryed to search but I go
nowhere with google. Bios upgrade also impossible if it would be the
problem, because tyan doesn't support this board anymore. The board has
6 fan connectors and I tried all but still the same results.

Second time I used sensors-detect and put every sensor specific thing to 
module, maybe some combinations are not work. But now when I configured 
with sensors-detect the temperature buggy, fan speed 0 every time so I 
switch back and compile them again to the kernel, point is linux mbmon 
program working without lm-sensors and it's give me the best results, 
fan speed OK every time I start it, how can be this possible?

Regards,

Jax




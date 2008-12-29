From: Petar <apetar@gmail.com>
Date: Mon, 29 Dec 2008 18:55:10 +0000
Subject: [lm-sensors] Help with it8712-isa-0290
Message-Id: <200812291955.10560.apetar@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi list, 

[root@fearless mrtg]# sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:     +1.33 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:     +2.61 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:       +3.15 V  (min =  +0.00 V, max =  +4.08 V)
+5V:         +5.13 V  (min =  +0.00 V, max =  +6.85 V)
+12V:       +11.90 V  (min =  +0.00 V, max = +16.32 V)
-12V:        -9.07 V  (min = -27.36 V, max =  +3.93 V)
-5V:         -8.44 V  (min = -13.64 V, max =  +4.03 V)
Stdby:       +6.85 V  (min =  +0.00 V, max =  +6.85 V)   ALARM
VBat:        +3.10 V
fan1:       1231 RPM  (min =    0 RPM, div = 8)
fan3:          0 RPM  (min =    0 RPM, div = 8)
M/B Temp:    -55.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = transistor
CPU Temp:     -2.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = transistor
Temp3:       +33.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermal diode
cpu0_vid:   +1.388 V


I guess temp1 is  "CPU Temp" and temp3 is "M/B Temp" . I cant tell what is temp2 doing but i think it is safe to ignore?  
After editing sensors3.conf i got :

paleksic@fearless html 0 $ sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:     +1.22 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:     +2.61 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:       +3.17 V  (min =  +0.00 V, max =  +4.08 V)
+5V:         +5.05 V  (min =  +0.00 V, max =  +6.85 V)
+12V:       +12.10 V  (min =  +0.00 V, max = +16.32 V)
-12V:       -14.97 V  (min = -27.36 V, max =  +3.93 V)
-5V:        -11.01 V  (min = -13.64 V, max =  +4.03 V)
Stdby:       +6.85 V  (min =  +0.00 V, max =  +6.85 V)   ALARM
VBat:        +3.10 V
fan1:       1147 RPM  (min =    0 RPM, div = 8)
fan3:          0 RPM  (min =    0 RPM, div = 8)
CPU Temp:    -55.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = transistor
M/B Temp:    +31.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermal diode
cpu0_vid:   +1.388 V

Still no good :> Why is CPU Temp inverted and how can i fix it?

Happy holidays, 
Petar 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

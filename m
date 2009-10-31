From: Jon Sturm <jasturm002@aol.com>
Date: Sat, 31 Oct 2009 01:02:59 +0000
Subject: [lm-sensors] Gateway mobo config (w83627hf)
Message-Id: <4AEB8CC3.5040406@aol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I have an old gateway computer setup as a file server and I would like 
to be able to make sure it is running as it should though the temps but 
the output I get from sensors has temps that are unreasonable for a 
5year PIII mobo.  I thought the CPU was Temp 2 but I'm not sure and the 
Bios does not have any information on the temps and one of them is even 
negative, I don't really care about the voltages but if I can put 
correct labels on them thats a plus.

w83627hf-isa-0290
Adapter: ISA adapter
in0:         +1.65 V  (min =  +1.49 V, max =  +1.90 V)
in1:         +1.50 V  (min =  +1.49 V, max =  +1.90 V)
in2:         +3.38 V  (min =  +2.82 V, max =  +3.79 V)
in3:         +2.91 V  (min =  +0.62 V, max =  +4.08 V)
in4:         +3.20 V  (min =  +3.94 V, max =  +3.97 V)   ALARM
in5:         +0.59 V  (min =  +2.80 V, max =  +4.02 V)   ALARM
in6:         +0.83 V  (min =  +3.57 V, max =  +3.82 V)   ALARM
in7:         +3.26 V  (min =  +2.93 V, max =  +3.74 V)
in8:         +3.38 V  (min =  +3.70 V, max =  +2.96 V)   ALARM
fan1:          0 RPM  (min = 3391 RPM, div = 2)  ALARM
fan2:          0 RPM  (min = 2836 RPM, div = 2)  ALARM
fan3:       6192 RPM  (min = 2812 RPM, div = 2)
temp1:       +25.0°C  (high =  -9.0°C, hyst =  -1.0°C)  ALARM  sensor 
= thermistor
temp2:       +69.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
thermistor
temp3:       -48.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
thermistor
cpu0_vid:   +1.700 V
beep_enable:enabled

Thanks in advance for any help I receive,

Jon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

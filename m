From: Dani Mustea <dmustea@rdslink.ro>
Date: Thu, 06 Aug 2009 14:58:21 +0000
Subject: [lm-sensors] Temp and Fan errors
Message-Id: <1734940451.20090806175821@rdslink.ro>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello all,

I have just installed lm_sensors 3.1.1 but the results are not the
expected ones
Here is the output
-----------------------------------
w83627hf-isa-0290
Adapter: ISA adapter
in0:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)
in1:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)
in2:         +4.08 V  (min =  +2.82 V, max =  +3.79 V)
in3:         +3.01 V  (min =  +2.83 V, max =  +3.12 V)
in4:         +3.06 V  (min =  +3.95 V, max =  +3.06 V)
in5:         +3.12 V  (min =  +4.08 V, max =  +4.02 V)
in6:         +3.15 V  (min =  +2.03 V, max =  +3.06 V)
in7:         +3.22 V  (min =  +3.44 V, max =  +2.00 V)
in8:         +1.82 V  (min =  +2.96 V, max =  +2.02 V)
fan1:          0 RPM  (min =    0 RPM, div = 2)
fan2:          0 RPM  (min = 3688 RPM, div = 2)
fan3:          0 RPM  (min =    0 RPM, div = 2)
temp1:       -48.0Â°C  (high =  -1.0Â°C, hyst = -35.0Â°C)  sensor = thermistor
temp2:       -48.0Â°C  (high = +80.0Â°C, hyst = +75.0Â°C)  sensor = thermistor
temp3:       -48.0Â°C  (high = +80.0Â°C, hyst = +75.0Â°C)  sensor = thermistor
cpu0_vid:   +1.419 V
beep_enable:enabled
----------------------------------

The server is SuperMicro with X7DBU motherboard
CentOS 5.3 - Kernel 2.6.18-128.2.1

----------------------------------


The fans are to 0 RPM ant temperature to -48. Why? What am I doing
wrong.


Thank you.


With respect,
Dani


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

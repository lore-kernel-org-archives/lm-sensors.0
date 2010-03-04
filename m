From: Sergey Kvachonok <ravenexp@gmail.com>
Date: Thu, 04 Mar 2010 12:37:05 +0000
Subject: [lm-sensors] 3.1.2 sensord duplicate RRD name problem
Message-Id: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sensord fails to start with the following messages:

sensord: Creating round robin database
sensord: Error creating RRD file: /var/log/sensord.rrd: Duplicate DS name: temp1

sensors output is like this:

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +26.0 C  (high = +76.0 C, crit = +100.0 C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +27.0 C  (high = +76.0 C, crit = +100.0 C)

it8718-isa-0290
Adapter: ISA adapter
Vcore:       +1.01 V  (min =  +0.00 V, max =  +4.08 V)
V_DDR2:      +1.90 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:       +3.38 V  (min =  +0.00 V, max =  +4.08 V)
in3:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
in4:         +0.38 V  (min =  +0.00 V, max =  +2.10 V)
in7:         +3.15 V  (min =  +0.00 V, max =  +4.08 V)
Vbat:        +3.18 V
CPU fan:     148 RPM  (min =   10 RPM)
System fan:    0 RPM  (min =    0 RPM)
temp1:       -55.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
temp2:        -2.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
MB temp:     +17.0 C  (low  = +127.0 C, high = +60.0 C)  sensor = thermal diode
cpu0_vid:   +3.300 V

I believe the problem is that different sensors provide results with
the same name 'temp1'.
Are there any solutions for this problem?

Thanks in advance,
Sergey.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

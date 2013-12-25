From: linuxcbon <linuxcbon@yahoo.fr>
Date: Wed, 25 Dec 2013 19:52:30 +0000
Subject: [lm-sensors] wrong datas ?
Message-Id: <1388001150.7351.YahooMailBasic@web173205.mail.ir2.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I run ssensors version 3.3.4 with libsensors version 3.3.4. (got the same results with other versions).

# sensors
it8718-isa-0228
Adapter: ISA adapter
in0:          +1.04 V  (min =  +0.00 V, max =  +4.08 V)
in1:          +1.84 V  (min =  +0.00 V, max =  +4.08 V)
in2:          +3.33 V  (min =  +0.00 V, max =  +4.08 V)
+5V:          +3.01 V  (min =  +0.00 V, max =  +4.08 V)
in4:          +3.04 V  (min =  +0.00 V, max =  +4.08 V)
in5:          +3.22 V  (min =  +0.00 V, max =  +4.08 V)
in6:          +4.08 V  (min =  +0.00 V, max =  +4.08 V)  ALARM
in7:          +2.00 V  (min =  +0.00 V, max =  +4.08 V)
Vbat:         +3.20 V  
fan1:        1979 RPM  (min =   10 RPM)
fan2:           0 RPM  (min =    0 RPM)
fan3:           0 RPM  (min =    0 RPM)
fan4:           0 RPM  (min =    0 RPM)
temp1:        +34.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
temp2:        +35.0 C  (low  = +127.0 C, high = +70.0 C)  sensor = thermal diode
temp3:        +44.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
cpu0_vid:    +1.050 V
intrusion0:  OK

Remarks :
Is it normal that +5V is displayed as  +3.01 V ? Or should it be renamed as +...something else ?
in6 should not be ALARM ?

Thanks in advance



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

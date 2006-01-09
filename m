From: cpollock@earthlink.net (Chris)
Date: Mon, 09 Jan 2006 03:52:50 +0000
Subject: [lm-sensors] Temp and voltage on Gigabyte MB
Message-Id: <200601082152.57625.cpollock@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is only the 2nd time I've had to get lm_sensors to work so I may ask 
some dumb questions. I installed a new Gigabyte GA-K8VM800M board with an 
AMD Sempron 2800+ processor. After some false starts I finally got the 
correct kernel modules installed and loaded. Sensors is working, however 
I'm having problems with the the following:

Mboard temp jumps all over the place:
Temp1/MB:    +45?F  (low  =  +261?F, high =  +104?F)   sensor = thermistor
Temp1/MB:    +81?F  (low  =  +261?F, high =  +104?F)   sensor = thermistor   
ALARM

Some voltages aren't right either I suspect:
+3.3V:     +6.78 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
+5V:       +4.01 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
+12V:     +12.35 V  (min = +11.39 V, max = +12.61 V)   
-12V:      -7.72 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -4.77 V  (min =  -5.26 V, max =  -4.77 V)   ALARM

I also noticed that when loading sensord that three lines 
in /etc/sensors.conf are bad:

# Important - if your temperature readings are completely whacky
# you probably need to change the sensor type. This must be done
# with 'modprobe it87 temp_type=0xXX', you can't fix it in this file.
# See ../doc/chips/it87 for details and valid 'XX' values!!!
#
? ? label temp1 ? ? ? "Temp1/MB"
? ? set ? temp1_over ?40
? ? set ? temp1_hyst ?20 <----------------line 1194
? ? label temp2 ? ? ? "Temp2/CPU"
? ? set ? temp2_over ?45
? ? set ? temp2_hyst ?25 <----------------line 1197
# ? ignore temp3
? ? label temp3 ? ? ? "Temp3"
? ? set ? temp3_over ?45
? ? set ? temp3_hyst ?25 <----------------line 1201

I read through the docs on the it87 chip, but I'm really not sure what to 
place on the modprobe it87 temp_type= line.  As far as I can tell I have 
all the correct modules loaded:

i2c-isa ? ? ? ? ? ? ? ? 1600 ?0
it87 ? ? ? ? ? ? ? ? ? 20332 ?0
i2c-sensor ? ? ? ? ? ? ?2240 ?1 it87
i2c-viapro ? ? ? ? ? ? ?5900 ?0
i2c-dev ? ? ? ? ? ? ? ? 7616 ?0
i2c-core ? ? ? ? ? ? ? 19060 ?5 i2c-isa,it87,i2c-sensor,i2c-viapro,i2c-dev

This is on a Mandrive 10.1 Official release with kernel 2.6.

Thanks for any assistance.

-- 
Chris
Registered Linux User 283774 http://counter.li.org
21:35:06 up 1:53, 1 user, load average: 0.07, 0.22, 0.37
Mandriva Linux 10.1 Official, kernel 2.6.8.1-12mdk

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060109/8af66638/attachment-0001.bin

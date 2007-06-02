From: "Phil Endecott" <spam_from_lm_sensors@chezphil.org>
Date: Sat, 02 Jun 2007 19:48:46 +0000
Subject: [lm-sensors] Jetway J7F2 with f71805: PWM not working
Message-Id: <1180813726137@dmwebmail.belize.chezphil.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8036225795215877443=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8036225795215877443==
Content-Type: text/plain; format="flowed"

Dear All,

I have a Jetway J7F2 motherboard; it's a mini-ITX board with a VIA C7 
processor and the Fintec f71805f sensor chip.

Temperature and fan speed measurements work correctly, and most of the 
voltages look right to me.  I have no idea whether the values for 
Vtt1.2V, Vram, Vchip and Vcc1.5V are right:

# sensors
f71805f-isa-0290
Adapter: ISA adapter
+3.3V:     +3.42 V  (min =  +3.01 V, max =  +3.58 V)
Vtt1.2V:   +0.86 V  (min =  +0.00 V, max =  +2.02 V)
Vram:      +1.46 V  (min =  +0.00 V, max =  +4.03 V)
Vchip:     +3.58 V  (min =  +0.00 V, max =  +6.31 V)
+5V:       +5.13 V  (min =  +0.00 V, max = +10.59 V)
+12V:     +12.32 V  (min =  +0.00 V, max = +22.18 V)
Vcc1.5V:   +1.11 V  (min =  +0.00 V, max =  +2.02 V)
Vcore:     +1.09 V  (min =  +0.00 V, max =  +2.02 V)
5VSB:      +5.13 V  (min =  +0.00 V, max = +10.59 V)
CPU Fan:     0 RPM  (min =    0 RPM)
Sys Fan:     0 RPM  (min =    0 RPM)
Aux Fan:  4559 RPM  (min =    0 RPM)
CPU Temp:    +22������C  (high =   +70������C, hyst =   +69������C)         [diode]
Sys Temp:    +31������C  (high =  +255������C, hyst =    +0������C)         [diode]
Aux Temp:   +115������C  (high =  +255������C, hyst =    +0������C)         [thermistor]

(err, well some of those numbers look a bit odd but that's just because 
I have been messing around.)

Unfortunately, PWM fan speed control doesn't seem to work.  I can write 
things to the pwm /sys devices, but nothing happens.  For example, I 
have asked for them all to be off:

localhost:/sys/devices/platform/f71805f.656# for i in pwm*; do echo -n 
$i ': '; cat $i; done
pwm1 : 0
pwm1_enable : 1
pwm1_freq : 187500
pwm1_mode : 1
pwm2 : 0
pwm2_enable : 1
pwm2_freq : 187500
pwm2_mode : 1
pwm3 : 0
pwm3_enable : 1
pwm3_freq : 187500
pwm3_mode : 1

(I hope I have understood this correctly; 'enable=1' means manual 
control, and 'pwm=0' means off, right?)

But I still see 12V on all of the fan connectors and they run at full speed.

So the possibilities are:
- I'm doing something wrong (very likely, I'm new to this).
- The lm-sensors code is doing something wrong.
- My board doesn't actually have PWM control on these outputs and 
they're hard-wired to 12V.

Right now I think that the last of those is quite likely; I can't 
exactly trace the 12V from the power input all the way to the fan 
connectors, but I can see where it goes for much of the distance and I 
don't see any power transistors.

So, has anyone else had any experience with this board?  Has PWM been 
known to work with other boards with this chip?  Is it common for fan 
connectors to not have PWM control?

Finally, somewhat O.T., if it seems that I can't control the fan speed 
on this board, can anyone suggest a "hardware hack"?  In the past I 
have built fan speed controllers with thermisters and op-amps, but 
something with software control would be better.


Many thanks in advance for any suggestions.


Phil.






--===============8036225795215877443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8036225795215877443==--

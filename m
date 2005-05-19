From: bezza@org.ukr.net (Andrew Bezugly)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: cpu temperature discovering problem on w83627hf
Message-Id: <78496106515.20030519141928@org.ukr.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <70486737687.20030519114320@org.ukr.net>
In-Reply-To: <70486737687.20030519114320@org.ukr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Monday, May 19, 2003, 12:39:38 PM, you wrote:


>> temp1:       +46?C  (limit =  +40?C, hysteresis =  +37?C)
>> temp2:      +0.0?C  (limit =  +80?C, hysteresis =  +75?C)
>> temp3:     +1.5?C  (limit =  +80?C, hysteresis =  +75?C)

>> Temp1 is probably normal, but the other two  - ???
>> I have no idea how to cope with it. Could you help?

JD> You don't necessarily have them on your motherboard. They're here
JD> because they're supported by the chipset, but they may not be wired at
JD> all on your specific motherboard.

    I think there are 2 ones. (Bios shows 2 temperatures - for every CPU)

JD> Anyway, if you think they are, here are some hints.

JD> 1* Try changing the sensor type (edit the relevant lines in
JD> /etc/modules.conf). Don't forget to run "sensors -s" each time you
JD> change the value (I can't remember if it's actually required, but it
JD> won't hurt).

1)sensor*435:
  temp1:       +78?C  (limit =  +40?C, hysteresis =  +37?C) sensor = thermistor
  temp2:     +76.5?C  (limit =  +80?C, hysteresis =  +75?C) sensor = thermistor
  temp3:     +76.0?C  (limit =  +80?C, hysteresis =  +75?C) sensor = thermistor
2)sensor*=1:
  temp1:       +69?C  (limit =  +40?C, hysteresis =  +37?C) sensor = PII/Celeron diode
  temp2:     +72.5?C  (limit =  +80?C, hysteresis =  +75?C) sensor = PII/Celeron diode
  temp3:      +8.5?C  (limit =  +80?C, hysteresis =  +75?C) sensor = PII/Celeron diode

so both variants are wrong (and i was told to set sensor=2 by my server
producer too)


JD> 2* Try overloading your system (compile something big such as a kernel)
JD> and see if the values change or not. If they don't change, they're
JD> probably nor wired.

Nothing  changes.  But in any case BIOS shows temperature, so it is
possible!!!

JD> 3* You may need to plug external thermal sensors onto your motherboard
JD> in order to have the values reported. Though most sensors are internal,
JD> there used to be external ones.

There are AMD Ahlon MP 2200+ processors, they do have thermal sensors
into them.

JD> Finally, if you come to the conclusion they are not wired, simply add
JD> some ignore statements to /etc/modules.conf in order not to have them
JD> displayed anymore.


Any ideas?

-- 
Best regards,
 Andrew                            mailto:bezza@org.ukr.net



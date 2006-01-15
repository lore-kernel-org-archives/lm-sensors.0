From: emmanuel.fleury@labri.fr (Emmanuel Fleury)
Date: Sun, 15 Jan 2006 19:20:50 +0000
Subject: [lm-sensors] [Asus A8NE-FM/S] Unknown Chip
Message-Id: <43CAA092.9070600@labri.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <43CA1588.8060906@labri.fr>
In-Reply-To: <43CA1588.8060906@labri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> 
> This looks like A8000 chip (and picture of the MB confirms it). We had already some issue with this chip.
> (http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012777.html)
> We cant support it because we dont have datasheet. At least we can get some values from
> it via lm85 driver, just
> 
> modprobe the i2c-nforce2
> modprobe lm85 force_lm85b=0,0x2e
> 
> And now you should see some values from sensors command. Some may be completly wrong but some should be OK.
> 
> I hope this helps,

Definitely ! It (partially) works:

lm85b-i2c-0-2e
Adapter: SMBus nForce2 adapter at 4c00
V1.5:       +2.51 V  (min =  +0.00 V, max =  +3.32 V)
VCore:      +1.12 V  (min =  +0.00 V, max =  +2.99 V)
V3.3:       +3.39 V  (min =  +0.00 V, max =  +4.38 V)
V5:        +5.10 V  (min =  +0.00 V, max =  +6.64 V)
V12:      +12.25 V  (min =  +0.00 V, max = +15.94 V)
CPU_Fan:   1265 RPM  (min =    0 RPM)
fan2:         0 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU:        -128?C  (low  =  -128?C, high =  +127?C)     ALARM FAULT
Board:       +27?C  (low  =  -127?C, high =  +127?C)
Remote:      +40?C  (low  =  -127?C, high =  +127?C)
CPU_PWM:    57
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +1.550 V  (VRM Version 2.4)

Actually, some values seems to be quite irrealistic.
For example, I don't cool my CPU that much. :)

I'm really interested in having right numbers for the thermal sensors,
do you know what I could try ?

Regards
-- 
Emmanuel Fleury

Please do not shoot the pianist. He is doing his best.
  -- Oscar Wilde


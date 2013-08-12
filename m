From: Ian Pilcher <arequipeno@gmail.com>
Date: Mon, 12 Aug 2013 14:54:29 +0000
Subject: [lm-sensors] it87.fix_pwm_polarity
Message-Id: <kuasuu$1j8$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am setting up a Thecus N5550 NAS, and I found that the it87 driver
disables PWM control of the drive bay fan (it87.656/pwm3) unless I pass
the fix_pwm_polarity parameter.  Once I add that parameter, fan control
appears to work just fine.

Does this setting actually invert the voltage that is supplied to the
fan?  If so, does this have the potential to damage the fan itself (or
other components)?

Note that Thecus provides their own Linux-based "firmware" for this
NAS, so it's unlikely that they will ever change the way the BIOS sets
up the fans.  (And having the drive bay fan off by default may well
make sense anyway.)

Thanks!

-- 
====================================
Ian Pilcher                                         arequipeno@gmail.com
Sometimes there's nothing left to do but crash and burn...or die trying.
====================================


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

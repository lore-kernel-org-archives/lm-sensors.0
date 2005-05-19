From: Mario.Holbe@RZ.TU-Ilmenau.DE (Mario 'BitKoenig' Holbe)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: AS99127F: in7 + in8?
Message-Id: <20040303152742.GA16642@darkside.22.kls.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

my name is Mario, I'm running lm-sensors since a long time -
mostly on ASUS boards (:)) and like it very much.

A little while ago, (before lm-sensors 2.8.1) the sensor chips
on my ASUS boards have been detected as w83782d and did show
useful values for in7 and in8:
V5SB:      +0.13 V  (min =  +0.13 V, max =  +0.13 V)
VBat:      +0.08 V  (min =  +0.08 V, max =  +0.08 V)

As of version 2.8.1, they are (correctly) detected as as99127f
(and I have much less computes to apply :)), but don't show
in7 and in8 anymore.

Would it be possible to add support for those voltages for
the as99127f too? Or were that just dummies displayed when it
was detected as w83782d?


regards,
   Mario
-- 
Independence Day: Fortunately, the alien computer operating system works just
fine with the laptop. This proves an important point which Apple enthusiasts
have known for years. While the evil empire of Microsoft may dominate the
computers of Earth people, more advanced life forms clearly prefer Mac's.

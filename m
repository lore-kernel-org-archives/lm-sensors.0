From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: wrong data
Message-Id: <20030703111514.25480d39.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3413a$172dec20$f265a8c0@gf01>
In-Reply-To: <000801c3413a$172dec20$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi, i have a it8705F chip and when i run sensors shows very wrong
> data.

They are not that wrong. You are actually very near to a perfect
configuration. Let's take a look.


> VCore 2:   +1.31 V  (min =  +2.25 V, max =  +2.75 V)   ALARM

This one may simply not be used on your system. Not all systems use a
dual plan voltage. So, just add an ignore statement for it, or change
min/max to, say, 1.2 and 1.4.

> +3.3V:     +6.74 V  (min =  +2.96 V, max =  +3.60 V)   ALARM

Known problem, as read in the config file:
  # If 3.3V reads 2X too high (Soyo Dragon, for example),
  # comment out following line.
      compute in2   2*@ , @/2
So just do it.

> -12V:     -13.25 V  (min = -15.86 V, max = -13.40 V)   ALARM
> -5V:       -7.36 V  (min = -10.13 V, max =  -9.44 V)   ALARM

These ones are not used anymore these days. Just ignore them:
      ignore in5
      ignore in6

> fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM

You don't have a third fan, just ignore it:
      ignore fan3

> Temp2/CPU:   +89?C  (min =  +20?C, max =  +60?C)

This one is too high for sure. If it really is the temperature in your
computer case, you *should* do something ;) I think I remember your
changed the temp_type parameter and that the value you had before that
was -55?C, so the comment below for temp3 may simply apply to temp2 too.

> Temp3:       -55?C  (min =  +20?C, max =  +60?C)
You don't have a temp3 sensor. -55 is the minimal value for many temp
sensors, so this value usually means there's nothing to measure. Thus
you should add the following line to your config file:
      ignore temp3


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

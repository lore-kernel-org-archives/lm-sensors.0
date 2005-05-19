From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: changing pwm does not change fan speed
Message-Id: <1081438713.407571f9ce1d6@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <40756AB1.60005@laposte.net>
In-Reply-To: <40756AB1.60005@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

> I am using i2c-2.8.4 and lm_sensors-2.8.6 on an Asus A7V133-C
> Install ran fine and the detection as well.
> I came up with the lines :
>     # I2C adapter drivers
>     i2c-viapro
>     i2c-isa
>     # I2C chip drivers
>     w83781d
>     via686a
> for my /etc/modules file.

You can get rid of i2c-isa and via686a, they're useless on that board.
This is an integrated sensor but Asus chose not to use it and to add
their own monitoring chip (AS99127F) instead.

> But if I can't change the speed of the fan. I tried 'echo 10 > 
> /proc/sys/dev/sensors/as99127f-i2c-0-2d/pwm[12]' and It does not
> change the speed.

I'm not surprised. I tried this myself (it happens that I have the exact
same motherboard) and never could get my fans to change speeds. The
AS99127F support was added to the w83781d driver on the basis that it
was mostly the same chip, but without documentation. After
experimenting on several Asus chips, we discovered the following:

Register 0x5B, which is one of the PWM registers on Winbond chips, seems
to be a sensor type selection register, although only value 0 seems to
report valid values.

Register 0x59, which is the sensor type selection register for Winbond,
is a PWM register for Asus.

Asus PWM registers are split in two parts:
bit 7 is a mode selector
bits 6-0 are the PWM value

The problem is that we don't know exactly what the modes are, nor what
the value represents. Blame Asus for not releasing a datasheet.

So basically we should just discard PWM support from as99127f since we
mostly don't know how it works.

One more thing: there are two revisions of the AS99127F. I have a
revision 1, so I'd assume you do too. This revision doesn't appear to
have PWM support *at all* so you are probably wasting your time trying
to get it to work.

> I found in an old ticket (2001 or 2002) something about a bit that
> has to be changed to activate the pwm control but is it still true?

I don't think so, but you can still try to use i2cset to change
registers 0x59 and 0x5A. Still I think you won't get any result with
this board, if it has the revision 1 like mine do.

> Then another minor problem is I tried to use a script 
> (http://www.lula.org/pipermail/lula/2004-January/002290.html) but
> after launching it the values of the sensors command are stable and
> wrong and I couldn't figure why.

I don't know that script but I can imagine that it wrote random values
to registers 0x5A and 0x5B through the pwm files. Try the following:

i2cset 0 0x2d 0x59 0x9F
i2cset 0 0x2d 0x5A 0x9F
i2cset 0 0x2d 0x5B 0x00

This will hopefully restore the registers to the correct values and the
readings will come back. That said, I'm a bit surprised if it broke all
the readings since in my experience only the temperatures were affected
by register 0x5B.

> thank you for your help

You're welcome. Thanks for reporting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

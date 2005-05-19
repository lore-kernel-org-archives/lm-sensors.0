From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040521232049.43e567d3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516205100.GA9996@nemo.sby.abo.fi>
In-Reply-To: <20040516205100.GA9996@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonas,

Sorry for the delay.

> Attached is two incremental patches against drivers/i2c/it87.c, adding
> more support to the it87 fan controller driver in 2.6.6-bk2. Attached
> is also a small ruby script I use on my computer, just as an example.
> 
> it87_cleanups_jm1.patch:
> a rename to reflect the datasheet name better, removal of a old
> comment that doesn't apply anymore to the 2.6.x line

Interesting patch, see my comments below.

> it87_manual_and_auto_pwm_jm1.patch:
> manual and auto pwm support in one largish patch (I started to split
> this one into two separate patches, but it was too much work and I got
> lazy..).

One single 23k patch is too much IMHO and it would help if it was split.
However, I remember that we had trouble doing this with Takeru.

> The auto fan speed API is written to match these messages:
> http://archives.andrew.net.au/lm-sensors/msg07517.html
> http://archives.andrew.net.au/lm-sensors/msg07519.html

Note about this: I'm not proud of this interface, some points can
probably be improved, so there is no guarantee that it won't change
soon. But you had to start with something, of course...

> The following two pecularities of the it87 chip didn't exactly match
> that API suggestion:
> 
> 1. If the temperature of any programmed channel goes above
> fanX_auto_temp_max, all fans in sg-automatic mode turn on at maximum
> speed until the temperture comes down.

If this is how the chip behaves, you can't do anything. And it's not
really against the API.

> 2. The fanX_auto_temp_channel variables are bitfields, but they can
> only have one bit on (i.e., the possible values are 1, 2 and 4).

The API says how to represent things. It doesn't pretend that all values
are possible for every chip. Actually I expect most chips to behave like
the it87, and that bitfield thing looks overkill. It was really made for
the adm1031/adm1030 and I'm seriously thinking of changing this for
something more simple.

> 3. There are a lot of tunable settings files... The sysfs directory
> becomes quite cluttered. And the it87.c contains a lot of
> adminstrative overhead to set up all those files.

It's not supposed to be a problem. This is how the whole interface was
designed.

> 4. The fanX_auto_temp_* variables need to be mangled just like
> fanX_input (i.e., if you have a compute line in your sensors.conf, you
> need to do the same computation to values written to these files).

Unfortunately, it would require that libsensors knows about these files,
and it doesn't. And I it's probably not the right time to add it, since
the library is already severly overcrowded and would benefit a complete
redesign for 2.6. So I have nothing to offer for now. I guess the
problem is the same for the 2.4 driver?

About your code now. I only looked at the cleanup patch for now, sorry.

Moving the *100,/100 inside the conversion macros is right. There's no
need to split the 10*100, just write 1000. The 100 was introduced in the
first place because temperatures had a magnitude of 1 in 2.4 and 3 in
2.6. The correct fix would have been to change the macros, like you
propose now.

You could fix IN_FROM_REG(val) too, while you're at it. It misses a +5
for correct rounding. It's fixed in 2.4, but was forgotten in 2.6.

Once done, you should send this patch to Greg KH for inclusion into the
2.6 tree. CC: the list and say that I reviewed it, and it should be
fine.

Quick note about the second patch, although I didn't fully read it yet:

#define IT87_REG_OFF_TEMP(nr)  ((nr=2)?0x70:((nr=1)?0x68:0x60))

can be instead written:

#define IT87_REG_OFF_TEMP(nr)  (0x60 + (nr) * 8)

Same is true for all other macros you are introducing.

I'll read the rest tomorrow (hopefully).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

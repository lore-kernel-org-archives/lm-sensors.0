From: "Goede, J.W.R. de" <j.w.r.degoede@hhs.nl>
Date: Wed, 11 Jun 2008 08:18:48 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <web-88346509@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200806110520.m5B5KDgO018954@localhost>
In-Reply-To: <200806110520.m5B5KDgO018954@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Thanks for looking into this, I'm the author of the current

f71882fg driver and I have adding pwm support on my todo
list for quite a while now, but unfortunately sofar I
haven't found the time for it.

I have however already a clear idea how I would like to see
the pwm implement (but I'm open for discussion).

You've currently added both pwmX and fanX_target
attributes, but those both show (and store!!) the same
register in a different "notation", and at any given time
only one of the 2 notations is valid, depending on the
pwmX_enable attribute.

Allowing writes to pwmX when the fintek is pwm set in rpm
modes not pwm modes or the other way round is IMHO
unacceptable, as this will lead to bogues settings.
I have been thinking about this for some time now and I see
4 solutions for this:

1) Only support pwm modes as this is what all other hwmon
   IC's have, but this would require reprogramming the 
   auto_points when in rpm auto mode so that we get sane
   settings when reprogramming the f71882fg in auto pwm 
   mode. I don't like this as it causes the chip to be 
   reprogrammed from its bios defaults without the user
   asking for it.

2) make pwmX / fanX_target come and go depending on 
   pwmX_enable, so yes that would mean removing and adding
   sysfs atributes on the fly as pwmX_enable changes.
   Don't like it either, ugly, and racy what happens if an
   app keeps an attribute open?

3) mark the pwmX / fanX_target readonly, that is chmod
   the attribute on the fly as pwmX_enable changes, and 
   check in show/store_pwm if we are in pwm mode, if not
   return EPERM for store (fixes attr kept open race) and
   return -1 as value when showing. Still quite complex

4) See rpm mode as just a different pwm mode, pwm is
   0-100% dutycylce mapped to 0-255, see rpm mode as
   0-100% of the fan full speed count register, note this
   is how the target speed per section is set in the
   registers when in rpm auto mode, and such for auto mode
   has very much an 1-1 mapping for all the auto regs,
   which can fully reuse our existing defined sysfs attr
   for auto pwm control (pwmX_auto_point_*****)

   The only place where this mapping isn't 1 on 1 is for
   manual rpm mode, where the fintek allows you to
   specify hard go X rpm, but mapping this to a % of
   full speed should be easy.

I greatly prefer solution 4 for its simplicity and matching
our currently defined sysfs attr standard for pwm and auto
pwm I want to combine this with simply using either pwm or
rpm mode (depending on what the BIOS gives us) and not
allow changing this on the fly with pwm_enable, so reduce
pwm_enable to simply choosing between auto and manual mode.

I don't want to allow on the fly changing, because then the
meaning of a lot of registers change and they would all
need to be reinitialized to something sane in their new
meaning. We could add a module option to force either mode
at module load time (overriding bios settings for both the
mode and the zone settings).

Last is what todo with the full speed reg, I wonder have
you tested if this gets set to anything sane by the BIOS or
the chip itself? I know some hwmon IC's how have a register
like this start by running the fan at full speed for 2
seconds and then measure that speed and store that in full
speed, I wonder if that happens here. Anyways we should
create an atrribute for it and it shoud _not_ be called
fanX_max, max is already used in other cases and it means
give an alarm if the reading goes above this value. Instead
I would like to suggest to use what the datasheet uses and
call it fanX_full_speed

So what do you think of my proposal 4) for sysfs interface
for the pwm part of the f71882fg ? And would you be willing
to implement this?

Thanks & Regards,

Hans

p.s.

1) If you want we can continue this discussion in private
in Dutch, but I would greatly prefer to keep this on the
list in English

2) Being bold and assusming you're Dutch, where in the
Netherlands do you live? I'm always interested in meeting
fellow Dutch Linux hackers :)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

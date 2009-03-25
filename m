From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Mar 2009 09:04:13 +0000
Subject: Re: [lm-sensors] fancontrol
Message-Id: <20090325100413.3e1afe4b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergio,

It's a long long time since I last heard of Marius, I don't know if he
still cares about fancontrol.

OTOH we have a mailing list where this kind of inquiry should be sent,
so that others can comment and generally participate. I'm adding it to
Cc.

On Wed, 25 Mar 2009 05:02:56 +0300, sergio wrote:
> Hello Marius and Jean.
> 
> Sensors for fancontrol configures via hwmonN.
> But N depends on modules load order.

This is correct. This has been discussed on the mailing list recently:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025195.html

> fancontrol should use chip name for configuration

This would indeed help a lot, although not all chip names are stable
either. All *-i2c-* and *-spi-* names depend in part of the module
loading order of i2c and spi bus drivers, respectively.

> I think there are to ways for fix this.
> 1) use sysfsutils (or do this manually)

No, no, no. Sysfsutils is dead, please let it rest it peace. Not that I
really understand what you'd have done with it anyway...

> 2) rewrite it on c and use lmsensors library

This is a possibility, yes. I do not particularly love bash scripts
when they exceed a hundred lines, so I wouldn't necessarily object to
a rewrite. That being said, the script approach has the advantage that
it is extremely easy for users to customize for their own needs. They
don't have to download the sources and rebuild a binary. For a fan
control script this seems to have value. Users might miss this
flexibility if we switch to C. One advantage though is that fancontrol
would finally honor temperature adjustments made in sensors.conf.

A third possibility which was discussed in the thread I mentioned above
is a helper binary, linked with libsensors, which would take care of
translating hwmonN names to libsensors chip names and back. This could
be a special option of "sensors" or be implemented as a standalone
binary. This would make it possible for all scripts (pwmconfig,
fancontrol and possibly others) to work with libsensors chip names.
This should be fairly easy to implement, but OTOH this only addresses
one of the weaknesses of script-based sensors access. You'll still miss
all the other libsensors goodies (labels, ignores, temperature
adjustments etc.) unless the helper binary in question also offers an
interface to individual sensor values.

A fourth possibility is to let the user force the hwmonN number when
loading each hwmon driver, similar to what V4L drivers do. While this
works fine for experimented users, this can't be easily automated, so
it won't help mainstream users. So I suspect this would be a lot of
work for a very small benefit.

A fifth possibility is to try harder to always load the hwmon drivers
in the same order. In this respect, lm-sensors 3.1.0 should behave much
better than previous versions did. Did you give it a try?

> How can i help?
> I can try to rewrite it to c...

Honestly, I am not sure if it makes much sense to rewrite fancontrol as
it exists today in C. fancontrol is very limited in what it can do and
the conditions it checks. There are other control daemons out there
which are much more flexible, as they can change behaviors not only
based on temperature, and they can change a lot more settings than just
fan speeds. So, instead of rewriting fancontrol, I'd rather work on
integrating sensors better in existing daemons.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

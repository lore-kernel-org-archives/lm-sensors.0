From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: negative voltages
Message-Id: <1075721644.401e35ac8e6fc@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Jean Delvare <khali@linux-fr.org>:

> The problem is, I couldn't find in the 2.4 w83781d driver, nor in
> libsensors, nor in sensors, where the min and max are swapped,
> although the values are swapped in sensors.conf and it *does* work
> correctly with this combination of driver and user-space stuff. Can
> anyone point me to the place where the swapping is done?

I must have been sleeping or something last time I took a look. Swaps
are clearly documented in lib/chips.c for lm78, lm78-j, lm79, w83781d
and as99127f (list #1 in ticket 800).

This begins to make sense to me now. Sticking to the min and max as
defined inside the chips means that for chips in list #1 we'll have min
> max (but |min| < |max|), while for chips in list #2 we'll have min <
max. I guess that the decision to swap things was meant to have all
chips look the same.

I still don't get why 2.6 drivers don't work correctly, since the
swappings occur in libsensors and sensors.conf, not in the drivers
themselves. I guess that maybe some more exceptions hard-coded into
libsensors are required, will look into it. This probably means that
we could keep the swapping logic the way it is now.

Still my (slightly less strong now) opinion is that having min > max
for
negative voltages does make as much sense as the contrary, so I
wouldn't be against a massive cleanup. However, I'm not sure I fully
undertstand wether such a change would cause trouble to third-party
apps using libsensors or parsing the output of sensors. The fact that
limits order would become chip-dependant doesn't sound very well.

On the other hand, I dream of libsensors2 not containing any
chip-dependant code either, so we might have to learn how to live in a
limits-order-depend-on-chip world someday anyway.

Just some random thoughts about it all, add your owns if you wish :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

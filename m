From: michaellossin@alice-dsl.de (=?iso-8859-15?Q?Michael_Lo=DFin?=)
Date: Mon, 14 Aug 2006 12:22:29 +0000
Subject: [lm-sensors] asm58 driver (success, more or less)
Message-Id: <op.td9wnrvywm1swo@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have applied the asm58 patches as seen in
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015735.html
to lm_sensors-2.10.0 and kernel 2.6.17, respectively.

They mostly work, except for two minor glitches:

The asm58_features[] array in lib/chips.c must be terminated
by {0} -- otherwise sensors_get_all_features() might return
non-existing features.

And in hwmon/asm58.c, the div_mod stuff in show_fan() messes up the
values that I get on successive reads. For example, I might get (simplified)
3000, 1500, 750, 24000, 0, 0, 0, 0, ...
The first value is always correct.

When I comment out that block of code, I get the correct value (e.g. 3000)
on every read. Can anyone explain what that divisor shifting is about?

Temperature and voltage are always good, btw.

Anyway, is that driver still worked on? Is there a more recent version
available? I can test it, if you wish. (ASUS P4GE-FSC board)


Michael


From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: libsensors completed for 2.6
Message-Id: <3FBADC0E.6C375D56@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

except for those drivers with non-standard feature names in lib/chips.c.

I wrote a conversion function that converts all standard libsensors
feature names
(i.e. those that match the /proc names documented in
doc/developers/proc) to
the standard sysfs file names
(i.e. those that are documented in Documentation/i2c/sysfs_interface),
and the standard magnitudes documented there.

This saves about as much typing in lib/chips.c as I know how to save.

I know that Khali is working on additional standardization and changes.
These will have to be reflected in the function getsysname() in
lib/proc.c.

What's remaining is typing in the sysfs names for those features using
non-standard names (e.g. "3.3V").

But the majority of chips should just magically work now. Please test.
I'll announce it on the home page later in the week.

Thanks to Danny for the great patch which got me started.

mds

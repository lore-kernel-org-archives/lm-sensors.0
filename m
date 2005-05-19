From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: libsensors for linux 2.6
Message-Id: <20031116144447.6ac271ca.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I broke down and started integrating Danny's patch.
> stay tuned for progress...

Just one or two questions, since I haven't been watching the thread very
carefully - no time for this, sorry.

You might have seen my recent post about sysfs file naming conventions,
with questions about how to handle values that relate to more than one
sensor, relative hysteresis values and the such. The goal of this naming
convention is to have a common, standardized interface with libs and/or
user-space programs. The fact that libsensors has specific code for each
and every chipset is a problem. With a sysfs interface where each file
name can only represent one thing, this shouldn't be needed anymore.
This basically means that libsensors as we know it should *not* be
needed for Linux 2.6.

Of course, we would still need a way to tweak values, set limits, set
labels and ignore values. The source for this is in our sensors.conf
file. That should almost be the only common part between the old and the
new library. This make me wonder if this is a good idea to try having
only one library for both kernel branches. Why don't we start a 2.6
dedicated library? This would be libsensors.so.3.

That said, this would be better if we could all agree of the sysfs file
naming convention first. Please post your comments on the other thread.
Greg KH and Mark Hoffman already have clarified a number of things and
some points look OK now, but there are still some problems left.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Jun 2007 12:20:55 +0000
Subject: [lm-sensors] Hacking on libsensors
Message-Id: <20070626142055.079a4d89@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

My employer, Novell, has organized a "hack week". This is one week where
every employee is free to hack on whatever he/she wants [1].
Unsurprisingly I decided I would spend that time on libsensors. I
posted the idea here:
http://idea.opensuse.org/content/ideas/generic-sensors-library

I already made preliminary cleanups yesterday and this morning.
Tomorrow, serious things will begin. I thought I'd mention my plans
here, so that people get a chance to object before I commit my changes.

First of all, I want to remove all chip-specific code from both
libsensors and sensors. I think we all agree that it will ultimately go
away, and removing it from the way right now will make it easier to
focus on the new interface we want to expose. This will break sensord
(and all 3rd party libsensors users), but I don't really care. sensord
is not built by default, and we can fix it later. 3rd party apps will
need to be fixed later too.

Secondly, the sensors command-line interface. I would like to get rid
of -u (Treat chips as unknown ones) and -g (Use generic printing
routine for all chips), because they will be the default (and only way)
with the new libsensors interface.

I am also thinking of getting rid of -U (Do not show unknown chips),
because with the hwmon class, such chips can't be reached to start
with. However this raises the question of which kernel versions we want
the new libsensors (and the lm-sensors package in general) to support.
I don't think we want to support anything before 2.6.5 because the
sysfs interface changed too much before this version, and i2c had some
problems too (e.g. i2c-dev numbers not in sync with i2c-adapter
numbers.) But if we only support hwmon class access, this means we only
support kernels 2.6.14 and later. This is perfectly fine with me, but
I'm curious if others will object.

Then I'll be inspecting the libsensors interface as it is now. This is
the single most important thing to look at in order to be able to
release a new libsensors quickly. The rest can be improved later, but
the interface will be pretty much carved in stone for the next 8 years
(assuming the new library lasts as long as the previous one did, and I
hope so) once we release the first public version. Everyone, please
realize that the new interface will not be compatible with the old one,
and the new libsensors will get a new .so number. This means that this
is the perfect time to make all the cleanups and changes we can't do in
a stable library. It's basically now or never.

In parallel, I want to write a perl script to convert libsensors
configuration files from the old symbol names to the new ones. And move
the i2c tools to a separate package, as mentioned yesterday.

[1] http://idea.opensuse.org/content/hackweek

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

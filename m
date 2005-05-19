From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: header files installed by i2c
Message-Id: <WzPQcQZ4.1102415683.1379530.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041206225703.6b3f48e7.khali@linux-fr.org>
In-Reply-To: <20041206225703.6b3f48e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> At least i2c-dev.h and maybe parts of i2c.h are needed for userspace access
> to the i2c /dev interface.  What we probably should do is provide sanitized
> headers for that.  There might be other files that are legitimate parts of
> the userspace API too, I haven't looked closely.

i2c-dev.h was already sanitized and there are now two different versions
of that file, the kernel-space one (small) is in i2c and the user-space
one (large) is in lm_sensors (with no good reason to that IMHO).
User-space tools in the lm_sensors package only use i2c-dev.h (the
user-space one), not i2c.h. The user-space version of i2c-dev.h does
include all constants from i2c.h, so i2c-dev.h looks sufficient for
user-space programs (despite what our own documentation says).

I will remove all kernel header includes from i2c, as it sounds like the
right thing to do. If someone complains we'll see what needs to be done.

I also believe that the user-space i2c-dev.h should be part of i2c, not
lm_sensors. Don't know where to move it though, since we don't really
have a location for user-space header files at the moment.

Thanks,
--
Jean Delvare

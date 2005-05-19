From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
Message-Id: <20040403163031.122b5df8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40686476.7020603@convergence.de>
	<20040330213418.195dc972.khali@linux-fr.org>
	<406EBA38.1030203@gmx.de>
In-Reply-To: <406EBA38.1030203@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <m.hunold@gmx.de>, Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

> > This is where your approach looks slightly better than mine. With my
> > method, backward compatibility isn't provided. However, fixing
> > existing drivers would be rather easy, and I share Greg KH's view
> > that drivers living outside the kernel tree get the pain they
> > deserve.
> 
> 8-) If this is the way to go, I totally agree, even if that means that
> some drivers will fail to work in the beginning.

As the movie goes: "A beginning is a very delicate time."

> Hm, perhaps we should add another method where an adapter can specify 
> the I2C_DRIVERID_*s from the clients it's expecting. The rationale 
> behind this is, that most PCI cards can be identified uniquely by
> their vendor/subvendor ids, so the driver author definately knows
> which i2c clients are on the card and what are expected to be present.
> No need to probe every i2c client.
> 
> What do you think?

I'm a bit surprised because I thought such a function already existed.
After a quick glance I couldn't find it though. This would tend to prove
that the chip driver IDs were never used anywhere (since this is the
only use I can think of for them).

I think I remember Greg was even thinking of getting rid of them.

I'm not sure that the function you propose would be really useful. I
guess that most people don't load i2c chip drivers they don't need. The
class filter you propose, added to the different I2C addresses, should
do the rest.

On the hardware monitoring side, we usually have a detection function in
all chip drivers, which has the responsability to make sure that the
chip is actually one which the driver is supposed to support. I admit
it's not necessarily easy since there is no official ID such as for the
PCI cards. But we do it and in most cases it's efficient. Maybe you
don't have such a mechanism for the video i2c chip drivers? This would
explain why you feel the need of such a function when I do not.

I don't really see where/how such a function be, but if you want to take
a try and propose a patch, I'll take a look.

That said, it seems to be something different from the class bitfields
we were discussing so far, so it would be better to first go on with the
classes, and see the ids later.

Greg, any comment? Is the approach I suggested OK with you, or do you
prefer Michael's one (with the additional flag)?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

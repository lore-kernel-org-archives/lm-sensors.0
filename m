From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 29 Jan 2006 21:56:01 +0000
Subject: [lm-sensors] vt1211 questions
Message-Id: <20060129225601.696e685c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
In-Reply-To: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> At this point, I leave the mapping as it is (in 2.4) and make sure
> that the 2.6 version of the driver will have the same mapping. Maybe I
> will fix it in both 2.4 and 2.6 at a later time. It's not a high
> priority, just cosmetics.

We will most certainly need to do the same changes in 2.4 we had to do
for the vt8231 driver. But obviously not just before the freshly
announced 2.10.0 release. And you're right, the 2.4 and 2.6 drivers will
have to be in sync. This means not only the input numbers, but also, in
part, the values. Magnitude differences are OK, libsensors can deal
with them, but that's about it.

> I can certainly generate a patch and make it available for people to
> test it. Speaking of making kernel patches: I'm not too familiar with
> that. Am I supposed to generate a patch against the latest (devel)
> kernel or is 2.6.14 good enough?

I can only accept patches against a recent tree. Ideally, the latest
-mm tree. At the very least, Linus' latest (-git).

> I'll try to do that over the next couple of days. I also need to
> supply some basic information on how to use the PWM feature and it
> also requires a new sensors.conf since the 2.6 driver doesn't do weird
> scaling of temperature and voltage numbers anymore. It just returns
> the true register values and any scaling is performed via the compute
> lines in sensors.conf.

This might not be acceptable with regards to the standard interface as
defined in Documentation/hwmon/sysfs-interface. As much as possible,
the values you pass through sysfs must make some physical sense, even
if they are not direct readings. See how we did for the VT8231, it has
many common points with the VT1211 so you should be able to do the same.

> Is it possible to host the patch on the lm-sensors webpage and maybe
> issue a call to VT1211 users? Just like you did it with the VT8231.

We can't really host temporary files on the lm-sensors webpage, but we
can make annoucements and point to any external URI you'd have set up.
If you can't host the patch yourself, just send it to me and I'll make
it available on my server (if so, I'll also update it after that as
needed.)

Thanks,
-- 
Jean Delvare


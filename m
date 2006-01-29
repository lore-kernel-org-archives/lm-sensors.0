From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 29 Jan 2006 21:32:35 +0000
Subject: [lm-sensors] vt1211 questions
Message-Id: <191fb4ca0601291332o15320ab4tc4fcceaa5f2d8bdf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
In-Reply-To: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> Hello all,
>
> Juerg are you still working on the port?

Yes

> Seems Tomislav wants to test it...

Good. The more testing the better.

[snip]

> > I'm currently modifying the vt1211 driver to add PWM fan control and
> > for (yet another) attempt to submit it to the 2.6.x kernel
> > tree. While
> > going over the code (Lars Ekman's port of Mark D. Studebaker's
> > original driver) I noticed 2 things:
> >
> > 1) The mapping of the temperature reading to the actual sysfs node
> > name is convoluted. I.e. Reading1 maps to temp3 and Reading3 maps to
> > temp1. Comments in the code mention that this is to minimize changes
> > from the via686a driver. Since I'm currently cleaning up
> > and extending
> > the code there's probably not much commonality between the two
> > anymore. So should I change that convoluted mapping to
> > Reading1->temp1
> > and Reading3->temp3? It's much less confusing... :-)
>
> Well this must be done in 2.4 tree too. If you want to change
> it then why not...

At this point, I leave the mapping as it is (in 2.4) and make sure
that the 2.6 version of the driver will have the same mapping. Maybe I
will fix it in both 2.4 and 2.6 at a later time. It's not a high
priority, just cosmetics.

> > 2) 'Sensors' doesn't read temp1 because there's another note in the
> > code saying that temp1 (Reading3) is not implemented in
> vt1211. That's
> > not true, in fact Reading3 is the vt1211 internal thermal diode. So
> > 'sensors' (and the libs) needs to be patched as well..
>
> This was already fixed by you. It was removed by mds with the
> in6 two years ago.
> I found a datasheet here:
> http://ftp.21ic.com.cn/%E6%8A%80%E6%9C%AF%E8%B5%84%E6%96%99/VI
> A%20CHIPSET/VT1211.PDF

The datasheet states that temp1 is reserved for the internal
temperature. That doesn't mean it cant be read. And yes, it's fixed in
the current CVS version..

> With that I'm proposing the following changes to the vt1211 driver
> (both 2.4.x and 2.6.x) and the 'sensors' application (and all involved
> parties/libraries as well of course):
>
> Old:
> Reading1 -> temp3 (read by 'sensors')
> Reading3 -> temp1 (ignored by 'sensors')
>
> New:
> Reading1 -> temp1 (read by 'sensors')
> Reading3 -> temp3 (read by 'sensors')
>
> And of course sensors.conf has to be patched as well.
>
>
> Yes I agree. Why not. We will relase soon new lm-sensors version with old mapping. Maybe
> if you want to release your driver soon just do as it is now, so people can use this version and > not the CVS one...

As mentioned earlier, I'll make sure the 2.6 driver has the same
mapping as the current 2.4 driver.

> Please let us know if you already have something for 2.6 Maybe some base patch without PWM > first?

I do have a working (I believe) 2.6 version that does have PWM
support. Unfortunately I can't fully test it, because VIA decided to
*not* use the PWM outputs on the EPIA M10000 board (how stupid is
that?). The fans are just connected to 12V and are always running full
speed. I'm thinking of maybe reworking my board... :-)

I can certainly generate a patch and make it available for people to
test it. Speaking of making kernel patches: I'm not too familiar with
that. Am I supposed to generate a patch against the latest (devel)
kernel or is 2.6.14 good enough?

I'll try to do that over the next couple of days. I also need to
supply some basic information on how to use the PWM feature and it
also requires a new sensors.conf since the 2.6 driver doesn't do weird
scaling of temperature and voltage numbers anymore. It just returns
the true register values and any scaling is performed via the compute
lines in sensors.conf.

Is it possible to host the patch on the lm-sensors webpage and maybe
issue a call to VT1211 users? Just like you did it with the VT8231.

Thanks and regards
...juerg



> regards
> Rudolf


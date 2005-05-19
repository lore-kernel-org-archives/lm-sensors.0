From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-i810.c
Message-Id: <20030719084233.47488dd7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
In-Reply-To: <Pine.LNX.4.21.0307181618400.1795-200000@conradin.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > the same in 2.7.0 and 2.8.0. Only the get family was changed. Please
> > take a look at the attached patch and tell us if reverting this part
> > is enough to get the driver to work again for you.
> ???
> Then I will have 2.7.0 again... And this version doesn't work, as
> stated in my first message.

No, no. There have been a *lot* of changes between 2.7.0 and 2.8.0. What
I want you to do is revert a very small portion of these changes on your
2.8.0 version, and see what happens. If it is enough to make it work
(which means it is functionally equivalent to the changes you proposed),
it would give us a point to start from.

> > Also, could you tell us which chip driver is used for your tv
> > encoder? And is your monitor DDC capable or not?
> No my monitor is not DDC capable.

i2c-algo-bit's bit_test failing is normal in this case, this is even the
wanted behavior. Or what would this parameter be useful for?

> There is no chip driver for the TV
> Encoder. But there is a userspace programm:
> http://tumult.textalk.se/chp3258.html
> BTW: The patch you can download there didn't work for me.

I don't remember this guy sending that patch to us. I *hate* it when
people use our modules, modify them and don't even take the time to tell
us about their changes. Don't they understand how free software works,
or what? :(

> Maybe you could just put this patch in a contrib directory, for
> further evalution... I don't know....

We don't really have such a directory, but we still can give the patch
to anyone contacting us with the same problem as you have.

> I just thought I sould send it to you, because it took me a lot of
> time to get it working....

Yeah of course, I understand. It's always great to solve that kind of
problem and you are very welcome to share your experience with us. All I
meant is that we can't apply patches just because one use says it works
for him/her. We need to know why it works, especially if the change does
not match the specs, as it seem to be the case here.

Anyway, I am not the one who will handle that, I don't know enough about
bus drivers to do so. Philip Edelbrock and Mark D. Studebaker will
probably be more helpful than me.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

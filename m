From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Patches for 2.6.0 (lm83 and misc)
Message-Id: <20031009232315.7361ef4b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031004160750.70561b1d.khali@linux-fr.org>
In-Reply-To: <20031004160750.70561b1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Please find attached three patches for Linux 2.6.0(-test6).
> 
> Thanks, next time could you send me 3 different email messages?  1
> mail per patch is much easier to handle, I had to split this up into 3
> different messages to apply them to the bk repository.

Sorry, I should have guessed that, since that's always how you are
sending your patches yourself. I'll remember that for the next time,
hopefully.

> > The main patch adds support for the LM83. I followed all your
> > recommendations, so I hope it is all correct now, but feel free to
> > buzz if something isn't.
> 
> Thanks, looks good.  I've applied this, but will have to hold on to it
> until 2.6.0 comes out, as no new drivers are going to be able to be
> added.  Don't worry, I'll keep track of it and will send it to Linus
> when 2.6.0 comes out.

OK, no problem.

> > The second patch corrects some errors in i2c/chips/Kconfig.
> > The third patch fixes all chip drivers (but lm83) by moving the
> > initialization before any sysfs entry is created, as you once
> > requested.
> 
> I've applied these two patches, and will send them to Linus in a bit.

Well, at least these ones won't be delayed :)

> > I don't think it is worth backporting that to CVS. It is very
> > unlikely to cause problems, isn't it? I can't even think of a
> > scenario that would.
> 
> You could open the sysfs device and ask for a sensor setting before
> the device was initialized, right?  This patch is a good thing and
> should also go into the 2.4 tree.

Yes I could, and in most cases it wouldn't cause any problem. I'd expect
it to return the correct value, simply because the BIOS will have
initialized the chip with reasonable configuration and limits. Remember
we are even considering *not* initializing chips by default (and I
believe it will end up this way someday).

And second, the probability that a userspace application will read the
sysfs/procfs file at the exact moment the driver is being loaded is near
zero IMHO. Which doesn't mean it will never happen, but
{improbable,harmless} doesn't belong to my high priority to-do list.

> > Future plans:
> > - Update my chip driver porting guide, publish it (lm_sensors CVS,
> > should it go into Linux 2.6.0 as well?)
> 
> Not really, the cvs tree is good, as it doesn't make much sense when
> only looking at the 2.6 tree, right?  :)

Does it make more sense when only looking at the CVS tree, which is 2.4
dedicated? Probably not. This is, well, a conversion guide... Needs both
sides to make sense, I believe. However, I like the idea of having it in
a single place, since I'm tired of keeping files in-sync (i2c-id.h comes
to mind), and the CVS tree is easier for me to access.

> > - Port my lm90 driver.
> > - Port the adm1025 driver.
> 
> Nice.

I'll wait until the lm83 driver is accepted. That way, if changes are
needed for that driver, I won't have to fix these things for the new
drivers.

> thanks again for the patches.

You're welcome. Thanks for your excellent job too :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

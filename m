From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 07 Mar 2007 09:36:44 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070307093644.GC4285@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <7UgM5-np-1@gated-at.bofh.it> <7UgM8-np-11@gated-at.bofh.it> <7UnaS-2xP-9@gated-at.bofh.it> <7UnkC-2JB-9@gated-at.bofh.it> <7Uzcd-49u-3@gated-at.bofh.it> <7UEEN-4xi-3@gated-at.bofh.it> <E1HODgC-0000h8-Vc@be1.lrz> <20070306161935.025a3ec1.khali@linux-fr.org> <Pine.LNX.4.58.0703061804360.2988@be1.lrz> <20070307101758.8cf2c53d.khali@linux-fr.org>
In-Reply-To: <20070307101758.8cf2c53d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Bodo Eggert <7eggert@gmx.de>, David Hubbard <david.c.hubbard@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>, Rudolf@atrpms.net

Hi!

> > > > 2) make ACPI take this lock whenever it touches ports not allocated by itself
> > > >    and release it on function return.
> > > 
> > > This is costly.
> > 
> > TANSTAAFL. You'll need to take some lock, and if you want port emulation 
> > or per-device-mutex, you'll have to pay the price.
> 
> True, but precisely, I wonder what will perform the best in practice, a
> single semaphore that is unconditionally taken by ACPI/AML, or your
> finer-grained approach and its many additional tests.

I'd say mutexes are not that bad. ... i/o accesses are expensive,
anyway, right?

> We may be able to workaround the inter-driver exclusion though, if we
> use a semaphore initialized to N, have ACPI take N, but other drivers
> take just one. This would let ACPI be exclusive with all the other
> drivers, but drivers themselves could otherwise run concurrently. That
> being said, we do not appear to have the required primitives to take
> more than 1 semaphore resource at once at the moment, so we'd need to
> do that first.

Hmm, nice hack. Yes, driver-driver serialization would be nasty.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


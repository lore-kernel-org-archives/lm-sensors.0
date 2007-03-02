From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 02 Mar 2007 11:31:58 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070302113158.GC2156@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com> <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070301174806.GA4979@redhat.com> <20070302122736.f14a7a22.khali@linux-fr.org>
In-Reply-To: <20070302122736.f14a7a22.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Dave Jones <davej@redhat.com>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi!

> >  > Firstly, the first records of hidden SMBus, in September 2000, predate
> >  > ACPI.
> > 
> > The earliest ACPI spec I have handy is 1.0b, which came out in Feb 2 1999
> > so this isn't true. The all knowing (and always accurate :) wikipedia
> > claims it was first released in 1996, though I believe that all the pre 1.0b
> > machines were using acpi implementations before the standard was finalised.
> > 
> > I certainly remember seeing ACPI capable machines circa 1997/1998.
> 
> Yeah, and these early ACPI implementations were so good that we have an
> option to blacklist them.
> arch/i386/defconfig:CONFIG_ACPI_BLACKLIST_YEAR 01
> 
> My point (which you didn't quote) was that there is no correlation
> between the SMBus being hidden and ACPI accessing the hardware
> monitoring chip, contrary to what Pavel was suggesting.

It may not be correlated with ACPI, but BIOS authors clearly want to
keep you away from their SMBus controllers....
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


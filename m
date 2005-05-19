From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <20030907181045.6ff920f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> On sybyte and max1617 we should try and find the authors and bring
> them into the fold.

The author is Kip Walker from Broadcom Corp., it seems. Googl'ing the
name should provide an e-mail address, but I admit I'm too busy to
contact him right now, and I hope that one of you will do so.

> On you moving on, hopefully you can find 1-2 hours a week for us which
> would still qualify you as "active"! We've appreciated your energy and
> enthusiasm(and new ideas) over the recent months, especially as it
> came when I was running out of all of those...

Finding a few hours a week won't be difficult, especially since I
*really like* contributing to the project. The real difficulty for now
is that I hardly have a place I can call home (although I *do* have a
flat now). Hopefully, I'll have brand new bed and fridge there within a
few days, a phone line and, even more important, power supply :) Once
all these are OK, I'll move there for good and you'll see more often
again.

> Any proposal for how to proceed with the 2.4 patch?

Release 2.8.1 (hi, Phil ;)), generate patches, post patches on LKML.
Wait and see.

Phil, I remind you that you don't have to bump the library's version, as
I already did.

> Without you to generate a 2.8.1->2.4.23 patch, what should we do?

There's no such thing as "without me". I won't let you down :) The patch
is almost already generated. The patches I made available for Linux
2.4.22 users will be OK for inclusion into Linux 2.4.23, with the
exception of the main patch that will have to be regenerated once i2c
2.8.1 is released. But that one is automatically generated, so that's
not a big problem.

The main concern IMHO are the new sibyte and max1617 drivers, that
really entered the tree at the worst possible time. I don't know exactly
what to do with them. Wiping them out is bad. But integrating them
correctly could take some more time. Suggestions welcome.

> And if you don't mind, what are you going to be doing for a living?

I've been hired as a development engineer (and that's great, because
that's what I just am). I'll be working in Paris (well, so near that
it's the same) and living there too (likewise, so near that's it's the
same, although that's not the same "so near", unfortunately). My first
task will be about web application development, using PHP 4 and a some
HTML/CSS design too.

> thanks again

You're more than welcome. Not sure who should thank the other here :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

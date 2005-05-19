From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041130040944.GB32741@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark:

* Mark D. Studebaker <mds4@verizon.net> [2004-11-29 20:09:35 -0500]:
> Not sure what BIOS stuff you took out (#2), but I don't think it would be 
> very clean
> to have two different drivers supporting the same chips, so that doesn't 
> sound good.

I took out the force_addr module parameter, which is used when the BIOS
doesn't allocate an IO region properly.  Any BIOS which is broken enough
to do that is probably not going to route the IRQ properly either.  One
alternative would be to do a driver that supports polling and IRQ modes
(ala i2c-keywest and others) but that's a lot of extra complexity for
IMHO not much gain.  I found that code much harder to read.

There is precedent to having two implementations of the same driver -
at least Adaptec 2940 that I know of.  Ultimately it's up to Greg I
guess...

> Removing block transactions and PEC (#1 and 3) isn't wise, and not just 
> because
> I did most of that code and it was a lot of work :) 

As I mentioned, that's TODO.  I wasn't going to ask for this to be merged
until I implemented the remaining transactions.  BTW I still assert that
(some) block transactions of the existing i801 driver have major problems...

http://archives.andrew.net.au/lm-sensors/msg18794.html

> The 801 driver covers a large number of popular chips,
> and has possibly the highest "market share" of all the bus drivers.
> It's essentially our "reference design" for block and PEC transactions
> and is the driver I've often used to test the i2c-core and i2cdump 
> implementations for these transactions.
> Just because most bus drivers don't have block and SMBUS 2.0 transactions 
> doesn't mean
> we should take it out of the 801. 

OK

> And I wouldn't give up on SMBus 2.0 yet. The W83791D sensor chip supports 
> it;
> if the W83792D does as well (awaiting datasheet from Winbond), we can 
> enable it
> in the forthcoming driver from Winbond and have end-to-end hardware error 
> checking for
> i2c transactions on a system with a 792 and a 801, should such a system 
> appear.

I might own one myself.  I just noticed that CVS sensors-detect finds a
792 now.  I think it's unlikely, as I *know* this board has a 627thf (I've
been using it for a while and have physically located it on the board).
I'll have to open it up again and search for the 792.

So, assuming I really have one of these, and that it (792) does PEC...
that will make for easy testing. :)  Speaking of which: I ran my tests
on an ICH5, let me know if you get it to work on one of the other
supported chipsets, especially the older ones <= ich3.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

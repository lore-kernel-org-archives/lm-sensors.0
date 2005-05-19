From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: update to ticket 871
Message-Id: <3CC0EBC6.1243348F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020418025107.GA11747@gwaihir.linuxfromscratch.org>
In-Reply-To: <20020418025107.GA11747@gwaihir.linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I need the mfr. ID at 0x4f and it is two bytes, you
need to do the high byte switch.

If you are feeling brave, please do:

	prog/dump/i2cdump 0 0x2d #high byte dump
	prog/dump/i2cset 0 0x2d 0x4e 0 #set low byte
	prog/dump/i2cdump 0 0x2d #low byte dump
	prog/dump/i2cset 0 0x2d 0x4e 0x80 #back to high byte

We want to see if the Vendor ID register at 0x4f changes
when you switch the high/low access.
And does it change any other time.

If that really is a ID register then I can recognize it.


gerard@linuxfromscratch.org wrote:
> 
> I didn't see an option to add more info to a ticket.
> 
> Anyway, here's what one of you guys wrote:
> 
> Reply from support:
> 
> The perl warnings aren?t the problem.
> You have some chip we don?t support. Sorry.
> Look at your board, see FAQ.
> 
> Have a look at ticket 875 - it fixed the problem for me:
> 
> Problem in detail:
> 
> Just did some more fiddling on an Asus P4B266 Board:
> 
> while the w83781d driver does not recognice this new chip as something it
> can talk to, forcing the chip to as99127f on module load does get good
> results:
> 
> ==> 
> Perhaps that's something that can be added to the w83781d driver?
> 
> --
> Gerard Beekmans
> www.linuxfromscratch.org
> 
> -*- If Linux doesn't have the solution, you have the wrong problem -*-

From: sevans@vmetro.com (Steve Evans)
Date: Mon, 17 Oct 2005 17:22:41 +0000
Subject: [lm-sensors] Support for Linux 2.6 only drivers
Message-Id: <507CF24DDCB8114C82ABCC09CBC1E9EE75C2C2@transtech-2000.transtech.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
In-Reply-To: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > Given that the devices are very similar I think it would be best to 
> > conditionally include (or rather exclude) support for the AD7416 and
> > AD7418 so that anybody needing support for these devices 
> will at least 
> > have a good starting point.
> 
> Conditional on what? Configuration option?

That would clearly be the correct thing to do in the long term, but
until such time as the driver had been tested in all possible
configurations, I believe it would be better to stick 3 #defines (one
for each device) at the top of the driver source file with the comment
that only the AD7417 code had been tested. It should also state that
that the AD7416/8 code (of which there is very little) was there as a
courtesy to assist any future developer who may benefit from it and be
in a position to test it.

The (cleaner?) alternative would of course be to only supply fully
tested source and leave support for the other two devices as an exercise
for the future.

> > Should I send a copy of the driver to the <sensors at stimpy dot 
> > netroedge.com> alias for comments before proceeding?
> 
> Don't know where you found this address, but it is

doc/developers/new_drivers, line 137 or thereabouts.

> deprecated. I thought I had ripped off any reference to it in 
> our documentation. Simply post to this mailing list, and 
> we'll try to review your code as time permits.

OK.

Thanks,

Steve

> Thanks,
> --
> Jean Delvare
> 

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 13 Aug 2012 20:02:01 +0000
Subject: Re: [lm-sensors] Please reconsider SCH5514
Message-Id: <20120813200201.GA19345@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <c966e4f2e75e94e9ebf54ef8b7a6237d.squirrel@libra-investments.com>
In-Reply-To: <c966e4f2e75e94e9ebf54ef8b7a6237d.squirrel@libra-investments.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 13, 2012 at 11:17:55AM -0700, Norbert Schlenker wrote:
> > Hello,
> >
> > Have you seen this: http://www.spinics.net/lists/lm-sensors/msg24621.html ?
> >
> > Without having full specifications it's hard to write a driver, and signing
> > a NDA goes against open source (Non Disclosure Agrement <> Open Source).
> >
> > Regards
> > Ian Dobson
> 
> Thanks for the pointer.
> 
> Email sent to Mark Hoffman asking if the driver was ever released.
> 
I don't think so - I don't find one anywhere in the archives.

Key problem, though, is really the lack of a data sheet. Even if someone would
be able to get a data sheet under NDA, it might be impossible for that person
to publish a driver, since publishing register details (as one has to when
publishing a driver) would very likely violate the NDA.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: spstarr@sh0n.net (Shawn Starr)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: 2.5.54 lm_sensors stuff
Message-Id: <200301111757.31401.spstarr@sh0n.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301100001.59064.spstarr@sh0n.net>
In-Reply-To: <200301100001.59064.spstarr@sh0n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Also, this may not work as a module since im using it compiled in.

On Saturday 11 January 2003 5:55 pm, Shawn Starr wrote:
> Here it is, but as I said, its a really bad hackup I would apply this on a
> separate tree not to break anything ;)
>
> On Friday 10 January 2003 10:18 pm, Mark Studebaker wrote:
> > great.
> > please email your diffs to our list
> > thanks
> >
> > Shawn Starr wrote:
> > > I managed to get my sensors chip
> > >
> > > w83782d-i2c-0-2d
> > > Adapter: SMBus AMD75x adapter at e4e0
> > >
> > > Working with 2.5.54 but its very ugly hacking and backports some minor
> > > changes.
> > >
> > > the w83782d driver isn't in 2.5.54 (haven't checked .55 yet) but this
> > > works with a few minor changes.
> > >
> > > Shawn.

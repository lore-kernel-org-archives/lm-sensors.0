From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Apr 2007 11:53:48 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070423135348.16f111d8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Apr 2007 21:03:02 +0200, Axel Thimm wrote:
> Hi,
> 
> On Sun, Apr 08, 2007 at 07:40:30PM +0200, Jean Delvare wrote:
> > > But you do get a marker for copies or merges that you can follow to
> > > fork off A's history into B's.
> > 
> > True, but that's hardly convenient if merges are frequent and/or if the
> > number of branches is important. I start understanding why people
> > working with many branches don't even consider Subversion.
> 
> Well, git was written with merges as the first priority, as the kernel
> is being cloned and developed as several places
> simultaneously. mercurial has also better merge support.
> 
> I just stumbled over the following (which is why I'm replying to this
> old mail):
> 
> http://subversion.tigris.org/merge-tracking/
> http://www.orcaware.com/svn/wiki/Svnmerge.py
> 
> E.g. svn will one day have the support you need, but you need it
> today. :(

I don't think we can see we _need_ it. If it was there, we'd use it.
It's not, we'll do without it, no big deal. We'll simply go with the
parallel commit proposal I made a few days ago, and that will be fine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

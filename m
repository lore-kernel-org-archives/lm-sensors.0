From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] new sensors driver: SMSC LPC47B397-NC
Message-Id: <20050106233239.GA17040@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050102212924.GB17759@jupiter.solarsys.private>
In-Reply-To: <20050102212924.GB17759@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 06, 2005 at 06:17:22PM -0500, Mark M. Hoffman wrote:
> Hi Greg:
> 
> I wrote:
> > > How about this:
> > > 
> > > Signed-off-by: Craig Kelly (In-Store Broadcasting Network)
> > > Signed-off-by: Glenn Ball (Utilitek Systems, Inc.)
> > > Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> > > 
> > > The first two aren't going to maintain the driver anyway, but I want
> > > the signatures there as contributor of the datasheet and holder of the
> > > copyright, respectively.  If I'm going to "sign-off" that I am allowed
> > > to distribute this work, then I also want to include from whom this
> > > permission came.  Linus wrote [1]:
> 
> * Greg KH <greg@kroah.com> [2005-01-06 14:33:54 -0800]:
> > That's an ok way to do it, but I _really_ would like to see real email
> > addresses in the signed-off-by line, as it helps out in the end for
> > figuring out problems.
> 
> I understand that one motivation for signed-off-by is to have a follow-up
> path for technical problems... why else do you need an email address?

It's easier to show "who did what" by an email address.  That's why we
ask for it.  See the shortlog program that we have to track email
addresses to names for an example of this mapping.

> I can't speak for Craig, but Glenn Ball (my boss) does not want to get email
> about technical problems with this driver.  Or just in case you're talking
> about legal problems, lawyers can well enough find contact info based on
> those lines.  If you absolutely insist, then I would rather remove at least
> Glenn's line, and I'll let Craig speak for himself.

No, I'm not insisting, the above change is fine with me, I just will not
accept the obfusciated version you originally posted, as that's just
trying to hide something that should not be hidden (hey, spam filters
are free...)

thanks,

greg k-h

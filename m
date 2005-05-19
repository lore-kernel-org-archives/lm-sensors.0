From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c patch out of 2.6.4-rc1-mm1
Message-Id: <20040301211637.GE10354@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1078150396.404344fc41690@imp.gcu.info>
In-Reply-To: <1078150396.404344fc41690@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 01, 2004 at 09:33:51PM +0100, Jean Delvare wrote:
> > Ok, how about doing this:
> > 	- make a lmsensors release now.  I'm not going to send any i2c
> > 	  patches to Linus until after 2.6.4 is out, so you can cut a
> > 	  release today if you want to.
> 
> Aha. This sounds good indeed. You always end up with a fine solution
> even when I feel like everything's bloated, don't you? :)
> 
> Yes, if 2.6.3 and 2.6.4 are compatible i2c-wise, releasing now makes
> sense, and solves problems.

You might want to validate this with 2.6.4-rc1, but I'm pretty sure no
i2c changes made it into there.  If not, great, release away!

> > 	- add your fixes to the lmsensors cvs tree, so that users of the
> > 	  -mm kernel can get them if they want to.  Idealy you could
> > 	  also make another lmsensors release, as these patches will go
> > 	  into Linus's tree after 2.6.4 is out.
> > 
> > Sound good?  That way the i2c patches can go back into the -mm kernel,
> > and users can test them and the lmsenors changes out.
> 
> I don't think we would make two releases. But pointing -mm people to the
> CVS makes sense.

Ok, that's fine with me.

> The next release would occur as Linux 2.6.5 will be released, providing
> that the i2c changes have been successful in their -mm series life and
> have made it into Linus' tree.

Again, that's acceptable to me too.

thanks,

greg k-h

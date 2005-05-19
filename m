From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: user/kernel bug and memory leak in i2c-dev
Message-Id: <20030806185108.GA6946@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805211609.4a3a66d2.khali@linux-fr.org>
In-Reply-To: <20030805211609.4a3a66d2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 06, 2003 at 09:36:14AM +0200, Jean Delvare wrote:
> 
> > > As you may have seen on LKML (and this list) we have a patch ready
> > > to fix the two problems mentioned in topic. I will submit it for
> > > inclusion into Linux 2.4 tomorrow. I think I need to CC: Marcelo for
> > > it to work, right?
> > 
> > Yes.  I'd be glad to send it to him if you want me to (with your
> > attribution of course.)
> 
> I think I'll do it for 2.4. The i2c subsystem in 2.4 is in sync with our
> CVS (well, it *should* be) so it's "legitimate" (or say logical) that
> the people maintaining i2c-CVS submit fixes for inclusion into the 2.4
> kernel.

Thanks, Marcelo said he applied your patch, so it will show up in the
next release.

> OK, will do so.
> (working)
> Here it is (warning: not even tested, but it's the same as 2.4's one,
> which I tested).

-ENOPATCH  :)

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] Refactor swap_bytes in i2c chip drivers
Message-Id: <20040408172316.GA10734@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329212303.2b47b12d.khali@linux-fr.org>
In-Reply-To: <20040329212303.2b47b12d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 03, 2004 at 01:04:24PM +0200, Jean Delvare wrote:
> > > > Ick, no, we should be using the proper kernel call for this,
> > > > swab16(), right?  Care to redo this patch to just fix the drivers
> > > > and get rid of our duplicating of this function.
> > > 
> > > Oh, I didn't know such a function existed, sorry.
> > > 
> > > Here's a new patch, hope you like it. Tested to work on my as99127f,
> > > btw(w83781d driver).
> > 
> > Looks good, applied, thanks.
> 
> Hm, it doesn't show in linux-2.6.5-rc3-mm4, although all others patches
> you accepted the same day do.

Hm, odd.  You are right, I just went and applied it again.  Sorry about
that, sometimes bk just doesn't apply the patch...  Or I messed up with
all of these different ones floating around :)

thanks,

greg k-h

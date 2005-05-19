From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040210185341.GA29251@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 10, 2004 at 10:36:45AM +0100, Jean Delvare wrote:
> > > At the time it was decided to switch to a one-file-per-value logic
> > > (and I agree it was a good idea), it would have been clever to use
> > > the library's symbol names as the files names. For one thing, it
> > > would simplify the libsensors tweaks we do these days. For another,
> > > it means that the future libsensors would be more simple as well
> > > (symbols in sensors.conf would point to the similarly-named sysfs
> > > name).
> > 
> > Sorry about this, I wasn't really looking at the libsensors code at
> > all, to think about if it would be easier or not to do this.
> > 
> > If it really makes the userspace code a lot simpler, I can be
> > persuaded to convert all of the names (persuaded with patches that
> > is...)
> 
> OK, I'll be working on this.

Ok, how about writing up a summary of the proposal, listing the name
changes you want to make, and why, and post it to lkml so that everyone
has some advance notice of what will happen.  They can then discuss
anything that we might not have caught.

thanks,

greg k-h

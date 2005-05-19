From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040210075659.GF20139@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 06, 2004 at 11:54:18AM +0100, Jean Delvare wrote:
> Greg KH wrote:
> 
> > That would be me.  See the archives for what I propsed, and why I
> > did it.  Of course I can't remember what I said back then, and no
> > one seemed to disagree...
> 
> I don't think I was reading you back then. Shame on me.
> 
> Philip Pokorny wrote:
> 
> > I believe that Jean is proposing switching from:
> > 
> >   temp_max1
> >   temp_min1
> >   temp1
> > 
> > to
> > 
> >    temp1_max
> >    temp1_min
> >    temp1
> > 
> > So there still won't be multiple values in one "file", but the
> > filenames will sort naturally into groupings similar to the way
> > they were before.
> 
> That's the idea (except that it's temp_input1 -> temp1_input, not
> temp1).
> 
> At the time it was decided to switch to a one-file-per-value logic (and
> I agree it was a good idea), it would have been clever to use the
> library's symbol names as the files names. For one thing, it would
> simplify the libsensors tweaks we do these days. For another, it means
> that the future libsensors would be more simple as well (symbols in
> sensors.conf would point to the similarly-named sysfs name).

Sorry about this, I wasn't really looking at the libsensors code at all,
to think about if it would be easier or not to do this.

If it really makes the userspace code a lot simpler, I can be persuaded
to convert all of the names (persuaded with patches that is...)

It will have to be a 2.6.4 thing, as 2.6.3-rc2 is now out.  But it would
be wise to have these patches ready to go right after 2.6.3 comes out.

> Left apart the fact that temp1_min (for example) is how symbols were
> named from the beginning, please also consider the fact that, as
> underlined by Philip, the files will then group in a much more natural
> way (in my opinion at least).
> 
> I also think that we will need to extend the scheme if we want the
> sysfs
> interface to be truly chip-independant. For example, temp1_hyst is
> ambiguous, since you don't know which limit the hysteresis value applies
> to (more likely temp1_max, but for example in lm83 it applies to
> temp1_crit). So it would be better named temp1_max_hyst (resp.
> temp1_crit_hyst). Likewise, alarms are still chip-dependant and we
> could consider having files like temp1_max_alarm instead, much like
> Reinhard Nissl proposes in the new fscher chip driver.

If we know this kind of information, that makes sense.  I didn't see
anything like this in the original proc file description.

> To make it short, I'm worried by the fact that the new sysfs interface
> promises so many possibilities and we don't use them to their full
> potential. This is what motivates my call for an interface change.

Fair enough.  We can still change, we keep telling users to upgrade
lmsensors for every other kernel update, why not one more?  :)

thanks,

greg k-h

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <1076405805.4028a62d520b1@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > At the time it was decided to switch to a one-file-per-value logic
> > (and I agree it was a good idea), it would have been clever to use
> > the library's symbol names as the files names. For one thing, it
> > would simplify the libsensors tweaks we do these days. For another,
> > it means that the future libsensors would be more simple as well
> > (symbols in sensors.conf would point to the similarly-named sysfs
> > name).
> 
> Sorry about this, I wasn't really looking at the libsensors code at
> all, to think about if it would be easier or not to do this.
> 
> If it really makes the userspace code a lot simpler, I can be
> persuaded to convert all of the names (persuaded with patches that
> is...)

OK, I'll be working on this.

> It will have to be a 2.6.4 thing, as 2.6.3-rc2 is now out.

Of course. The 2.6.3 kernel had such a short cycle that it left
everyone
puzzled, methinks.

> But it would be wise to have these patches ready to go right after
> 2.6.3 comes out.

OK, I'll try to be ready then.

> > I also think that we will need to extend the scheme if we want
> > the sysfs interface to be truly chip-independant. For example,
> > temp1_hyst is ambiguous, since you don't know which limit the
> > hysteresis value applies to (more likely temp1_max, but for
> > example in lm83 it applies to temp1_crit). So it would be better
> > named temp1_max_hyst (resp. temp1_crit_hyst). Likewise, alarms
> > are still chip-dependant and we could consider having files like
> > temp1_max_alarm instead, much like Reinhard Nissl proposes in
> > the new fscher chip driver.
> 
> If we know this kind of information, that makes sense.  I didn't see
> anything like this in the original proc file description.

The procfs files were not meant to be chip-independant at all. There
were simple rules about file names and items orders within the files,
but that was only meant as a help for developers. So there were no
benefit to split alarms over correctly named files. Now this is
completely different.

I think we'll have to keep the "alarms" files for a while anyway,
because this is the only easy way that the existing libsensors will
handle them. I don't think there is a problem with providing the same
information twice through sysfs, if it helps the transition between old
and new style.

> > To make it short, I'm worried by the fact that the new sysfs
> > interface promises so many possibilities and we don't use them to
> > their full potential. This is what motivates my call for an
> > interface change.
> 
> Fair enough.  We can still change, we keep telling users to upgrade
> lmsensors for every other kernel update, why not one more?  :)

This is what I thought too. Of course, gkrellm people will blame us for
that, but I guess they'll have to admit it is better that way (in the
long term at least), and after all we already told them they should use
libsensors instead of accessing the files directly.

The change will be much work indeed, I know that, but I think it is
worth it. This means making changes to all the drivers in 2.6, and
rework the compatibility layer in the library. I'll also have to update
the sysfs-interface document. Sounds feasable anyway, or I wouldn't
have proposed it.

I propose to divide the changes in three distinct steps:

1* Change the base scheme (temp_min1 -> temp1_min). This is the more
important change.

2* Change the hysteresis names (temp1_hyst -> temp1_max_hyst). Only some
drivers are impacted. Changes required to the library as well.

3* Add the splitted alarm files. This doesn't break the interface, but
on the other hand needs that we think about it a bit more so that out
choices are extendable and correct for all known drivers.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Jun 2006 19:33:10 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <20060626213310.fdaa81e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,	

> > I am happy with the code now, but there is a problem with the sysfs file
> > names, see below.
> 
> Ok. I'm attaching fixed versions of both.
> 
> > And manual fan speed control too.
> 
> Ok I will mention, although I considered this a special case
> of automatic regulation
> 
> > We should at least have read-only files to let the user know the
> > mapping.
> 
> The mapping is trivial and programmable for fan4 only.
> I fixed the docs.
> 
> > I'm just realizing that these names are quite wrong. For example
> > temp1_target may not be related to temp1 but to a different temperature
> > sensor depending on the temp/fan mapping. The "1" here really means
> > pwm1, not temp1. So these files should be named pwm[1-4]_target_temp
> > and pwm[1-4]_tolerance_temp, respectively.
> 
> Yes correct. Fixed.

Thanks.

> If we consider this as standard for some chips. We would need some mapping
> standard too (Yuan did some file for w83793)

The temp <-> pwm mapping standard already exists.

> > But the driver uncondionally creates both files? This needs to be
> > investigated, and fixed (either the driver or the documentation.)
> 
> I fixed the note. The files are used in SF3 iirc, so we might have them.

I'm still not exactly happy. Documenting that we implemented things in
a possibly non-working way is better than not documenting it, agreed,
but even better would be to have things working in the first place.

Also on the to do list is the export of the fan <-> temperature
mapping, at least read only, as I asked before already. For now pwm4 is
useless in Temperature Cruise mode, as you don't know what temperature
channel it is working with.

Anyway, I will apply these patches now, as we have gone trough many
review cycles already. I made some fixes to the documentation patch to
fix typos and reword one sentence. Any future change to the w83627ehf
driver or its documentation should be incremental on top of these
patches.

Thanks,
-- 
Jean Delvare


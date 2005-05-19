From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [PATCH 2.6] Refactor swap_bytes in i2c chip drivers
Message-Id: <20040403130424.1d1e006d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329212303.2b47b12d.khali@linux-fr.org>
In-Reply-To: <20040329212303.2b47b12d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > Ick, no, we should be using the proper kernel call for this,
> > > swab16(), right?  Care to redo this patch to just fix the drivers
> > > and get rid of our duplicating of this function.
> > 
> > Oh, I didn't know such a function existed, sorry.
> > 
> > Here's a new patch, hope you like it. Tested to work on my as99127f,
> > btw(w83781d driver).
> 
> Looks good, applied, thanks.

Hm, it doesn't show in linux-2.6.5-rc3-mm4, although all others patches
you accepted the same day do.

I was planning to submit my next patch against this tree, but then it's
likely to cause trouble. Can you please verify what happened to the
swap_bytes patch?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

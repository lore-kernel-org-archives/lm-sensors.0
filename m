From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Jan 2011 08:49:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Rewritten without using
Message-Id: <20110117094926.7a4e6232@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
In-Reply-To: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Davide,

On Mon, 17 Jan 2011 09:31:03 +0100, Davide Rizzo wrote:
> 2010/11/18 Guenter Roeck <guenter.roeck@ericsson.com>
> 
> > Hi Davide,
> >
> >
> > Moving include statements around is just a whitespace change and should be
> > avoided.
> > Also, you added a blank line at the end of the file which causes a git
> > whitespace error
> > when applying the patch.
> >
> > No need to retransmit. I fixed both and applied the patch with a couple of
> > additional
> > formatting changes to make the file checkpatch clean.
> >
> > Thanks,
> > Guenter
>
> Any news about this ? I cannot find it in 2.6.37, did we miss the update
> window or is it locked somewhere ?

Your patch is in Linus' tree and will be part of kernel 2.6.38:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h1deb4b820cfacf22492abd7b17e891dafc51ae

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

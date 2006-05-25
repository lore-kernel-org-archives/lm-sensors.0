From: akpm@osdl.org (Andrew Morton)
Date: Thu, 25 May 2006 18:06:27 +0000
Subject: [lm-sensors] [PATCH] scx200_acb: fix section mismatch warning
Message-Id: <20060525110627.3461937f.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
	<20060525192657.081c8c11.khali@linux-fr.org>
In-Reply-To: <20060525192657.081c8c11.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: rdunlap@xenotime.net, izsmail@pardus.org.tr, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, greg@kroah.com

Jean Delvare <khali at linux-fr.org> wrote:
>
> > -static int scx200_add_cs553x(void)
>  > +static __init int scx200_add_cs553x(void)
>  >  {
>  >  	u32	low, hi;
>  >  	u32	smb_base;
>  > 
> 
>  Correct, I sent exactly the same patch to the the lm-sensors list and
>  Greg KH yesterday:
>  http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016213.html
> 
>  So this one is
>  Signed-off-by: Jean Delvare <khali at linux-fr.org>
> 
>  Note that the section mismatch is harmless here (we have a non-__init
>  function sandwiched between two __init functions) but nevertheless this
>  kind of warning is never welcome in a final kernel release so let's get
>  the fix merged now.
> 
>  Andrew, can you please push this to Linus?

yup, I'll send that later on today.  My current 2.6.17 queue is:

s390-fix-typo-in-stop_hz_timer.patch
add-cmspar-to-termbitsh-for-powerpc-and-alpha.patch
x86-wire-up-vmsplice-syscall.patch
ads7846-conversion-accuracy.patch
affs-possible-null-pointer-dereference-in-affs_rename.patch
powermac-force-only-suspend-to-disk-to-be-valid.patch
s3c24xx-fix-spi-driver-with-config_pm.patch
scx200_acb-fix-section-mismatch-warning.patch



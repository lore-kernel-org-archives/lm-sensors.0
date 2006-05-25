From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 May 2006 17:26:57 +0000
Subject: [lm-sensors] [PATCH] scx200_acb: fix section mismatch warning
Message-Id: <20060525192657.081c8c11.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
In-Reply-To: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>
Cc: Ismail Donme <izsmail@pardus.org.tr>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Greg KH <greg@kroah.com>

Hi Randy, all,

> From: Randy Dunlap <rdunlap at xenotime.net>
> 
> Fix section mismatch warning reported by ?smail D?nmez:
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .init.text: from .text after 'scx200_add_cs553x' (at offset 0x528)
> 
> Signed-off-by: Randy Dunlap <rdunlap at xenotime.net>
> ---
>  drivers/i2c/busses/scx200_acb.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2617-rc5.orig/drivers/i2c/busses/scx200_acb.c
> +++ linux-2617-rc5/drivers/i2c/busses/scx200_acb.c
> @@ -491,7 +491,7 @@ static struct pci_device_id divil_pci[] 
>  
>  #define MSR_LBAR_SMB		0x5140000B
>  
> -static int scx200_add_cs553x(void)
> +static __init int scx200_add_cs553x(void)
>  {
>  	u32	low, hi;
>  	u32	smb_base;
> 

Correct, I sent exactly the same patch to the the lm-sensors list and
Greg KH yesterday:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016213.html

So this one is
Signed-off-by: Jean Delvare <khali at linux-fr.org>

Note that the section mismatch is harmless here (we have a non-__init
function sandwiched between two __init functions) but nevertheless this
kind of warning is never welcome in a final kernel release so let's get
the fix merged now.

Andrew, can you please push this to Linus?

Thanks,
-- 
Jean Delvare


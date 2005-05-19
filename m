From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: PATCH: LM87 read retry tuning
Message-Id: <20041016113223.36593353.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4170478A.6060407@earthlink.net>
In-Reply-To: <4170478A.6060407@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This is a tiny patch to tune the lm87 read retry failure loop that was
> recently added.  On my board, if I got one retry failure, I always got
> 3, so I increased the amount of delay before a retry.
> 
> David Knierim
> 
> 
> 
> --- kernel/chips/lm87.c.orig  2004-10-10 08:03:48.000000000 -0400
> +++ kernel/chips/lm87.c 2004-10-15 14:47:20.000000000 -0400
> @@ -492,10 +492,11 @@
> 
>    printk(KERN_WARNING "lm87.o: Read byte data failed, "
>           "address 0x%02x\n", reg);
> -           mdelay(i);
> +           mdelay(i + 3);
>   }
> 
>   /* <TODO> what to return in case of error? */
> +     printk(KERN_ERR "lm87.o: All read byte retries failed!!\n");
>   return 0;
>  }

Looks like your e-mail client breaks patches, it won't apply. Please
either reconfigure it, change clients or provide the patch as an
attachement.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

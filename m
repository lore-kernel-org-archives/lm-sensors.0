From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: [BUG] i2c_check_addr is broken in 2.8.0
Message-Id: <20030724020108.GE13286@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030723204822.431c40ac.vsu@altlinux.ru>
In-Reply-To: <20030723204822.431c40ac.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergey:

Applied to CVS, thanks!

In case anyone is wondering (Greg KH) this fix is *not* needed
in 2.6 - I checked.

* Sergey Vlasov <vsu@altlinux.ru> [2003-07-23 20:48:22 +0400]:
> Hello!
> 
> In i2c-2.8.0 i2c_check_addr() is broken - it always returns 0,
> therefore the duplicate address check is not done. i2cdetect does not
> ever report 'UU', and I have even seen a case when two chips are
> registered at the same address.
> 
> This one-line patch fixes the problem:
> 
> 
> --- i2c-2.8.0/kernel/i2c-core.c.check-addr-fix	2003-06-28 22:19:12 +0400
> +++ i2c-2.8.0/kernel/i2c-core.c	2003-07-22 20:49:39 +0400
> @@ -315,7 +315,7 @@
>  	rval = __i2c_check_addr(adapter, addr);
>  	up(&adapter->list);
>  
> -	return 0;
> +	return rval;
>  }
>  
>  int i2c_attach_client(struct i2c_client *client)
> 

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

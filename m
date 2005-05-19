From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040104072432.627F62C270@lists.samba.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In message <1072821970727@kroah.com> you write:
> +/* If fix_hstcfg is set to anything different from 0, we reset one of the
> +   registers to be a valid value. */
> +static int fix_hstcfg = 0;
> +MODULE_PARM(fix_hstcfg, "i");
> +MODULE_PARM_DESC(fix_hstcfg,
> +		"Fix config register. Needed on some boards (Force CPCI735).");
> +

BTW, it'd be nice if someone converted these to module_param, too...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

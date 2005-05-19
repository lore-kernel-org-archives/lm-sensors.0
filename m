From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040105212125.4e26a7e4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > BTW, it'd be nice if someone converted these to module_param, too...
> (...)
> -MODULE_PARM(force, "i");
> +module_param (force, int, 0);
>  MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");

Two questions for my personal knowledge:
1* What does the final 0 stand for?
2* Aren't we supposed to convert MODULE_PARM_DESC too?

There are loads of MODULE_PARM() used in the whole i2c subsystem. If we
are supposed to convert them all, let me know, tell me how to do this
cleanly (i.e. what to with that third parameter of module_param, and
what to do with MODULE_PARM_DESC) and I'll submit a patch.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

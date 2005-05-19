From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: fix compares of jiffies
Message-Id: <3DE5180E.6B27EFC5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241432520.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241432520.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

good idea,
let's fix this after the 2.7.0 release

Ky?sti M?lkki wrote:
> 
> I came across this in old posts, applies to several i2c drivers.
> Trivial if you know when time_before() has appeared..
> 
> --- linux-2.4.20-pre6/drivers/i2c/i2c-adap-ite.c        Sat Aug  3 02:39:44 2002
> +++ linux-2.4.20-pre6-jfix/drivers/i2c/i2c-adap-ite.c   Wed Sep 11 13:01:41 2002
> @@ -82,7 +82,7 @@
>          unsigned long j = jiffies + 10;
> 
>         DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
> -       DEB3({while (jiffies < j) schedule();})
> +       DEB3({while (time_before(jiffies, j)) schedule();})
>         outw(val,ctl);
>  }
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi

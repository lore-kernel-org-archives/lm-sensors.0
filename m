From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Feb 2008 07:44:04 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port
Message-Id: <20080222084404.549741f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 22 Feb 2008 18:21:23 +1100, Benjamin Herrenschmidt wrote:
> 
> On Fri, 2008-02-22 at 08:19 +0100, Jean Delvare wrote:
> > 
> > I was referring to the kernel patch Christian submitted earlier this
> > week which prevents oopses or machine checks when older versions of
> > sensors-detect access /dev/port in unexpected ways. My update to
> > sensors-detect was meant as a complement of his patch, not a
> > replacement.
> 
> But his patch can't recognize a potentially valid use of /proc/port
> right ?

I don't know much about PPC so I can't comment on the implementation.
All I'm saying is that, if it is possible at all, I believe that
preventing invalid accesses from oopsing the machine is a good idea.

> Christian, can you re-send me that patch ?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

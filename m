From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 13:39:10 +0000
Subject: Re: [lm-sensors] [2.6 patch] make coretemp_device_remove() static
Message-Id: <20070708133910.GB3591@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070705232306.GY3492@stusta.de> <20070707212228.1e776ff8@hyperion.delvare>
In-Reply-To: <20070707212228.1e776ff8@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, r.marek@assembler.cz, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Jean, Adrian:

* Jean Delvare <khali@linux-fr.org> [2007-07-07 21:22:28 +0200]:
> Hi Adrian,
> 
> On Fri, 6 Jul 2007 01:23:06 +0200, Adrian Bunk wrote:
> > coretemp_device_remove() can become static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Obviously correct.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> > ---
> > --- linux-2.6.22-rc6-mm1/drivers/hwmon/coretemp.c.old	2007-07-04 20:46:05.000000000 +0200
> > +++ linux-2.6.22-rc6-mm1/drivers/hwmon/coretemp.c	2007-07-04 20:46:20.000000000 +0200
> > @@ -318,7 +318,7 @@
> >  }
> >  
> >  #ifdef CONFIG_HOTPLUG_CPU
> > -void coretemp_device_remove(unsigned int cpu)
> > +static void coretemp_device_remove(unsigned int cpu)
> >  {
> >  	struct pdev_entry *p, *n;
> >  	mutex_lock(&pdev_list_mutex);

Applied to my testing tree; thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

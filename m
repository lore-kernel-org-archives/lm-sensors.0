From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Dec 2013 18:53:23 +0000
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Message-Id: <20131217195323.581143a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131217063226.GD25105@phys.ethz.ch>
	<20131217180131.GB2840@roeck-us.net>
	<20131217181053.GE7071@katana>
In-Reply-To: <20131217181053.GE7071@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Tue, 17 Dec 2013 19:10:53 +0100, Wolfram Sang wrote:
> 
> > > I'm currently beta testing a pretty cool embedded board for router
> > > applications etc. (http://www.pcengines.ch/apu.htm) that sports a Hudson-1 FCH
> > > which is pretty similar to the Hudson-2 your module supports but sufficiently
> > > different so that i2c-piix4 doesn't work.
> > > I found a patched i2c-piix4 source that adds support for the Hudson-1 and it
> > > works beautifully: http://www.men.de/products/13SC24-90.html#t=overview
> > > Now I'm wondering if you would be willing to get this patch into lm-sensors
> > > and also the kernel.
> > > If there's anything I can do to help, please let me know.
> 
> Can't say anything about the patch since it requires registration to get
> it :(
> 
> What you/someone can do:
> 
> * get the patch
> * port it to a recent kernel and verify it still works
> * read Documentation/SubmittingPatches
> * send the patch

... with me in Cc, I'll review it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 13:41:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Remove many EXPERIMENTAL flags
Message-Id: <20101014154112.2cc41dcd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014103239.1096f962@endymion.delvare>
In-Reply-To: <20101014103239.1096f962@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Oct 2010 06:27:50 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Thu, Oct 14, 2010 at 04:32:39AM -0400, Jean Delvare wrote:
> > Remove the dependency on EXPERIMENTAL for all drivers which are in
> > the kernel tree for a long time, are known to work properly and for
> > which we have documentation.
> > 
> [ ... ]
> >  
> >  config SENSORS_F71882FG
> >  	tristate "Fintek F71858FG, F71862FG, F71882FG, F71889FG and F8000"
> > -	depends on EXPERIMENTAL
> > +	depends
> 
> Empty depends line can be removed.

Yup, I forgot to refresh the patch before sending it :/

> Otherwise 
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

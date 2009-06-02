From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 02 Jun 2009 09:14:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401) Fix off-by-one error
Message-Id: <20090602091415.GB4546@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602081821.GA4546@ubuntu>
In-Reply-To: <20090602081821.GA4546@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 02, 2009 at 10:26:28AM +0200, Hans de Goede wrote:
> Good catch!

Unfortunately this bug was introduced by myself :(
I didn't read your code from fschmd carefully enough.

Andre

> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> On 06/02/2009 10:18 AM, Andre Prendel wrote:
> > This patch fixes an off-by-one error in chip detection output.
> >
> > I2C kind starts with 1, so this cannot be used directly as the array index.
> >
> > Signed-off-by: Andre Prendel<andre.prendel@gmx.de>
> > ---
> > --- linux-2.6.orig/drivers/hwmon/tmp401.c	2009-05-29 23:09:58.000000000 +0200
> > +++ linux-2.6/drivers/hwmon/tmp401.c	2009-05-29 23:10:29.000000000 +0200
> > @@ -576,7 +576,7 @@
> >   		goto exit_remove;
> >   	}
> >   	dev_info(&client->dev, "Detected TI %s chip\n",
> > -		 names[data->kind]);
> > +		 names[data->kind - 1]);
> >
> >   	return 0;
> >
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

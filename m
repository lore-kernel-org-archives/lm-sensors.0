From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 11 Jun 2014 20:42:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm85) Drop generic detection
Message-Id: <20140611204227.GA20336@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140611183556.58890a5c@endymion.delvare>
In-Reply-To: <20140611183556.58890a5c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 11, 2014 at 09:50:49PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 11 Jun 2014 09:52:04 -0700, Guenter Roeck wrote:
> > On Wed, Jun 11, 2014 at 06:35:56PM +0200, Jean Delvare wrote:
> > > Generic detection leads to too many false positives, so drop it. FWIW
> > > sensors-detect does not have such generic detection. If the user wants
> > > to force the driver to bind to a not yet supported chip, he/she can
> > > still do so using sysfs attribute new_device.
> > > 
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > 
> > Good idea. That was way too generic.
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Do you want to take it, or should I ? I have another fix pending, so it would
> > not make a difference for me.
> 
> Please take it, I don't have anything else to send this time.
> 
Ok, will do.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

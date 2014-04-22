From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 22 Apr 2014 15:08:55 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm77) Do not preserve hysteresis when updating critical temp lim
Message-Id: <20140422150855.GA20271@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140422112641.GA15567@roeck-us.net>
In-Reply-To: <20140422112641.GA15567@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 22, 2014 at 04:32:58PM +0200, Jean Delvare wrote:
> On Tue, 22 Apr 2014 04:26:41 -0700, Guenter Roeck wrote:
> > Updating the hysteresis value when updating the critical temperature limit
> > was following the rule of 'least surprise'. However, it had the undesirable
> > side effect of changing the hysteresis for all other attributes, which
> > defeats the purpose of least surprise. In addition, it could result in
> > invalid hysteresis values if the resulting hysteresis was too large. In such
> > cases the resulting hysteresis ended up changed anyway, which again defeats
> > the purpose. So drop that code and document the new behavior.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v3: Replace documentation with text suggested by Jean
> >     Drop obsolete comment
> > v2: Move this patch ahead of subsequent patches to simplify those
> > 
> >  Documentation/hwmon/lm77 |   20 ++++++++++++++++++--
> >  drivers/hwmon/lm77.c     |    6 ------
> >  2 files changed, 18 insertions(+), 8 deletions(-)
> > (...)
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Thanks a lot for the reviews and your time!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

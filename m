From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 May 2012 13:47:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: INA219 and INA226 support
Message-Id: <20120522134757.GA30060@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <28DAD847AEFDD344B2D3802E7670BEE116AD804E@DNCE04.ent.ti.com>
In-Reply-To: <28DAD847AEFDD344B2D3802E7670BEE116AD804E@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 22, 2012 at 03:13:35AM -0400, Felten, Lothar wrote:
> Hi Guenter,
> 
> > Hi Lothar,
> >
> > > Hello,
> > >
> > > This patch brings support for the Texas Instruments INA219 and INA226
> > power monitors.
> > >
> > I have a couple of observations.
> >
> > [ ... ]
> > > +
> > > +/* settings - depend on use case */
> > > +#define INA219_CONFIG_DEFAULT          0x219F  /* PGA=1 */
> > > +#define INA226_CONFIG_DEFAULT          0x4527  /* averages */
> > > +
> >
> > With this configuration (PGA=1), the dynamic range for the shunt
> > resistor voltage is 40 mV. Since we report the value in mV, it does not
> > provide much value to do that. It might be better to use PGA=8 instead,
> > for a dynamic range of 320 mV.
> >
> > Did you have a special reason for selecting PGA=1 ? Otherwise, I think
> > we should change it to PGA=8.
> 
> No there was no special reason, the default setting after reset is PGA=8, this
> Is probably the best selection. So that should be:
> #define INA219_CONFIG_DEFAULT          0x399F  /* default values */
> 
> INA2XX_SHUNT_VOLTAGE will then go from -320mV to +320mV, that should be ok.
> 
Ok, I updated that in the pending patch.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

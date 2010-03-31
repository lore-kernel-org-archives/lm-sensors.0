From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 11:54:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) use programmed update rate
Message-Id: <20100331135436.7cd23ac1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090902183818.GG2328@ovro.caltech.edu>
In-Reply-To: <20090902183818.GG2328@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Tue, 30 Mar 2010 15:15:20 -0700, Ira W. Snyder wrote:
> On Wed, Sep 02, 2009 at 11:38:18AM -0700, Ira W. Snyder wrote:
> > The lm90 driver programs the sensor chip to update its readings at 2 Hz
> > (500 ms between readings). However, the driver only does reads from the
> > chip at intervals of 2 * HZ (2000 ms between readings). Change the driver
> > update rate to the programmed update rate.
> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > ---
> > 
> > I think this was probably just a simple mistake made by the original
> > author of the driver, with the intention being that the driver update
> > the cached values every 500 ms. The change is confirmed against the
> > adm1032 datasheet. The chip is updating every 500 ms.
> > 
> 
> Any comments on this patch? It has almost been lost off my radar.
> 
> Jean, I think this should be pretty uncontroversial. Can you pick it up?

There is a small problem with your patch. Yes I think I made a mistake
originally, probably just copied the cache lifetime from another driver
and did not realize it didn't match the refresh rate. However, it is
also important for at least some I2C/SMBus devices to not be
interrupted (by serial bus access) when they sample the data, otherwise
the sampling is lost. For this reason, we try to make the cache
lifetime always slightly longer than the polling period.

So, having a cache lifetime of HZ / 2 is too tight IMHO. I would be
happy with HZ / 2 + HZ / 10. Would that work for you?

> >  drivers/hwmon/lm90.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > index 1aff757..f3324c5 100644
> > --- a/drivers/hwmon/lm90.c
> > +++ b/drivers/hwmon/lm90.c
> > @@ -960,7 +960,7 @@ static struct lm90_data *lm90_update_device(struct device *dev)
> >  
> >  	mutex_lock(&data->update_lock);
> >  
> > -	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
> > +	if (time_after(jiffies, data->last_updated + HZ / 2) || !data->valid) {
> >  		u8 h, l;
> >  
> >  		dev_dbg(&client->dev, "Updating lm90 data.\n");

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

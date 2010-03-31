From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 15:40:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) use programmed update rate
Message-Id: <20100331174021.58f75f1d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090902183818.GG2328@ovro.caltech.edu>
In-Reply-To: <20090902183818.GG2328@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Wed, 31 Mar 2010 08:30:25 -0700, Ira W. Snyder wrote:
> On Wed, Mar 31, 2010 at 01:54:36PM +0200, Jean Delvare wrote:
> > There is a small problem with your patch. Yes I think I made a mistake
> > originally, probably just copied the cache lifetime from another driver
> > and did not realize it didn't match the refresh rate. However, it is
> > also important for at least some I2C/SMBus devices to not be
> > interrupted (by serial bus access) when they sample the data, otherwise
> > the sampling is lost. For this reason, we try to make the cache
> > lifetime always slightly longer than the polling period.
> > 
> > So, having a cache lifetime of HZ / 2 is too tight IMHO. I would be
> > happy with HZ / 2 + HZ / 10. Would that work for you?
> > 
> 
> That should be fine. I never knew that some sensors have a problem with
> being read while sampling.
> 
> For what it is worth, I haven't seen a problem polling the adm1032
> sensor at 500ms intervals. In my application, I take readings from all
> chips on my board every 500ms.

I know that the ADM1032 chip isn't affected, I have one. But the driver
supports many other chips, which I do not have, so we can't assume they
all behave exactly the same.

> Would you like me to submit a new patch, or do you just want to edit the
> patch before you apply it? I'm happy with either one.

I've modified the patch myself, consider it applied. And sorry for the
delay...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

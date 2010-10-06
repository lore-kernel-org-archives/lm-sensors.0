From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Oct 2010 16:13:19 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Introduce chip
Message-Id: <20101006181319.09136d5d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Oct 2010 08:28:37 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Wed, Oct 06, 2010 at 11:05:53AM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Tue, 5 Oct 2010 08:38:26 -0700, Guenter Roeck wrote:
> > > Instead of using switch/case and if statements in probe, define chip specific
> > > functionality in a parameter structure array.
> > > 
> > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > >  drivers/hwmon/lm90.c |   92 ++++++++++++++++++++++++++++++++-----------------
> > >  1 files changed, 60 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > > index 302d9eb..9df08e1 100644
> > > --- a/drivers/hwmon/lm90.c
> > > +++ b/drivers/hwmon/lm90.c
> > > @@ -190,6 +190,63 @@ static const struct i2c_device_id lm90_id[] = {
> > >  MODULE_DEVICE_TABLE(i2c, lm90_id);
> > >  
> > >  /*
> > > + * chip type specific parameters
> > > + */
> > > +struct lm90_params {
> > > +	u32 flags;		/* Capabilities */
> > 
> > Any reason why you don't use u16? there aren't that many flags yet, and
> > u16 divides the size of lm90_params[] below by 2.
> > 
> Access to 32 bit variables is a bit faster on many CPUs, due to the bit masking
> required otherwise.

... but alert_alarms is a u16, so apparently speed wasn't considered
(quite rightly so IMHO, as this is initialization data only read once.)

> Also, the flags field in lm90_data was int and I changed
> it to u32 (seemed to be cleaner for a bitfield). Seemed to make sense to use
> the same type for both.

This is a much better reason :)

> Not that it matters much here, if at all, since this is a bit mask anyway.
> I am fine either way.

Indeed...

> (...)
> Do you want me to change the flags to u16, or keep as is ?

I'll keep it as is. I just noticed that the following patch makes my
struct size argument moot anyway.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

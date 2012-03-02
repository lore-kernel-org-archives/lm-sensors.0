From: Nikolaus Schulz <mail@microschulz.de>
Date: Fri, 02 Mar 2012 18:37:26 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (f75375s) Fix writes to the pwm* attribute for the F75387
Message-Id: <20120302183726.GA7498@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330463755-5763-2-git-send-email-mail@microschulz.de>
In-Reply-To: <1330463755-5763-2-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 28, 2012 at 01:26:22PM -0800, Guenter Roeck wrote:
> On Tue, 2012-02-28 at 16:15 -0500, Nikolaus Schulz wrote:
> > For the F75387, the register holding the current PWM duty cycle value is
> > r/o; changing it requires writing to the fan expect register instead.
> > 
> > Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
> > ---
> >  drivers/hwmon/f75375s.c |   17 ++++++++++++-----
> >  1 files changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> > index 5dae122..1c26652 100644
> > --- a/drivers/hwmon/f75375s.c
> > +++ b/drivers/hwmon/f75375s.c
> > @@ -178,6 +178,15 @@ static inline void f75375_write16(struct i2c_client *client, u8 reg,
> >  	i2c_smbus_write_byte_data(client, reg + 1, (value & 0xFF));
> >  }
> >  
> > +static void f75375_write_pwm(struct i2c_client *client, int nr, u8 pwm)
> > +{
> > +	struct f75375_data *data = i2c_get_clientdata(client);
> 
> Since you extract data anyway, you don't need to pass pwm but can
> instead take if from data->pwm[nr].
> 
> Other than that, looks good.
> 
> No need to resubmit; I can make that change myself if you agree.

That's ok, please proceed.

Thanks,
Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

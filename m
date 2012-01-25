From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jan 2012 13:04:59 +0000
Subject: Re: [lm-sensors] [PATCH 04/79] hwmon: (lm87) Fix checkpatch issues
Message-Id: <20120125140459.4e0fb547@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-5-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-5-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Jan 2012 02:10:35 -0800, Guenter Roeck wrote:
> Hi Jean,
> 
> On Wed, Jan 25, 2012 at 04:33:36AM -0500, Jean Delvare wrote:
> > On Mon, 23 Jan 2012 18:48:43 -0800, Guenter Roeck wrote:
> > > From: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Fixed:
> > > ERROR: do not use assignment in if condition
> > > ERROR: space required after that close brace '}'
> > > ERROR: space required after that ',' (ctx:VxV)
> > > ERROR: spaces required around that '<' (ctx:VxV)
> > > ERROR: trailing statements should be on next line
> > > WARNING: line over 80 characters
> > > WARNING: simple_strtol is obsolete, use kstrtol instead
> > > WARNING: simple_strtoul is obsolete, use kstrtoul instead
> > > 
> > > Modify multi-line comments to follow Documentation/CodingStyle.
> > > 
> > > Not fixed everywhere (code complexity):
> > > ERROR: do not use assignment in if condition
> > > 
> > > Cc: Jean Delvare <khali@linux-fr.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/hwmon/lm87.c |  247 ++++++++++++++++++++++++++++++++++----------------
> > >  1 files changed, 170 insertions(+), 77 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
> > > index 126d0cc..8e66f99 100644
> > > --- a/drivers/hwmon/lm87.c
> > > +++ b/drivers/hwmon/lm87.c
> > > (...)
> > > -static void set_in_min(struct device *dev, const char *buf, int nr)
> > > +static ssize_t set_in_min(struct device *dev, const char *buf, int nr,
> > > +			  size_t count)
> > >  {
> > >  	struct i2c_client *client = to_i2c_client(dev);
> > >  	struct lm87_data *data = i2c_get_clientdata(client);
> > > -	long val = simple_strtol(buf, NULL, 10);
> > > +	long val;
> > > +	int err;
> > > +
> > > +	err = kstrtol(buf, 10, &val);
> > > +	if (err)
> > > +		return err;
> > >  
> > >  	mutex_lock(&data->update_lock);
> > >  	data->in_min[nr] = IN_TO_REG(val, data->in_scale[nr]);
> > > -	lm87_write_value(client, nr<6 ? LM87_REG_IN_MIN(nr) :
> > > -			 LM87_REG_AIN_MIN(nr-6), data->in_min[nr]);
> > > +	lm87_write_value(client, nr < 6 ? LM87_REG_IN_MIN(nr) :
> > > +			 LM87_REG_AIN_MIN(nr - 6), data->in_min[nr]);
> > >  	mutex_unlock(&data->update_lock);
> > > +	return count;
> > >  }
> > 
> > Here you are going beyond checkpatch or style fixes. I'm not saying
> > that this extra change is bad, but it certainly doesn't belong to this
> > patch. Same for the similar change to set_in_max(), set_temp_low(),
> > set_temp_high() and set_fan_min(). As I see you're sending this kind of
> > cleanup patch to Linus past rc1, you should really refrain from adding
> > any extra change.
> 
> Since kstrtol() requires and implies return value checks, the only other
> option would have been something like
> 
> 	err = kstrtol(buf, 10, &val);
> 	if (err)
> 		return;
> 
> which really seems inappropriate, or to not replace simple_strtol() at all.
> All this change does is to add error check to the macro and return the same.
> I don't see that as a problem.

You're totally right. I should have guessed you had a valid reason for
that change. Sorry for the noise.

> If you think it is a problem for -rc, I can hold it until 3.4, but I really
> don't see the point.

If such a patch was in my tree it would be for 3.4. But really you can
handle it the way you like, it's really between you and Linus in the
end.

> > As a side note, what this driver really needs is turning most
> > DEVICE_ATTR into SENSOR_DEVICE_ATTR to get rid of macro-generated stub
> > functions. This change is one small step in the right direction...
>
> I agree, but that _would_ be more invasive and possibly warrant holding it
> until 3.4. Kind of arguing with myself if I should do that. What do you think ? 

I was more or less planing on doing it myself. I wrote that crap in the
first place... I even have an old board with an LM87 chip on it, but I
don't want to spend time building a system with it for just a code
cleanup patch; an emulated LM87 will have to do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

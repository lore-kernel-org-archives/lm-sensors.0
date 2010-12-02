From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Dec 2010 08:13:15 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div (2nd try)
Message-Id: <20101202091315.5c9adcf6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101201005717.GE30973@penguintown.net>
In-Reply-To: <20101201005717.GE30973@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriele,

On Wed, 1 Dec 2010 18:02:31 -0800, Gabriele Gorla wrote:
> On Wed, Dec 01, 2010 at 02:59:06PM +0100, Jean Delvare wrote:
> 
> > Your patch is correct. However, in order to get the fix in stable
> > kernel series, I would prefer an even more minimalist fix, only
> > addressing the actual bug. The two minor optimizations (skipping the
> > register write if the value is the same and skipping the call to
> > fixup_fan_min if the value is different but resulted in the same
> > register encoding) would rather be left out at this time.
> > 
> > This would result in the following patch:
> > 
> > ---
> >  drivers/hwmon/adm1026.c |   16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > --- linux-2.6.37-rc4.orig/drivers/hwmon/adm1026.c	2010-12-01 13:48:13.000000000 +0100
> > +++ linux-2.6.37-rc4/drivers/hwmon/adm1026.c	2010-12-01 14:20:14.000000000 +0100
> > @@ -916,7 +916,7 @@ static ssize_t set_fan_div(struct device
> >  	int nr = sensor_attr->index;
> >  	struct i2c_client *client = to_i2c_client(dev);
> >  	struct adm1026_data *data = i2c_get_clientdata(client);
> > -	int val, orig_div, new_div, shift;
> > +	int val, orig_div, new_div;
> >  
> >  	val = simple_strtol(buf, NULL, 10);
> >  	new_div = DIV_TO_REG(val);
> > @@ -928,15 +928,17 @@ static ssize_t set_fan_div(struct device
> >  	data->fan_div[nr] = DIV_FROM_REG(new_div);
> >  
> >  	if (nr < 4) { /* 0 <= nr < 4 */
> > -		shift = 2 * nr;
> >  		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> > -			((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
> > -			(new_div << shift)));
> > +				    (DIV_TO_REG(data->fan_div[0]) << 0) |
> > +				    (DIV_TO_REG(data->fan_div[1]) << 2) |
> > +				    (DIV_TO_REG(data->fan_div[2]) << 4) |
> > +				    (DIV_TO_REG(data->fan_div[3]) << 6));
> >  	} else { /* 3 < nr < 8 */
> > -		shift = 2 * (nr - 4);
> >  		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> > -			((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift)))) |
> > -			(new_div << shift)));
> > +				    (DIV_TO_REG(data->fan_div[4]) << 0) |
> > +				    (DIV_TO_REG(data->fan_div[5]) << 2) |
> > +				    (DIV_TO_REG(data->fan_div[6]) << 4) |
> > +				    (DIV_TO_REG(data->fan_div[7]) << 6));
> >  	}
> >  
> >  	if (data->fan_div[nr] != orig_div) {
> > 
> > As you can see, it's more compact and immediately obviously correct. So
> > backporting it to kernels 2.6.36, 2.6.32, 2.6.27 and maybe even
> > 2.6.16 will be trivial. Is this OK with you? You retain patch
> > authorship, of course.
> 
> Sounds good to me. Do I need to submit it again, or you will take care 
> of the re-submission?

I've done it:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-adm1026-01-fix-setting-fan_div.patch
> 
> > Regarding the optimizations, I'm not even sure if we need them.
> 
> We could debate this issues for weeks but I am sure we all have better 
> things to do than trying to overoptimize a non critical code path. :-)

Correct.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

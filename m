From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 31 May 2009 19:33:47 +0000
Subject: Re: [lm-sensors] PATCH [4/4]: hwmon: f71882fg add support for the
Message-Id: <20090531213347.36f3655d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A1FA57E.4040503@redhat.com>
In-Reply-To: <4A1FA57E.4040503@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 31 May 2009 21:08:17 +0200, Hans de Goede wrote:
> 
> 
> On 05/30/2009 08:58 AM, Jean Delvare wrote:
> > Hi Hans,
> >
> > On Fri, 29 May 2009 11:06:06 +0200, Hans de Goede wrote:
> >> Add support for the hwmon part of the Fintek f71858fg superio IC to the
> >> f71882fg driver. Many thanks to Jelle de Jong for lending me a motherboard
> >> with this superio on it.
> >>
> >> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
> >
> > Review:
> >
> 
> Many thanks for the quick review !
> 
> >> (...)
> >>   static struct f71882fg_data *f71882fg_update_device(struct device *dev)
> >>   {
> >>   	struct f71882fg_data *data = dev_get_drvdata(dev);
> >>   	int nr, reg = 0, reg2;
> >>   	int nr_fans = (data->type = f71882fg) ? 4 : 3;
> >> -	int nr_ins = (data->type = f8000) ? 3 : 9;
> >> -	int temp_start = (data->type = f8000) ? 0 : 1;
> >> +	int nr_ins = (data->type = f71858fg || data->type = f8000) ? 3 : 9;
> >> +	int temp_start > >> +	    (data->type = f71858fg || data->type = f8000) ? 0 : 1;
> >
> > It might be a good idea to add these values to struct f71882fg_data
> > (maybe in a separate patch) so that you don't have to compute them
> > every time. Especially temp_start is used in several functions.
> >
> 
> I've done this for temp_start.
> 
> >> (...)
> >> @@ -1166,8 +1230,22 @@ static ssize_t show_temp(struct device *
> >>   {
> >>   	struct f71882fg_data *data = f71882fg_update_device(dev);
> >>   	int nr = to_sensor_dev_attr_2(devattr)->index;
> >> +	int sign, temp;
> >> +
> >> +	if (data->type = f71858fg) {
> >> +		if ((data->temp_config&  3) = 3)
> >
> > If I read the datasheet correctly, this should be:
> >
> > 		if ((data->temp_config&  1) = 1)
> >
> > Both modes 1 and 3 have the sign in the LSb while modes 0 and 2 have
> > the sign in the MSb.
> >
> >> +			sign = data->temp[nr]&  0x0001;
> >> +		else
> >> +			sign = data->temp[nr]&  0x8000;
> >> +
> >> +		temp = (data->temp[nr]>>  5)&  0x3ff;
> >
> > This is only correct for modes 0 and 2. For modes 1 and 3, there are 11
> > bits of data, not 10, so the mask should be 0x7ff.
> >
> 
> You are right on both accounts, both fixed.
> 
> <snip>
> 
> >> @@ -1773,6 +1873,12 @@ static int __devinit f71882fg_probe(stru
> >>
> >>   		/* Sanity check the pwm settings */
> >>   		switch (data->type) {
> >> +		case f71858fg:
> >> +			err = 0;
> >> +			for (i = 0; i<  nr_fans; i++)
> >> +				if (((data->pwm_enable>>  i * 2)&  3) = 3)
> >
> > Ditto for parentheses.
> >
> 
> Fixed for both occurences.
> 
> Updated version attached.

Looks good this time, applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

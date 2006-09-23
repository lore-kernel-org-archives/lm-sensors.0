From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 15:02:22 +0000
Subject: [lm-sensors] [patch 3/3] pc87360 - fix unchecked
Message-Id: <20060923170222.71cd9913.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E73765.80603@gmail.com>
In-Reply-To: <44E73765.80603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> > 3- rework sys-device-interface startup
> >     use sysfs_create_group() for 2 sensor-types which are chip-model invariant.
> >        ie all-or-nothing attribute groups
> >     other 2 groups vary too much due to configuration, etc,
> >        so we keep the loops of device_create_file(), but now check their returns.
> > 
> > Signed-off-by:   Jim Cromie  <jim.cromie at gmail.com>

I just noticed that you do not properly propagate the error value if a
device file creation actually fails:

> > diff -ruNp -X dontdiff -X exclude-diffs ab-2/drivers/hwmon/pc87360.c ab-3/drivers/hwmon/pc87360.c
> > --- ab-2/drivers/hwmon/pc87360.c	2006-08-18 17:40:35.000000000 -0600
> > +++ ab-3/drivers/hwmon/pc87360.c	2006-08-18 18:54:24.000000000 -0600

> > +	/* Register all-or-nothing sysfs groups */
> > +
> > +	if (data->innr && 
> > +	    sysfs_create_group(&client->dev.kobj,
> > +			       &pc8736x_vin_group))
> >  		goto ERROR3;

> >  	if (data->tempnr) {
> >  		for (i = 0; i < data->tempnr; i++) {
> > +			if (device_create_file(dev, &temp_input[i].dev_attr)
> > +			    || device_create_file(dev, &temp_min[i].dev_attr)
> > +			    || device_create_file(dev, &temp_max[i].dev_attr)
> > +			    || device_create_file(dev, &temp_crit[i].dev_attr)
> > +			    || device_create_file(dev, &temp_status[i].dev_attr))
> > +				goto ERROR3;

I've fixed that, modified patch is attached, I hope you like it.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-unchecked-return-status-fixes-pc87360-3.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060923/de6416cf/attachment-0001.pl 

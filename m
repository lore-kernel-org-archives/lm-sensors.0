From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Mar 2015 15:27:02 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/5] hwmon: (ibmpowernv) change create_hwmon_attr_name() prototype
Message-Id: <20150320152702.GB10749@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426787085-9004-5-git-send-email-clg@fr.ibm.com>
 <550BD50E.2040009@fr.ibm.com>
In-Reply-To: <550BD50E.2040009@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On Fri, Mar 20, 2015 at 09:06:38AM +0100, Cedric Le Goater wrote:
> [ ... ] 
> 
> 
> > @@ -265,10 +261,17 @@ static int create_device_attrs(struct pl
> > 
> >  		sdata[count].id = sensor_id;
> >  		sdata[count].type = type;
> > -		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
> > -					     sdata[count].name);
> > -		if (err)
> > +
> > +		attr_name = parse_opal_node_name(np->name, type, &opal_index);
> > +		if (IS_ERR(attr_name)) {
> > +			dev_err(&pdev->dev, "Sensor device node name '%s' is invalid\n",
> > +				np->name);
> > +			err = IS_ERR(attr_name);
>                               ^^^^^^
> 
> Arg. Bad copy/paste. This should be PTR_ERR() ... 
> 
> Do you want a full patchset resend or just a resend of this patch ? or a fix maybe.
> 
No need to resend; I fixed it up.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

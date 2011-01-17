From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 17 Jan 2011 22:39:35 +0000
Subject: Re: [lm-sensors] driver for emc1023
Message-Id: <1295303975.9786.255.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D34960C.8070303@gmail.com>
In-Reply-To: <4D34960C.8070303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-01-17 at 17:23 -0500, Anish Patel wrote:
> On 01/17/11 17:13, Guenter Roeck wrote:
> > On Mon, 2011-01-17 at 15:39 -0500, Guenter Roeck wrote:
> >> On Mon, 2011-01-17 at 14:18 -0500, Anish Patel wrote:
> >>> here is the driver for the emc1023 and the makefile patch.
> > Couple of additional comments.
> >
> > The chip reports fault conditions for the external sensors. Would be
> > great if you could add attribute files to report it (tempX_fault).
> >
> > Also, we'll need Documentation/hwmon/emc1023.
> >
> > Thanks,
> > Guenter
> >
> >
> >
> ok, i will try to add them.  is there some document that i can look at 
> that kinda tells me whats avaiable for functions?
> right now i just modified the heck out of the tmp401 driver.
> 
You can add something like

SENSOR_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0x01),
SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0x02),

In show_temp_fault(), extract the bit (0x1 or 0x2) and use it to return
the fault status.

static ssize_t show_temp_fault(struct device *dev,
                        struct device_attribute *devattr, char *buf)
{
        struct emc1023_data *data = emc1023_update_device(dev);
        unsigned int bit = to_sensor_dev_attr(devattr)->index;

	if (IS_ERR(data))
		return PTR_ERR(data);

        return sprintf(buf, "%u\n", !!(data->status & bit));
}

Which reminds me ... in recent drivers, we try to return error codes
from the update function, similar to what I did above. Look into
ltc4261.c to get some hints how to do that.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

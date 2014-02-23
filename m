From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 16:49:51 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (lm95245) Fix hysteresis temperatures
Message-Id: <20140223174951.7b348168@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393090212-24900-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393090212-24900-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 23 Feb 2014 08:26:53 -0800, Guenter Roeck wrote:
> On 02/23/2014 01:49 AM, Jean Delvare wrote:
> > On Sat, 22 Feb 2014 09:30:09 -0800, Guenter Roeck wrote:
> >>
> >>   	if (kstrtoul(buf, 10, &val) < 0)
> >>   		return -EINVAL;
> >>
> >> -	val /= 1000;
> >> -
> >> -	val = clamp_val(val, 0, 31);
> >> -
> >>   	mutex_lock(&data->update_lock);
> >>
> >> +	limit = i2c_smbus_read_byte_data(client, lm95245_reg_address[index]);
> >> +	hyst = limit - val / 1000;
> >> +	hyst = clamp_val(hyst, 0, 31);
> >
> > Note that you don't actually need to hold the lock for that. Access to
> > the SMBus itself is already serialized at the bus driver level, and
> > you're not touching any field of the data structure (that's what the
> > lock is protecting.)
>
> I think it was because the valid flag is cleared, to make sure the data
> is only re-read after the hysteresis register is written to.

I can't think of a scenario where it would make a difference. Trying to
set the limit and the hysteresis at the same time is racy by nature, I
don't think any amount of locking can help.

> >>   	data->valid = 0;
> >
> > BTW do you have any idea why the whole cache is invalidated here? I'd
> > think that storing hyst as data->regs[8] would be enough?
> 
> It also ensures that the limit register value in the cache is current,
> but since that is not volatile it should not really make a difference.

Agreed.

> I'll change that and only update regs[8]. But then I do need the lock,
> or at least I think so.

Yes, you do.

Thanks,
-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

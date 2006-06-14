From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Jun 2006 15:06:58 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <20060614170658.56cadfe9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> > The name is not very well chosen, these registers can hold both a target
> > temperature or a target fan speed depending on the control mode (even
> > if we don't support the latter at the moment.) What about just
> > W83627EHF_REG_TARGET?
> 
> I think this is in the plan for future driver upgrade.

Let's get the name right now, so that this future driver upgrade
doesn't have to change it everywhere.

> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> > > +	int nr = sensor_attr->index;
> > > +	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 1);
> > 
> > Using SENSOR_LIMIT here doesn't make sense, as we're not dealing with a
> > range. Better return -EINVAL if value is neither 0 nor 1.
> 
> Well yes why not, maybe we should write a note to a docs?

I think the best we can do is to make it right in our drivers, because
this is where people look when writing new drivers. If you want to
extend the sysfs-interface documentation file to describe how invalid
values should be handled (on write), feel free to do so.

> > I just realized that you are emulating pwm_enable = 0. I guess the chip
> > doesn't support it? Then you don't want to implement it in the driver.
> > This emulation makes your code much more complex with no gain at all.
> > Drivers must implement what the chip support, they must NOT emulate
> > features.
> 
> On the other hand we want consistent interface... I thought that either the file
> could be present or not, but if present it MUST support 0 and 1 at least.
> 
> I think you told me that that -EINVAL should do it and I can revert the
> emulation stuff back. But I think we should FIX this in docs so it cannot be a
> matter of interpretation.

Patch welcome :)

> As for the conditional register writes. You just told me to save one read and
> you dont want the conditional writes? hmmm?

Saving one read in a safe way, in a function which will be called
hundreds of times in the driver lifetime, is worth it. Saving a write
in a function which will be called only a few times in the driver
lifetime, in an unsafe way, is not good.

> Many thanks for the review. As I already told you we need some kind of wiki page
> describing all those pitfalls so I can easily check the stuff and dont forget
> about anything..
> 
> Anyone will help me?

I think I already helped much by reviewing so much code in the past.
Everything I said there is a candidate for your page if you want to
write it.

-- 
Jean Delvare


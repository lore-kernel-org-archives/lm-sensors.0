From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Sep 2009 16:16:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090918181638.42331042@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Samuel,

On Fri, 18 Sep 2009 16:42:49 +0200, Samuel Ortiz wrote:
> On Fri, Sep 18, 2009 at 02:09:23PM +0200, Rodolfo Giometti wrote:
> > +#define W627_DEVID		0x52
> > +#define W627THF_DEVID		0x82
> > +#define W697_DEVID		0x60
> > +#define W637_DEVID		0x70
> > +#define W687THF_DEVID		0x85
> > +#define WINB_ACT_REG		0x30
> > +#define WINB_BASE_REG		0x60
> Are those 2 last ones HWMON specific. If that's so, please be more specific
> about it.

No, these are standard registers common to all logical devices.

> > +/* Constants specified below */
> > +
> > +/* Offset & size of I/O region we are interested in */
> This seems to be the hwmon region, so please be more specific about it in the
> comments and in the naming below.

Correct.

> > +#define WINB_REGION_OFFSET	5
> > +#define WINB_REGION_SIZE	2
> > +
> > +static int __init w83627hf_find(int sioaddr, unsigned short *addr,
> > +				struct w83627hf_sio_data *sio_data)
> > +{
> > +	int err = -ENODEV;
> > +	u16 val;
> > +
> > +	sio_data->sioaddr = sioaddr;
> > +
> > +	superio_enter(sio_data);
> > +	val = force_id ? force_id : superio_inb(sio_data, 0x20);
> > +	switch (val) {
> > +	case W627_DEVID:
> > +		sio_data->type = w83627hf;
> > +		break;
> > +	case W627THF_DEVID:
> > +		sio_data->type = w83627thf;
> > +		break;
> > +	case W697_DEVID:
> > +		sio_data->type = w83697hf;
> > +		break;
> > +	case W637_DEVID:
> > +		sio_data->type = w83637hf;
> > +		break;
> > +	case W687THF_DEVID:
> > +		sio_data->type = w83687thf;
> > +		break;
> > +	case 0xff:	/* No device at all */
> > +		goto exit;
> > +	default:
> > +		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%02x)\n", val);
> > +		goto exit;
> > +	}
> > +
> > +	sio_data->name = names[sio_data->type];
> > +
> > +	superio_select(sio_data, W83627HF_LD_HWM);
> > +	force_hwmon_addr &= (~7);
> > +	if (force_hwmon_addr) {
> > +		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
> > +		       force_hwmon_addr);
> > +		superio_outb(sio_data, WINB_BASE_REG, force_hwmon_addr >> 8);
> > +		superio_outb(sio_data, WINB_BASE_REG + 1,
> > +					force_hwmon_addr & 0xff);
> > +	}
> > +	val = (superio_inb(sio_data, WINB_BASE_REG) << 8) |
> > +	       superio_inb(sio_data, WINB_BASE_REG + 1);
> > +	*addr = val & (~7);
> > +	if (*addr = 0) {
> > +		printk(KERN_WARNING DRVNAME ": Base address not set, "
> > +		       "skipping\n");
> > +		goto exit;
> > +	}
> > +
> > +	val = superio_inb(sio_data, WINB_ACT_REG);
> > +	if (!(val & 0x01)) {
> > +		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
> > +		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
> > +	}
> > +
> > +	err = 0;
> > +	pr_info(DRVNAME ": Found %s chip at %#x\n",
> > +		names[sio_data->type], *addr);
>
> I'm not familiar with this chip, but although the function is called
> w83627hf_find(), it seems to me that what we're doing here is enabling the
> hwmon subdevice. Am I correct ? If that's so, could we split this function,
> and maybe even move the hwmon specific part into the hwmon driver.

The enablement of the hwmon logical device is only a side effect. The
main goal of the function is to figure out whether a supported chip is
present, and which one. The original reason to put everything is the
same function is so that we don't have to enter and exit the super-io
config mode twice.

But I wouldn't object to it being split into two separate functions,
each one doing just one thing. That would be cleaner, and speed isn't
critical.

> > + exit:
> > +	superio_exit(sio_data);
> > +	return err;
> > +}

> > (...)
> > +static inline void superio_enter(struct w83627hf_sio_data *sio)
> > +{
> > +	mutex_lock(&sio->lock);
> > +
> > +	outb(0x87, sio->sioaddr);
> > +	outb(0x87, sio->sioaddr);
>
> I'm not really happy with this one. The unbalanced locking here makes me feel
> unconfortable.

Me, I don't have any objection. Callers will have to balance
superio_enter and superio_exit anyway. So hiding the mutex in there
seems reasonable.

> Something like that:
> 
> void superio_outb(struct w83627hf_sio_data *sio, int ld, int reg, int val)
> {
> 	mutex_lock(&sio->lock);
> 
> 	/* Enter */
> 	outb(0x87, sio->sioaddr)
> 	outb(0x87, sio->sioaddr)
> 
> 	/* Select module */
> 	outb(0x07, sio->sioaddr);
> 	outb(ld, sio->sioaddr + 1);
> 
> 	/* Write */
> 	outb(reg, sio->sioaddr);
> 	outb(val, sio->sioaddr + 1);
> 
> 	/* Exit */
> 	outb(0xAA, sio->sioaddr);
> 
> 	mutex_unlock(&sio->lock);
> }
> 
> would look saner to me. I know we're wasting many IO ops here, but it seems to
> me that the subdevices get to call the superio API only at init time.
> I think it's worth it as your subdevices wouldnt have to care about following
> these error prone steps, and you wouldnt have any more unbalanced locking
> risks.

The above has limitations. Think of the hwmon logical device enablement
function which we discussed above. In this function we must read a
register, and depending on the value, maybe write to it, but altering
only one bit (so based on the original value.)

There is no way to achieve this in a race-free manner with your
proposed superio_outb() function and the equivalent superio_inb()
implementation. Even a superio_alterb() function wouldn't do, because
we want to print a message.

At least with Rodolfo's proposal, this can be done. With your approach,
we'd need dedicated functions for every non-trivial register access.

As far as speed is concerned, I agree it's not critical, at least for
the use cases I know of. 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

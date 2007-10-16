From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 16 Oct 2007 17:01:58 +0000
Subject: Re: [lm-sensors] [PATCH] v2 of Intel FB-DIMM AMB temperature sensors
Message-Id: <20071016170158.GQ16752@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070731183706.GG2795@tree.beaverton.ibm.com>
In-Reply-To: <20070731183706.GG2795@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 16, 2007 at 08:54:29AM -0400, Mark M. Hoffman wrote:

> > +config SENSORS_I5K_AMB
> > +	tristate "FB-DIMM AMB temperature sensor on Intel 5000 series chipsets"
> > +	depends on I2C && EXPERIMENTAL
> 
> ...and X86, presumably.

Come to think of it, PCI as well.

> > +#define PCI_VENDOR_INTEL		0x8086
> > +#define PCI_DEVICE_INTEL_5K_MEM		0x25F0
> > +#define PCI_DEVICE_INTEL_5K_FBD0	0x25F5
> > +#define PCI_DEVICE_INTEL_5K_FBD1	0x25F6
> > +
> 
> PCI_VENDOR_ID_INTEL is already defined.  The rest should be added to
> include/linux/pci_ids.h, not here.  You can do that in the same patch.

Will do.

> > +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
> 
> Just DEVICE_ATTR is enough here.
> 
> > +static struct platform_device *amb_pdev = NULL;
> 
> Initialization to 0/NULL is unnecessary.
> 
> > +static u8 amb_read_byte(struct i5k_amb_data *data, unsigned long offset)
> > +{
> > +	return (*(u8*)(data->amb_mmio + offset));
> 
> 	return ioread8(data->amb_mmio + offset);
> > +}
> > +
> > +static void amb_write_byte(struct i5k_amb_data *data, unsigned long offset,
> > +			   u8 val)
> > +{
> > +	(*(u8*)(data->amb_mmio + offset)) = val;
> 
> 	iowrite8(val, data->amb_mmio + offset);

Ack to all of these.

> > +	int temp = simple_strtol(buf, NULL, 10) / 500;
> > +
> > +	if (temp > 255)
> > +		temp = 255;
> > +
> > +	amb_write_byte(data, AMB_REG_TEMP_MIN(attr->index), temp);
> > +	return count;
> > +}
> 
> See Documentation/hwmon/sysfs_interface: sysfs attribute writes interpretation
> 
> Summary: use long instead of int, and range check on both ends.

And these.

> > +			sprintf(n, "temp%d_input", d);
> 
> Is it possible, at least in theory, for d > 99?

No.  The highest that d will ever get is MAX_MEM_CHANNELS *
REAL_MAX_AMBS_PER_CHANNEL, which is 60.  As I recall, the specs for the
5000 chipset also say that there are 4 channels with a maximum of 16
DIMMs per channel, so the most you'd ever see on a system is 64 DIMMs.

> > +	for (i = 0; i < data->num_attrs; i++) {
> > +		device_remove_file(&pdev->dev, &data->attrs[i].dev_attr);
> > +		kfree(data->attrs[i].dev_attr.attr.name);
> > +	}
> > +	kfree(data->attrs);
> 
> Hmm, would be nice if data->attrs included space for all the strings, too.
> Then you could kmalloc/kfree in one shot.

Good idea.

> > +	/* Copy the DIMM presence map for the optional second two channels */
> > +	pcidev = pci_get_device(PCI_VENDOR_INTEL, PCI_DEVICE_INTEL_5K_FBD1,
> > +				NULL);
> > +	if (!pcidev)
> > +		goto setup_resources;
> > +
> 
> Abuse of goto.  OK, maybe it's nit-picky... the accepted idiom in Linux is to
> use goto to unwind inits after an error.  This is not an error condition, *and*
> this goto is easily replaced by an if statement.

Sorry for the spaghetti code. :)

Thanks for the detailed review!  I'll correct the problems that you
pointed out in the next revision of the patch.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

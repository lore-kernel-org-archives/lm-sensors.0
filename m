From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 26 May 2010 16:36:59 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (ltc4245) expose all GPIO pins
Message-Id: <20100526183659.7d59ea11@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271199569-3880-3-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1271199569-3880-3-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Wed, 26 May 2010 08:42:26 -0700, Ira W. Snyder wrote:
> On Wed, May 26, 2010 at 01:31:44PM +0200, Jean Delvare wrote:
> > On Tue, 13 Apr 2010 15:59:29 -0700, Ira W. Snyder wrote:
> > > +
> > > +	/* Update saved data */
> > > +	data->cregs[LTC4245_GPIO] = gpio;
> > > +	data->last_gpio = gpio_next;
> > > +}
> > > +#else
> > > +static void ltc4245_update_gpios(struct device *dev)
> > > +{
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct ltc4245_data *data = i2c_get_clientdata(client);
> > > +
> > > +	/* Just copy the data from the the GPIOADC register */
> > > +	data->gpios[0] = data->vregs[LTC4245_GPIOADC - 0x10];
> > > +}
> > > +#endif
> > 
> > Not sure why you define this stub function. If you want your patch to
> > be as little intrusive as possible, you can skip ltc4245_update_gpios
> > altogether in the general case, and handle in9 as every other voltage
> > input as the driver was doing before your patch.
> 
> I did it so ltc4245_update_gpios() could be called in both cases,
> without any conditional logic. See the hunk below. I just call
> ltc4245_update_gpios() without any #ifdef, it "just works" in both
> cases.
> 
> This is the usual thing Linux does with headers. For example, see
> include/linux/pci.h pci_enable_msix() function. When CONFIG_PCI_MSI=n
> they stub out the function so it does the right thing: return an error.

Sorry for not being clear. I wasn't objecting to the stub's existence,
but to the fact that it was doing something. I expected it to do
nothing at all, and ltc4245_show_voltage() would be used for in9.

> > > (...)
> > > +#define LTC4245_GPIO(name, gpio_num) \
> > > +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
> > > +	ltc4245_show_gpio, NULL, gpio_num)
> > 
> > You already have an enum value by that name, this is confusing. That's
> > what you get for prefixing your register names with only LTC4245_
> > instead of LTC4245_REG_ as most drivers are doing.
> 
> The driver works, so I guess the compiler isn't confused. How about I
> rename the macro? Is there a different name you would suggest?

I was about to suggest LTC4245_GPIOADC, you that one already exists
too. LTC4245_VOLTAGE_GPIO maybe?

> > > @@ -336,6 +425,10 @@ static struct attribute *ltc4245_attributes[] = {
> > >  	&sensor_dev_attr_in8_min_alarm.dev_attr.attr,
> > >  
> > >  	&sensor_dev_attr_in9_input.dev_attr.attr,
> > > +#ifdef CONFIG_SENSORS_LTC4245_EXTRA_GPIOS
> > > +	&sensor_dev_attr_in10_input.dev_attr.attr,
> > > +	&sensor_dev_attr_in11_input.dev_attr.attr,
> > > +#endif
> > >  
> > >  	&sensor_dev_attr_power1_input.dev_attr.attr,
> > >  	&sensor_dev_attr_power2_input.dev_attr.attr,
> > 
> 
> One more question: if I use a module parameter or platform data to
> enable the extra GPIOs, how would I handle this array? I don't see how I
> can make it work other than generating two different (mostly redundant)
> arrays and registering a different one for each configuration.

No, you would move in10 and in11 to a separate array of attributes,
with a dedicated attribute group. The general code path would register
ltc4245_group, and your platform specific code path would additionally
register that other group. See drivers/hwmon/adm1025.c for an example,
the in4* attributes are in a separate group.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 27 May 2011 08:01:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver sch5636
Message-Id: <4DDF5A56.9080606@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306255997-4337-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1306255997-4337-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 05/26/2011 09:09 PM, Jean Delvare wrote:
> Hi Hans,
>
> On Tue, 24 May 2011 18:53:17 +0200, Hans de Goede wrote:
>> This patch adds a new driver for SMSC SCH5636 Super I/O chips.
>> The chips include an embedded microcontroller for hardware monitoring
>> solutions, allowing motherboard manufacturers to create their own custom
>> hwmon solution based upon the SCH5636.
>>
>> Currently the sch5636 driver only supports the Fujitsu Theseus SCH5636 based
>> hwmon solution. The sch5636 driver runs a sanity check on loading to ensure
>> it is dealing with a Fujitsu Theseus and not with another custom SCH5636 based
>> hwmon solution.
>
> Overall it looks very good, see my comments inline below.
>


Thanks for the review! I 100% agree with most comments and will
fix them in the next iteration. In some cases I've some questions /
remarks, see below.

<snip>

>> +#include<linux/io.h>
>> +#include<linux/acpi.h>
>> +#include<linux/delay.h>
>> +
>> +#define DRVNAME "sch5636"
>> +#define DEVNAME "theseus" /* We only support one model for now */
>
> Not sure if you really need a define for the device name. We'll have to
> remove it if we ever add support for a second device.

The idea is that having a DEVNAME define later allows a simple
search replace DEVNAME -> names[index].

Note that this is identical to how the device name is handled
in sch5627.

>
>> +
>> +#define SIO_SCH5636_EM_LD	0x0C	/* Embedded Microcontroller LD */
>
> _LD_EM would make more sense IMHO. You could also spell out "logical
> device" in the comment, it's not necessarily obvious to everyone.
>

This is identical to how this is named in the sch5627 driver.

>> +#define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
>> +#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
>
> Each being used only once, I'm not sure if you really need defines.
>

idem as above, and the same goes for many other drivers, AFAIK all superio
drivers do it like this...

>> +
>> +#define SIO_REG_LDSEL		0x07	/* Logical device select */
>> +#define SIO_REG_DEVID		0x20	/* Device ID */
>> +#define SIO_REG_ENABLE		0x30	/* Logical device enable */

<snip>

>> +
>> +static int sch5636_send_cmd(struct sch5636_data *data, u8 cmd, u16 reg, u8 v)
>> +{
>
> This looks very similar to the SCH5627. Have you considered having a
> single driver for both? Or at least having a common part?

Actually it is identical, I've considered having a single driver but there
are quite a lot of differences, and I've a feeling we may see more Fujitsu
solutions based on the sch5636, so it seemed better to make to make it a
clean new driver (also keeping in mind that we may need to support multiple
models with it in the future).

Thinking more about this, I think this may be best handled as follows:

Have a sch5627-common.ko which contains the sch5627_send_cmd + read / write
virtual reg functions, as well as the sch5627_find and sch5627_device_add
functions (which will now find and device_add both the sch5627 and sch5636,
and have a sch5627.ko and a sch5636.ko which contain the actual driver(s),
and do the platform_driver[un]register. Loading either if these 2 will
automatically also load sch5627-common.ko (since they use symbols from it)
which will then do the find + device add.

Does this sound like an idea? Alternatively we could just keep the 2
drivers separate.

<snip>

>> +
>> +	if (strcmp(id, "THS")) {
>> +		pr_err("Unknown Fujitsu id: '%s'\n", id);
>
> This could print complete garbage, you have no guarantee that the bytes
> are in the 32-126 range.
>

Good point, still I would like to print it as a string so that if a user
encounters a new device before I know about it, they can give me the
3 letter Fujitsu ID. I see 2 options:

1) Always print it as %02x%02x%02x
2) Sanity check and print as string if sanity check matches, else
    as %02x%02x%02x.

<snip>

>> +static int __init sch5636_init(void)
>> +{
>> +	int err = -ENODEV;
>> +	unsigned short address;
>> +
>> +	if (sch5636_find(0x4e,&address)&&  sch5636_find(0x2e,&address))
>> +		goto exit;
>
> Please return the error code from sch5636_find, instead of hard-coding
> -ENODEV.
>
> Out of curiosity, why are you checking 0x4e first, when all other
> drivers check 0x2e first?

Because the 2 boards (sch5627 + sch5636) have them at 0x4e rather
then 0x2e. And before your review of the sch5627 driver it used
to print an error when it could not find the chip it 0x2e...

Anyways if we change this, we should fix it in the sch5627 driver too.

>
>> +
>> +	err = platform_driver_register(&sch5636_driver);
>> +	if (err)
>> +		goto exit;
>> +
>> +	err = sch5636_device_add(address);
>> +	if (err)
>> +		goto exit_driver;
>> +
>> +	return 0;
>> +
>> +exit_driver:
>> +	platform_driver_unregister(&sch5636_driver);
>> +exit:
>> +	return err;
>> +}
>> +
>> +static void __exit sch5636_exit(void)
>> +{
>> +	platform_device_unregister(sch5636_pdev);
>> +	platform_driver_unregister(&sch5636_driver);
>> +}
>> +
>> +MODULE_DESCRIPTION("SMSC SCH5636 Hardware Monitoring Driver");
>> +MODULE_AUTHOR("Hans de Goede (hdegoede@redhat.com)");
>
> Please use<  >  instead of ( ) so that people can copy and paste
> directly.

Good one, again same in the sch5627 driver, no idea how that got there...

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

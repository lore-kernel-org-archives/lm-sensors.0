From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 13 Mar 2011 12:39:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for SMSC SCH5627 hwmon
Message-Id: <4D7CBB06.6090103@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 03/12/2011 12:09 PM, Jean Delvare wrote:

Thanks for the review! I've prepared a new version of the
patch addressing all your comments, below are some remarks
from me wrt those comments which warrant a reply.

<snip snip>

>> +#define DRVNAME "sch5627"
>> +
>> +#define SIO_SCH5627_EM_LD	0x0C	/* Embedded Microcontroller LD */
>> +#define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
>> +#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
>
> Typo: disable.
>

Copy paste from f71882fg.c will fix there as well.

<snip>

>> +static const int SCH5627_REG_IN_FACTOR[SCH5627_NO_IN] = {
>> +	10745, 3660, 9765, 10745, 3660 };
>> +static const char * const SCH5627_IN_LABELS[SCH5627_NO_IN] = {
>> +	"VCC", "VTT", "VBAT", "VTR", "V_IN" };
>
> V_IN sounds very much like a generic name for any external voltage
> input. I'd suggest not exposing a label in this case, to let user-space
> deal with it through a configuration file.

Ok, I've changed the sysfs attr table to no longer have an in4_label,
I've opted to leave V_IN in SCH5627_IN_LABELS for future reference
and also to keep the array sized the same as the other IN related arrays.

<snip>

>> +	 */
>> +
>> +	/* Read Data from Mailbox */
>> +	return inb(data->addr + 4);
>> +}
>
> Ah, the elegance of EC-based register access! :(
>

Yep.

>> +
>> +static int sch5627_read_virtual_reg16(struct sch5627_data *data, u16 reg)
>> +{
>> +	int lsb, msb;
>> +
>> +	/* Read LSB first, this will cause the matching MSB to be latched */
>> +	lsb = sch5627_read_virtual_reg(data, reg);
>> +	if (lsb<  0)
>> +		return lsb;
>> +
>> +	msb = sch5627_read_virtual_reg(data, reg + 1);
>> +	if (msb<  0)
>> +		return msb;
>> +
>> +	return lsb | (msb<<  8);
>> +}
>> +
>> +static int sch5627_read_virtual_reg12(struct sch5627_data *data, u16 msb_reg,
>> +				      u16 lsn_reg, int high_nibble)
>> +{
>> +	int msb, lsn = -1;
>
> Useless initialization, unless I'm blind.
>
>> +
>> +	/* Read MSB first, this will cause the matching LSN to be latched */
>
> I.e. reverse from 16-bit values? How weird :(
>

Yep, this also means we cannot read the lsn register once for 2 12 bit reads,
I had code for that (which the useless initialization you spotted was a left
over of).

>> +static int reg_to_rpm(u16 reg)
>> +{
>> +	if (reg = 0)
>> +		reg = 1;
>
> This arbitrary decision is discussable. I presume that reg = 0 means an
> error condition, either an internal one or a problem with the fan. This
> would rather be reported to user-space as 0 (0 RPM) or a negative error
> code (libsensors does handle -EIO gracefully) rather than an impossible
> sped of 5400540 RPM.
>

Agreed, since the app note says 0xFFFF is the fan fault value, we should
really never see 0, so I've changed the code to return -EIO in this case.

>> +
>> +	return 5400540 / reg;
>
> What a weird number.

Straight from the app note. I'll mail you the appnote for your datasheet
archive (I've permission to share it).

<snip>

>> +static int sch5627_remove(struct platform_device *pdev)
>> +{
>> +	struct sch5627_data *data = platform_get_drvdata(pdev);
>> +
>> +	platform_set_drvdata(pdev, NULL);
>
> This is racy. You should unregister the device and delete the
> attributes first, and only then clear the driver data pointer.
>

Copy paste from f71882fg.c will fix there as well.

<snip>

> Overall the code is pretty clean, good work!
>

Thanks.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

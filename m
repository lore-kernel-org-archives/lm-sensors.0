From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Feb 2010 19:09:55 +0000
Subject: Re: [lm-sensors] Core i3 support?
Message-Id: <20100212200955.05730d69@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100210154404.45e8afd6@hyperion.delvare>
	<d35bed621002100703s52296ad0v53fe375f777e55ee@mail.gmail.com>
	<20100210180116.GG29604@tux1.beaverton.ibm.com>
	<d35bed621002101007y639fd3c7k736ef53ff400f79@mail.gmail.com>
	<20100210204057.2ca95b0d@hyperion.delvare>
	<d35bed621002101223ida7758fp5ccbedfe25bd3148@mail.gmail.com>
	<20100211012105.GH29604@tux1.beaverton.ibm.com>
	<d35bed621002102333i701a212re957efb600cbda5f@mail.gmail.com>
	<20100211091743.287030b0@hyperion.delvare>
	<d35bed621002110842h54c8185fqf3bf481ad63df7bf@mail.gmail.com>
	<20100212185241.GJ29604@tux1.beaverton.ibm.com>
In-Reply-To: <20100212185241.GJ29604@tux1.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: "D. Can Celasun" <dcelasun@gmail.com>, Huaxu Wan <huaxu.wan@intel.com>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Fri, 12 Feb 2010 10:52:41 -0800, Darrick J. Wong wrote:
> On Thu, Feb 11, 2010 at 06:42:28PM +0200, D. Can Celasun wrote:
> > On 11 February 2010 10:17, Jean Delvare <khali@linux-fr.org> wrote:
> > > Darrick, any chance we could get the i2c-scmi driver to load
> > > automatically on systems which need it?
> 
> I think all we need to do is add:
> 
> MODULE_DEVICE_TABLE(acpi, fan_device_ids);

I guess you mean:

MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);

> 
> to i2c-scmi.c, which will add the appropriate aliases to the module info.

OK. Care to send a patch?

> That reminds me, I don't think that patch to add ACPI_SMBUS_IBM_HID to the ACPI
> header files ever went in, did it?  It doesn't seem to be in 2.6.33-rc7, but
> maybe it's queued in someone else's ACPI tree for .34?

I have pinged Bjorn and Len twice already (December 17th, January 5th)
but never heard back.

> If it's not, then I'd
> imagine it's still blocking the patchset to i2c-scmi that works around broken
> IBM BIOSes, so I'm hoping someone from the ACPI part of the world can comment?

Yes it is blocking the i2c-scmi patch. And yes, please ACPI people take
care of it ASAP.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

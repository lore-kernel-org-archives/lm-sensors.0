From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 03 Aug 2009 20:52:29 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] acpi_power_meter: hwmon driver for
Message-Id: <20090803205229.GB14694@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com> <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com> <1248677155.2670.132.camel@rzhang-dt>
In-Reply-To: <1248677155.2670.132.camel@rzhang-dt>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, Jul 27, 2009 at 02:45:55PM +0800, Zhang Rui wrote:
> Hi, Darrick,
>=20
> great job. :)

Thanks.

> we should at least send a netlink event for an ACPI power meter
> notification, shouldn't we?

Yes, an event would be useful at the very least for when the system starts
capping, though unfortunately there doesn't seem to be a Notify event for w=
hen
capping ends.

> we should create the hwmon sysfs I/F for the hwmon device,
> i.e. add the hwmon attributes
> under /sys/devices/LINUXSYS:00/.../ACPI000D:00/hwmon0/
> rather than =EF=BB=BF/sys/devices/LINUXSYS:00/.../ACPI000D:00/

Hee, this is a tricky matter.  The other hwmon drivers create sysfs attribu=
tes
under the sysfs object, not in a separate "hwmonX" object, and as I recall
libsensors reads symlinks under the device object to figure out which bus t=
he
sensor device lives on.  If it can't figure that out, it ignores the hwmon
device.

> 	  if (acpi_disable)
> 		return -ENODEV;

Noted.

> plus, _PMD is not supported in this driver, right?
> I agree with Yakui that we can create some ACPI device sysfs attributes
> besides the hwmon ones. e.g. exporting devices measured by the current
> ACPI power meter device to user space.

I agree.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

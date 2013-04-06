From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 16:54:28 +0000
Subject: Re: [lm-sensors] IT8772E Test
Message-Id: <20130406165428.GA11424@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365042247.19144.9.camel@janus>
In-Reply-To: <1365042247.19144.9.camel@janus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 06, 2013 at 09:41:05AM -0700, James Webb wrote:
> It's ACPI:
> 
> it87: Found IT8772F chip at 0xa30, revision 0
> ACPI Warning: 0x0000000000000a35-0x0000000000000a36 SystemIO conflicts with
> Region \_SB_.PCI0.SBRG.LBAE 1 (20121018/utaddress-251)
> ACPI: If an ACPI driver is available for this device, you should use it
> instead of the native driver
> 
> No idea what this is. Will running acpid help?
>
See http://hansdegoede.livejournal.com/7932.html for an explanation.

The page describes a workaround, but it may be risky.

Guenter

> 
> On Wed, Apr 3, 2013 at 8:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Wed, Apr 03, 2013 at 07:24:07PM -0700, James Webb wrote:
> > > Running a Dell XPS-8300
> > > sensors-detect reports:
> > > Found `ITE IT8772E Super IO Sensors'                        Success!
> > >     (address 0xa30, driver `to-be-written')
> > > Compiled standalone driver but either modprobe it87 or modprobe it87
> > > force_id=0x8721 results in:
> > > FATAL: Error inserting it87
> > > (/lib/modules/3.8.5-gentoo/kernel/drivers/hwmon/it87.ko): Device or
> > > resource busy
> > >
> > > Any suggestions?
> > >
> > Some other device has its io memory space reserved, or the io memory
> > space is reserved by ACPI (which is more likely). In the latter case,
> > you should see an acpi resource conflict message on the console
> > (or with dmesg).  Otherwise, 'cat /proc/ioports' should give you
> > an idea about the offending driver.
> >
> > Guenter
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

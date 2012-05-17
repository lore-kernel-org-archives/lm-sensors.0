From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 17 May 2012 22:59:05 +0000
Subject: Re: [lm-sensors] [PATCH v6 3/3] gpio: TS-5500 GPIO support
Message-Id: <CACxGe6v20FnMrpE9ZFTQuhOUoJJrAgN_YKHXDT8GF4rH0VUd6A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1334276935-11258-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <1334276935-11258-4-git-send-email-vivien.didelot@savoirfairelinux.com>
 <20120517210633.400633E0621@localhost> <1337290826.7033.10.camel@trivette.site>
In-Reply-To: <1337290826.7033.10.camel@trivette.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: x86@kernel.org, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Linus Walleij <linus.walleij@stericsson.com>

On Thu, May 17, 2012 at 3:40 PM, Vivien Didelot
<vivien.didelot@savoirfairelinux.com> wrote:
> On Thu, 2012-05-17 at 15:06 -0600, Grant Likely wrote:
>> > =A0arch/x86/include/asm/ts5500.h | =A0 62 ++++++++
>>
>> Why the separate header file? =A0What will use these defines? =A0I
>> normally expect driver-specific defines to be in the driver .c file
>> directly; particularly for things like gpio drivers which should be a
>> generic interface that doesn't need to export symbols.
>
> Should an intermediate driver directly use values for GPIOs instead of
> these symbols? For example, how should a temperature sensor plugged on
> this platform refer to inputs and outputs?

Tell me more about this platform.  Where does the data about
connections come from?  Is it a purpose-built embedded system?  Is the
GPIO controller described in ACPI? (probably not since GPIOs were only
added to ACPI in v5)  Does the end-user attach her own hardware to the
board like the temperature sensor you describe?  If so, is that
hardware driven by kernel drivers or user-space drivers?

For userspace drivers you can get information about the GPIO number
assignments from /sys, but it isn't well documented and can probably
be improved.

If it is kernelspace, then you really need a way to add data about the
platform to the kernel at runtime.  Having it statically compiled in
isn't a very good solution.  I would recommend injecting configuration
data into the kernel from userspace.  You could invent something, but
that wouldn't be very portable.  Xilinx has done some work on this
using Flattened Device Tree and the firmware loading infrastructure.
The kernel requests a .dtb (device tree blob) from userspace and uses
that to configure devices.  That may do the job for you.  GPIO and
platform device infrastructure already have FDT support which will
help you here.  I expect it could be done with an ACPI fragment too,
but I just don't know of anybody having done any work in this area.

That probably isn't the answer you want though since I assume you just
need to get something that works rather than investing a whole bunch
of time on generic infrastructure.  What I would recommend is for your
platform setup code to use a notifier to wait for the
BUS_NOTIFY_BOUND_DRIVER event and then register the temperature sensor
with the correct gpio number at that time (because once you have a
reference to the gpio controller you can calculate the assigned gpio
numbers).

g.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

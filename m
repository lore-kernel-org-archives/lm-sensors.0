From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 07:42:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
Message-Id: <20100331094247.049e3012@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100309135636.373a40a9@hyperion.delvare>
	<20100330120319.627e8f9a@hyperion.delvare>
	<20100330132132.GA16657@srcf.ucam.org>
	<20100330214732.42f488ba@hyperion.delvare>
	<20100330194835.GA32322@srcf.ucam.org>
	<20100330223251.76c6b000@hyperion.delvare>
	<20100330211049.GA1524@srcf.ucam.org>
In-Reply-To: <20100330211049.GA1524@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>

On Tue, 30 Mar 2010 22:10:49 +0100, Matthew Garrett wrote:
> On Tue, Mar 30, 2010 at 10:32:51PM +0200, Jean Delvare wrote:
> 
> > Sure, but why do you insist on having the user configure this manually
> > when we can automate this at the kernel level? When
> > acpi_enforce_resouce=yes, the kernel doesn't let non-ACPI driver be
> > loaded, so I fail to see why we let ACPI drivers (for which we also
> > have native drivers) load when acpi_enforce_resouce=no.
> 
> Because the situation with the asus driver loaded isn't obviously any 
> worse than not having it loaded. The user is telling us that they're 
> happy with racy access to their hwmon hardware.

No, they are not saying that. They are saying: I want to let native
drivers access ACPI-reserved I/O ports. That's all they are saying.
Attaching a single interpretation to this is incorrect. They might do
this because their BIOS improperly reserves ports it doesn't use. Or
because they prefer using a native driver over an ACPI driver for a
given chip. Or indeed because they want to crash their machine. Just
because it can't be called generally safe (and in all honesty is unsafe
in many cases, quite possibly the majority) doesn't mean there are no
cases where it makes sense. Hell, we lived without ACPI resource
reservation until kernel 2.6.32 and without the asus_atk0110 driver and
most people were totally happy with the situation.

> Automatically blocking 
> the loading of the ACPI driver does nothing other than imply to the user 
> that things are safe,

Again, no, it doesn't imply that. It implies that loading the
asus_atk0110 driver together with a native driver for the same device
is very bad and should never be done, period.

> when in reality they're anything but.

They sometimes are, this is the point.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

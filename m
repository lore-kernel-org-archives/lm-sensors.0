From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Mar 2010 20:32:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
Message-Id: <20100330223251.76c6b000@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100309135636.373a40a9@hyperion.delvare>
	<20100330120319.627e8f9a@hyperion.delvare>
	<20100330132132.GA16657@srcf.ucam.org>
	<20100330214732.42f488ba@hyperion.delvare>
	<20100330194835.GA32322@srcf.ucam.org>
In-Reply-To: <20100330194835.GA32322@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>

On Tue, 30 Mar 2010 20:48:36 +0100, Matthew Garrett wrote:
> On Tue, Mar 30, 2010 at 09:47:32PM +0200, Jean Delvare wrote:
> 
> > The asus_atk0110 driver loads automatically. The user doesn't configure
> > anything, and it just loads. That's the problem. If the driver didn't
> > load automatically, I wouldn't care. If you know of any way to prevent
> > the asus_atk0110 driver from auto-loading as soon as
> > acpi_enforce_resouce=lax or =no is passed, I am fine with this as well.
> > This is what I wanted to do originally, but I couldn't find a way to do
> > it, which is why I went for the more radical option of preventing the
> > asus_atk0110 driver from loading.
> 
> echo blacklist asus_atk0110 >/etc/modprobe.d/hwmon_blacklist.conf

Sure, but why do you insist on having the user configure this manually
when we can automate this at the kernel level? When
acpi_enforce_resouce=yes, the kernel doesn't let non-ACPI driver be
loaded, so I fail to see why we let ACPI drivers (for which we also
have native drivers) load when acpi_enforce_resouce=no.

Or is there something really wrong with my patch?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

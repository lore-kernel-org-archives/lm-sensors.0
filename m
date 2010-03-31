From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 07:30:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
Message-Id: <20100331093004.5143415f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100309135636.373a40a9@hyperion.delvare>
	<20100330120319.627e8f9a@hyperion.delvare>
	<20100330132132.GA16657@srcf.ucam.org>
	<20100330214732.42f488ba@hyperion.delvare>
	<20100330194835.GA32322@srcf.ucam.org>
	<20100330223251.76c6b000@hyperion.delvare>
	<20100330211049.GA1524@srcf.ucam.org>
	<68676e01003301445v1b3ee070nfc0f0b53716c4740@mail.gmail.com>
	<20100330215305.GA2220@srcf.ucam.org>
In-Reply-To: <20100330215305.GA2220@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Tue, 30 Mar 2010 22:53:05 +0100, Matthew Garrett wrote:
> On Tue, Mar 30, 2010 at 11:45:46PM +0200, Luca Tettamanti wrote:
> > On Tue, Mar 30, 2010 at 11:10 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > Because the situation with the asus driver loaded isn't obviously any
> > > worse than not having it loaded. The user is telling us that they're
> > > happy with racy access to their hwmon hardware.
> > 
> > "lax" option is typically used when the user wants to load the native
> > driver; in this case we know that it's not safe to load asus driver.
> 
> It's not safe to load the native driver, full stop. Not loading the asus 
> driver doesn't alter that.

It definitely does. At least on some of the affected boards, no access
to the I/O area in question is done at all as long as the asus_atk0110
driver is not loaded. So it is actually safe to pass
acpi_enforce_resources=lax and not load the asus_atk0110 driver. And
people are actually doing this because native drivers can control the
speed of their fans while the asus_atk0110 driver can't. So they see
the current situation as a regression.

Again, can you please point to problems my patch has?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

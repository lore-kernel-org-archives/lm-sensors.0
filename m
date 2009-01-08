From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Thu, 08 Jan 2009 20:13:37 +0000
Subject: Re: [lm-sensors] [PATCH] ACPI: set acpi_enforce_resources to strict
Message-Id: <68676e00901081213i4d40448y257ccbc8d4776c69@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090106182012.GA6668@dreamland.darkstar.lan>
	 <49662697.9080302@redhat.com>
In-Reply-To: <49662697.9080302@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

On Thu, Jan 8, 2009 at 5:15 PM, Hans de Goede <hdegoede@redhat.com> wrote:
[...]
> So back to the discussion about changing the default of
> acpi_enforce_resources to strict, Jean and I have been discussing this on
> IRC and we feel it will most likely cause too much pain. So we would like to
> suggest to make the default depend up on the motherboard. Our plan is to
> have the default be "auto" and that will mean "lax", unless the motherboard
> is atk0110 (Asus ACPI interface for reading hwmon data) capable and in that
> case "auto" will mean "strict"

Hum, that would mean putting ATK specific code into ACPI subsystem.
It's not pretty :S

> The plan is then to merge this acpi subsystem change and the atk0110 driver
> at the same time, so that people will get different hwmon capabilities, but
> won't loose hwmon capabilities all together. Important note: this is meant
> as an temporary state of affairs, the end goal is to make the checking
> strict.
>
> Luca do you think you could do a patch implementing the described "auto"
> value for acpi_enforce_resources ?

So the logic would be:
- if ATK node is present and the driver is enabled -> strict
- otherwise -> auto

I don't if I can use the ACPI interpreter early enough to check the
DSDT though; AFAICS the alternatives are:
- DMI which would require an entry for each mobo (notebooks don't have
the ATK interface)
- an initcall in the ATK driver that overrides the value of
acpi_enforce_resources to strict

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

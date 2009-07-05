From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 05 Jul 2009 15:48:37 +0000
Subject: Re: [lm-sensors] w83627hf Device needs an ACPI driver
Message-Id: <68676e00907050848t3887ef8eo2e21fca22f5234d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6977f2fc0907050840g7b70bdb8jf8a9a85f2be730a4@mail.gmail.com>
In-Reply-To: <6977f2fc0907050840g7b70bdb8jf8a9a85f2be730a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 5, 2009 at 5:40 PM, Christopher
Hogan<chris.c.hogan@gmail.com> wrote:
> Loading w83627hf produces the following error:
> w83627hf: Found W83627HF chip at 0x290
> ACPI: I/O resource w83627hf [0x295-0x296] conflicts with ACPI region
> IP__ [0x295-0x296]
> ACPI: Device needs an ACPI driver
>
> I have ACPI compiled into kernel 2.6.29-gentoo-r3.
>
> I googled a bit and found kernel bug:
> http://bugzilla.kernel.org/show_bug.cgi?id508
>
> Am I correct that an ACPI compatible driver for this chip doesn't
> exist

What motherboard is this? For ASUS there's asus_atk0110.

> and that I should disable part/all of ACPI in order to have full
> access to my sensors?

Disabling ACPI on a modern system is not an option. You can override
that check with acpi_enforce_resources=lax (kernel option), but - as
the message says - both ACPI subsystem and the native hwmon driver
might try to touch the chip at the same time.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

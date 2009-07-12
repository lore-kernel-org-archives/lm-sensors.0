From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 12 Jul 2009 08:44:49 +0000
Subject: Re: [lm-sensors] w83627hf Device needs an ACPI driver
Message-Id: <4A59A281.3070408@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <6977f2fc0907050840g7b70bdb8jf8a9a85f2be730a4@mail.gmail.com>
In-Reply-To: <6977f2fc0907050840g7b70bdb8jf8a9a85f2be730a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/05/2009 05:40 PM, Christopher Hogan wrote:
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
> exist and that I should disable part/all of ACPI in order to have full
> access to my sensors?
>

Hi,

For (some) more info on this see:
http://hansdegoede.livejournal.com/7932.html

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

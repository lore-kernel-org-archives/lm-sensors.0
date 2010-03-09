From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 09 Mar 2010 20:20:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
Message-Id: <68676e01003091220h115044b2y16f78dc2ad39236d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100309135636.373a40a9@hyperion.delvare>
In-Reply-To: <20100309135636.373a40a9@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 9, 2010 at 1:56 PM, Jean Delvare <khali@linux-fr.org> wrote:
> When the user passes the kernel parameter acpi_enforce_resources=lax,
> the ACPI resources are no longer protected, so a native driver can
> make use of them. In that case, we do not want the asus_atk0110 to be
> loaded. Unfortunately, this driver loads automatically due to its
> MODULE_DEVICE_TABLE, so the user ends up with two drivers loaded for
> the same device - this is bad.
>
> So I suggest that we prevent the asus_atk0110 driver from loading if
> acpi_enforce_resources=lax.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Luca Tettamanti <kronos.it@gmail.com>
> Cc: Len Brown <lenb@kernel.org>

Acked-by: Luca Tettamanti <kronos.it@gmail.com>

> ---
> Luca, what do you think? I had the idea to write this patch after
> seeing this bug report:
> https://bugzilla.novell.com/show_bug.cgi?idX0988
> I'm not sure if the driver conflict is the root cause of the problem,
> but it certainly did not help.

The patch look good.

> Another approach would be to hide the ATK0110 ACPI device itself, but I
> don't know if it is possible?

AFAIK it's not possible.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

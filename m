From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 08 Apr 2010 19:13:37 +0000
Subject: Re: [lm-sensors] lm-sensors on Asus CUSL2 motherboard
Message-Id: <g2p68676e01004081213ne8a7b69q22cb90009ef8c134@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <638607.35479.qm@web55607.mail.re4.yahoo.com>
In-Reply-To: <638607.35479.qm@web55607.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 8, 2010 at 7:29 PM, Lunar Cab <lunarcab@yahoo.com> wrote:
> thank you very much for your reply. Using your advice, I've got the following message from dmesg:
>
> [ 5321.294515] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts with ACPI region SM00 [0xe800-0xe806]
> [ 5321.294527] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
>
> So, as you suggested, I probably should enable asus_atk0110 driver. Could you please tell me how to do that?

modprobe asus_atk0110, but re-reading the original mail:

> > I cannot get any temperature readings from them in Ubuntu 9.10 Karmic Koala
> > (kernel 2.6.31-21-generic).

the module should be auto-loaded. The board is pretty old, it might
lack the ACPI hwmon interface. If nothing shows up even after manually
loading the driver please send me a copy of the DSDT.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

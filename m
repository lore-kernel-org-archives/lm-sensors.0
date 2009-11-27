From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 27 Nov 2009 13:59:12 +0000
Subject: Re: [lm-sensors] /sys/class/hwmon/ numbering
Message-Id: <68676e00911270559n7aabe731y9e4d2c1d09dc3000@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
In-Reply-To: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Nov 27, 2009 at 9:01 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Bonjour Charles,
> On Thu, 26 Nov 2009 09:14:45 +0100, Charles Pr=C3=A9vot wrote:
>> my motherboard is a Asus MN2 SLI DELUXE with AMD CPU
>> below some results:
[...]
> This will indirectly solve your problem, although probably not the way
> you would like: the asus_atk0110 driver doesn't offer manual fan speed
> control facilities, instead you must select the automatic fan speed
> control strategy in the BIOS.
>
> I'm not sure about the ACPI thermal zone, I thought Asus boards did not
> have one. Luca, ever seen this before? Is it OK to use both the ACPI
> thermal driver and the asus_atk0110 driver at the same time?

Yes. I already have the DSDT of that board; internally TZ and ATK both
use the same methods but the execution of the ACPI interpreter is
serialized so there's no chance of conflict.
On this particular board the it87 driver would interfere with TZ,
regardless of whether asus_atk0110 is loaded or not: better not load
it.
Charles, the BIOS supports Q-FAN; in the DSDT I don't see the
profiles, but a "Q-Fan Ratio". Check the manual (and the BIOS itself).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

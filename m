From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 17 Dec 2009 13:38:58 +0000
Subject: Re: [lm-sensors] ATK0110 breaks keyboard and mouse on asus p7p55d -
Message-Id: <68676e00912170538k4c3c8454y15ba7ef2da29ee21@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
In-Reply-To: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 17, 2009 at 12:43 AM,  <comsublant@gmx.net> wrote:
> On Wed, Dec 16, 2009 at 03:05:16PM +0100, Luca Tettamanti wrote:
>> I have a report of a working P7P55D (plain) with BIOS 0711; the DSDT
>> of the working board is very different from yours. Can you try and
>> upgrade the BIOS?
>
> I upgraded the bios to 1207.
> First i was like "yay", but then again, this time after appr. 30
> minutes, same error again. Machine still runs, keyboard and mouse
> locked up.
> Made intense memory checks, checked my bios settings over and over.
> Disabling the atk0110 driver, it's stable.
> Other thing. The 30 minutes with enabled sensors, i noticed the cpu
> temp was way too low, like 20 degrees C. In the bios hw monitor this
> is usually around 45 degrees Celsius.
> Is that something i have to set like for those old lm78/wd* chips?

No, the conversion/scaling is done by the ACPI interface.
I really don't know what's going on here... do you have Windows
installed? If so, does Asus monitoring app work?
At this point the only advice I can give you is to avoid asus_atk0110
driver and use the native one.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

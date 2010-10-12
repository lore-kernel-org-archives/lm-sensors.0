From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 12 Oct 2010 11:37:04 +0000
Subject: Re: [lm-sensors] IT8721F/IT8758E support
Message-Id: <AANLkTimQu7ip4h9-zPFF+x7LYyfCYL9NM+iRdTd_+8Zj@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101011221911.38c8a3d7@endymion.delvare>
In-Reply-To: <20101011221911.38c8a3d7@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 12, 2010 at 11:31 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> If you can it would probably be a solution to recommend using this module for asus-owners in general.
>
> The problem is that not all Asus board use that driver. Old Asus boards
> don't have the ATK0110 virtual drivers, some more recent boards do have
> it but it isn't usable, and server boards need native drivers instead of
> ACPI.

This issue came up before, the main problem is that to reliably
identify ATK0110 you need an ACPI disassembler in user space (i.e.
iasl). OTHO atk0110 driver is loaded automagically and does not need
any configuration... so I guess that the problem with sensors-detect
is only for users that build a custom kernel; in this case a
suggestion based on DMI entries may be enough.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

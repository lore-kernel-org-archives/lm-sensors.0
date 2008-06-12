From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Thu, 12 Jun 2008 22:56:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <76366b180806121556j1165def5t987ce51beee7f4c1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 12, 2008 at 3:53 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Andrew,
>
> On Sun, 24 Feb 2008 16:43:35 +0100, Jean Delvare wrote:
>> On Mon, 11 Feb 2008 01:32:59 -0500, Andrew Paprocki wrote:
>> > This splits the it8712 chip type into two chip types to distinguish the
>> > changes made in rev 8 of the chip. A new type it8712old represents all
>> > revs prior to rev 8. The it8712 chip type now represents rev 8 and
>> > greater.
>>
>> I am not fond of the "it8712old" name, because "old" doesn't tell the
>> reader in which way it is different from the (new) it8712 type. It also
>> doesn't "scale" well... What will you do if the next IT8712F revision
>> differs from rev. K in a new way?
>>
>> I would prefer a separate field in struct it87_sio_data and struct
>> it87_data, recording the revision value. This is reusable for future
>> differences between the various revisions of all supported chips. This
>> approach is also less likely to break the current code.
>>
>> As a side note, I think it's rather weird that the IT8712F rev. J (and
>> later) do default to 8-bit fan speed values while they no longer
>> support fan clock dividers. As these revisions of the chip are not
>> backward compatible with the older revisions, ITE should really have
>> switched to a saner default.
>> (...)
>
> Any update for this patch, addressing the points I raised in my review?
> Apparently we have another user who needs this (Cc'd.)

Sorry for the delay. I got sidetracked and haven't booted up this
hardware in a little while. I'll try to revisit this week and re-post.

-Andrew

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

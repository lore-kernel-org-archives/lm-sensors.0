From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 11 Dec 2009 20:44:38 +0000
Subject: Re: [lm-sensors] ATK0110 breaks keyboard and mouse on asus p7p55d -
Message-Id: <68676e00912111244l5d4ac15y336a8f9ce6f70e68@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
In-Reply-To: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 11, 2009 at 7:03 PM,  <comsublant@gmx.net> wrote:
> On Fri, Dec 11, 2009 at 02:04:52PM +0100, Luca Tettamanti wrote:
>> It's very strange since I had a tester that helped my with the very same board.
>
> This might be mistakable: this is a pure p7p55d, not -premium or
> something.

I have a report of a working "pro" board, shouldn't change much, at
least as far as the ACPI interface is concerned.

>> What kind of keyboard/mouse are you using? PS2 or USB?
>
> PS2
>
>> Can you access the machine remotely (ssh)? If so, please send me a
>> dump of /proc/interrupts _after_ the keyboard becomes unresponsive.
>
> no remote access at the moment :(

Ok, does it respond to the power button? A clean shutdown may help to
preserve something interesting in the logs.

>> Ok, the only difference between working and non-working is the atk0110 driver?
>
> yes
>
>> Locate atk_ec_present function in asus_atk0110.c; put a
>>
>> return 0;
>> as first instruction; recompile and see if it still locks up the keyboard.
>> Also enable HWMON_DEBUG_CHIP.
>
> done.
> its not locking up anymore,
[...]
> its not changing though.

This is expected, since the EC is responsible of updating the values.
The behaviour that you describe seems to indicate a runaway interrupt
(possibly from the EC).
Please send me a copy of the DSDT (/sys/firmware/acpi/tables/DSDT) and
the output of lspci -vn

thanks,
Luca
PS: don't strip the CC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

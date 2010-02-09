From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 09 Feb 2010 16:15:48 +0000
Subject: Re: [lm-sensors] ATK0110 breaks keyboard and mouse on asus p7p55d -
Message-Id: <68676e01002090815m200ba8cbu93e235c408c9f3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
In-Reply-To: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 8, 2010 at 11:31 AM, Michael Dreher
<michael.dreher@uni-konstanz.de> wrote:
> Hello Luca,
>
> by googling I found this discussion on the sensors-mailinglist
> (so maybe some CC: are lost), and I observe the same problem (comments below)
>
>
>>On Fri, Dec 11, 2009 at 7:03 PM,  <comsublant <at> gmx.net> wrote:
>>> On Fri, Dec 11, 2009 at 02:04:52PM +0100, Luca Tettamanti wrote:
>>>> It's very strange since I had a tester that helped my with the very same
>>>> board.
>>>
>>> This might be mistakable: this is a pure p7p55d, not -premium or
>>> something.
>>
>> I have a report of a working "pro" board, shouldn't change much, at
>> least as far as the ACPI interface is concerned.
>>
>>>> What kind of keyboard/mouse are you using? PS2 or USB?
>>>
>>> PS2
>>>
>>>> Can you access the machine remotely (ssh)? If so, please send me a
>>>> dump of /proc/interrupts _after_ the keyboard becomes unresponsive.
>>>
>>> no remote access at the moment :(
>>
>> Ok, does it respond to the power button? A clean shutdown may help to
>> preserve something interesting in the logs.
>>
>>>> Ok, the only difference between working and non-working is the
>>>> atk0110 driver?
>>>
>>> yes
[...]
> in my situation: just a few minutes into a KDE session (doing nothing
> extraordinary) first the mouse becomes unresponsive, and about 15 seconds
> later also the keyboard (toggling num-lock does nothing). Both are connected
> via PS. This has happened with 2.6.33-rc5 and rc6 as taken from the opensuse
> repository. I was thinking that maybe the X-server is doing something wrong,
> and for both kernels, I had renamed the module "nouveau.ko" to something else
> (and also the libdrmnouveau files), and the error has not yet come back (but
> I need more testing).
> I don't know how this is related to the atk0110, but at least sensors-detect
> finds some i2-c devices on the nvidia card (and can not do much with them).

atk0110 doesn't touch the bus directly, so there's no chance that it
could mess with the nVidia card.
Two things:
- are you positive that removing atk0110 fixes the problem?
- does it happen without X (i.e. from console)?

> My board is a P7P55D, and I also obtain these deep temperatures:
>
> [...]
> CPU Temperature: +32.5°C (high = +45.0°C, crit = +45.5°C)
>  MB Temperature: +31.0°C (high = +45.0°C, crit = +46.0°C)
> [...]
>
> Is there a chance to change the "high" and "crit" values to something higher ?
> Because the chassis fan is extremely loud ...

Nope; the values are set by the BIOS. Fan speed is also controlled by
the BIOS (Q-FAN), try setting a different profile (like "Silent").

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

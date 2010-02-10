From: Michael Dreher <michael.dreher@uni-konstanz.de>
Date: Wed, 10 Feb 2010 18:57:24 +0000
Subject: Re: [lm-sensors] ATK0110 breaks keyboard and mouse on asus p7p55d -
Message-Id: <201002101957.24229.michael.dreher@uni-konstanz.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
In-Reply-To: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Am Dienstag, 9. Februar 2010 17:15 schrieb Luca Tettamanti:
>>>>> Ok, the only difference between working and non-working is the
>>>>> atk0110 driver?
>>>>
>>>> yes
>
> [...]
>
>> in my situation: just a few minutes into a KDE session (doing nothing
>> extraordinary) first the mouse becomes unresponsive, and about 15 seconds
>> later also the keyboard (toggling num-lock does nothing). Both are
>> connected via PS. This has happened with 2.6.33-rc5 and rc6 as taken from
>> the opensuse repository. I was thinking that maybe the X-server is doing
>> something wrong, and for both kernels, I had renamed the module
>> "nouveau.ko" to something else (and also the libdrmnouveau files), and
>> the error has not yet come back (but I need more testing).
>> I don't know how this is related to the atk0110, but at least
>> sensors-detect finds some i2-c devices on the nvidia card (and can not do
>> much with them).
>
> atk0110 doesn't touch the bus directly, so there's no chance that it
> could mess with the nVidia card.
> Two things:
> - are you positive that removing atk0110 fixes the problem?
> - does it happen without X (i.e. from console)?

testing still goes on, and the results up to now are:
* with nouveau loaded, but atk0110 removed: lockup of keyboard and mouse,
  easily reproducible
* without noveau, but atk0110 loaded: lockup with same symptoms, but 
  harder to reproduce

> > My board is a P7P55D, and I also obtain these deep temperatures:
> >
> > [...]
> > CPU Temperature: +32.5°C (high = +45.0°C, crit = +45.5°C)
> >  MB Temperature: +31.0°C (high = +45.0°C, crit = +46.0°C)
> > [...]
> >
> > Is there a chance to change the "high" and "crit" values to something
> > higher ? Because the chassis fan is extremely loud ...
>
> Nope; the values are set by the BIOS. Fan speed is also controlled by
> the BIOS (Q-FAN), try setting a different profile (like "Silent").

well, I have already chosen "Silent" (and I hear no difference). 
And Windows 7 somehow can control the fans/sensors directly, bringing
the noise down to a much lower level ...


thanks,
Michael


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

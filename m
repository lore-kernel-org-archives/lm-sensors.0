From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Fri, 06 Apr 2012 08:28:58 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016eGpohxaxwPV8=NpvYyRZ9fxjLOkAOY+BfpL7sWYqwC-Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2012/4/6 Jean Delvare <khali@linux-fr.org>:
> Sorry for the late reply, I have a lot of work this week.

It is ok, take your time:)

> I presume you do not remember which ones defaulted to "no" and you had
> to say "yes" explicitly?

Yes, that is what I did.

> It's strange, I do see it in mine with the radeon driver:
> Maybe there is a verbosity level to set somewhere, my X server is
> started with -verbose, maybe you have to do the same. Or

I stopped X and gave "exec /usr/bin/X -nolisten tcp "$@" -verbose 20
2> /tmp/startx.log" command but still there is no dump of EDID.

> Good, so at least we have a reference. Now we need to find out which
> bytes in your own EDID have been altered.
> You also have to offset the 3 other vertical timings:
> $ xrandr --newmode "try" 68.94 1280 1296 1344 1408 800 801 804 816 -HSync -VSync

Now I get what you wanted me to do. I tried the command above but
resolution looks bad. Icons, fonts etc. looks blur and bigger.

> That's because you have loaded the eeprom driver. Either provide the
> contents of file /sys/bus/i2c/devices/i2c-2/2-0050/eeprom or unload the
> eeprom driver and provide the output of the i2cdump command above.

Sorry, my mistake. This is the output: http://pastebin.com/aSUSR7wX

Best regards,
Numan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

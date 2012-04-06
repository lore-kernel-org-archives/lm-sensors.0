From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Fri, 06 Apr 2012 17:13:07 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016d8kRYD73C3UcJ_c2U2fNdNqP7+ok-_boNKWzCfUBN-rw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> What did the i2cdump outputs look like? Did you see the offending
> offset values change from 0xff to the values you passed on the command
> line?
> Did you try i2cdump again after rebooting, to make sure the writes
> stuck?

Yes, I saw them changed and after rebooted I gave commands again.
Last i2cdump output: http://pastebin.com/pyC0j5ug
It seems that some values returned ff again.

> Did you only reboot the machine? Please try cold booting it, even
> remove the battery and unplug the power cord for 10 minutes if needed.
> Maybe the BIOS only reads the EDID once at cold boot.

I had just rebooted machine but now I did cold boot by removing
battery and unpluging power cord.

> BTW, when the problem happened originally, did it happen while
> sensors-detect was running, or after next reboot, or after next cold
> boot?

After next cold boot, the problem happaned. When sensors-detect
finished, I hust read some .pdf files then shut the computer down. The
next boot was after about 8 hours later.

Best regards,
Numan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

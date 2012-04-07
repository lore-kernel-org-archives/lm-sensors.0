From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Sat, 07 Apr 2012 12:21:53 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016dWkvK_2B6rFE2-fOz=T+mpzs=ABG-M=wb3YNyKdmBnjQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i2c-2 is precisely the I2C bus where your EDID is and where the problem
> happened. AFAIK hw_i2c is off by default, so please check why and how
> it was enabled. Then you may try to turn if off to force software
> operation of the I2C bus (i2cdetect -l should show that), and then do
> the i2cset commands again and see if it works. Again my hope level is
> low but I think it is worth trying.
>
> --
> Jean Delvare

modinfo -p radeon shows that:
hw_i2c:hw i2c engine enable (0 = disable) (int)

So I wrote radeon_hw_i2c=0 to grub command line, then gave the i2cset
commands, but it did not work. I also tried radeon.modeset=0 to find
out whether the culprit radeon's itself, this also did not work.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

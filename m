From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Sat, 07 Apr 2012 17:25:49 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016c1Spe3q=uN-Cf=78+18Nr_+TJ-iHg3thhPTPKOm146+g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I hope you did not do that but rather radeon.hw_i2c=0. Did you check
> with "i2cdetect -l" that hw_i2c wasn't used?

I actually wrote radeon.hw_i2c=0 but wrote wrongly in e-mail.
Although I used redeon.hw_i2c=0 oarameter, i2cdetect -l shows

i2c-2	i2c       	Radeon i2c hw bus MM_I2C        	I2C adapter

I read xorg.0.log and dmesg.log to check that whether radeon.hw_i2c=0
works or not, there was not any lien that complaining radeon.hw_i2c=0
was not working. So I presumed it worked.

> Meanwhile I found a post from someone who had the same problem:
> http://lists.freedesktop.org/archives/xorg/2011-January/052239.html
>
> This would confirm that sensors-detect was only the trigger rather than
> the root cause of the corruption. I'll talk to the radeon driver
> maintainer on Tuesday.
>
> --
> Jean Delvare

Thank you Jean, I appreciate your help.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Tue, 10 Apr 2012 16:53:22 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016dJrWMtRfrXuM21u9EJ7wn7a1Jr7D4OJdnwGt+jmOwcLA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Scratch this, I discussed with Alex Deucher and he explained that there
> is no possibility to access the MM i2c bus with software bit-banging,
> the hardware engine is the only way to go and this is why the hw_i2c
> option has no effect on this bus.
>
> Unfortunately he didn't have any explanation for what happened. All he
> could suggest was that maybe some EEPROM cells went dead when the
> problem happened, and that's why we can't write the proper values back.
> This is indeed a possibility, which unfortunately means there's nothing
> we can do to restore your EDID. Sorry :(
>
> --
> Jean Delvare

Hi Jean,

If that is the case, I will try to get use to use laptop in the
current condition.

I thank you very much for all of your effort and help.

Yours sincerely,
Numan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

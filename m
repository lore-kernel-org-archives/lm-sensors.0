From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Sat, 07 Apr 2012 19:05:49 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016e3n+=gHt32noDdzkQZM3UA-DWjJoKvn8CdVghXjV0+nw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You can check the value of /sys/module/radeon/parameters/hw_i2c.
> Jean Delvare

cat /sys/module/radeon/parameters/hw_i2c
0
So it works. Thank you.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

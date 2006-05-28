From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 28 May 2006 11:56:56 +0000
Subject: [lm-sensors] vt1211 patch
Message-Id: <191fb4ca0605280456w2a113co25b67dc8645bc8c7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
In-Reply-To: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tried your instructions, but nothing seems to happen:
>
> | # cat pwm?_enable
> | 2
> | 2
> |
> | # cat pwm?_auto_point4_temp
> | 255000
> | 255000

Ok, so good so far.

> BTW that value seems the max I can set it to

yes, the register saturates at 255 which gets multiplied by 1000 by the driver.

> sensors shows:
>
> | CPU:      3105 RPM  (min =    0 RPM, div = 2)

what does 'cat pwm?' show?

...juerg


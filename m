From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 16 Sep 2008 22:30:15 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: Add script for manual control
Message-Id: <191fb4ca0809161530i352528a6xa207f09e5becdc75@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0807231020pe333553t4e94e4c77530b10d@mail.gmail.com>
In-Reply-To: <191fb4ca0807231020pe333553t4e94e4c77530b10d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was wondering what happened to this patch? I don't think it made it
in. Is there a problem with it?

Thanks
...juerg


On Wed, Jul 23, 2008 at 10:20 AM, Juerg Haefliger <juergh@gmail.com> wrote:
> Add a script that provides manual control of the vt1211 PWM outputs.
> This script puts the vt1211 in automatic PWM mode and fools the chip
> into believing that there is a temp change to force the PWM outputs to
> specified values. This is necessary since the standard manual mode of
> the vt1211 doesn't seem to work.
>
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

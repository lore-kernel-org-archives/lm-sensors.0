From: David Jander <david.jander@protonic.nl>
Date: Tue, 27 Sep 2011 09:06:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/mc13xxx-adc: add support for the
Message-Id: <20110927110610.53b35235@archvile>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Sep 2011 10:12:32 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> 
> > Yes, but from the filename you'd already have a hint. If you only know
> > mc13892 and don't know that the mc13783 is an almost compatible part,
> > you'd never find the former was already supported.
> 
> When looking for suitable drivers, 'grep' is a way better friend than
> 'find' :)

Can you easily 'grep' on git-web? :-)
... I may be a noob, but that's usually where I start to look for support of a
particular chip when I don't happen to have a local clone of that git repo.
Being a mainline-minded hardware developer, I do this fairly often ;-)

> > OTOH, I know that many other drivers tend to have names reflecting the
> > first supported model of a family, so that is usual practice.
> 
> Yes, otherwise drivers/rtc/rtc-ds1307 would be rtc-xxxxxx.c these days.
> Also, using those 'x' tends to create conflicts like 30cb35b
> ("leds-pca9532.c: change driver name to be unique"). Spoiled history for
> git blame is another drawback.

I agree. That's why I hadn't changed the filename myself in the original patch.
I consider file-renames/moves as a PITA when searching git logs and trying to
track changes. There might be powerful git-fu these days to do it (done it
myself), but IMHO it still hurts too much.

Best regards,

-- 
David Jander
Protonic Holland.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Konstantin Kletschke <konsti@ku-gbr.de>
Date: Mon, 29 Jun 2009 08:44:38 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090629084438.GE19175@punzenstreichler.doom>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After a delay, hello again!

Am 2009-06-25 10:31 +0200 schrieb Jean Delvare:

> > This reflects somehow how echo into the /sys filesystem reacts.
> 
> Indeed. So this is not a bug in the driver, but rather the hardware
> misbehaving. I'll ask out contact at Nuvoton about this.

That would be very interesting. Do you know if I could also get a
datasheet from them for this chip? I read stuff of NDA or so (which
shuold be no Problem to sign).
I don't know whome they give one and
to whome not Since I am not unexperienced fiddling out such stuff this
is bad with me sitting here with nothing. 

> Support for the W83667HG is still relatively new. Officially this chip

Indeed, because of that I poked in here to play with it. Or is W83667HG-A
a special revision behavin different?

> is only supported since kernel 2.6.30 which was released just 2 weeks
> ago. So we didn't have much feedback yet.

:-) Here it is.

> Could as well be that the chip has a silicon bug...

That would be a mess!

Kind Regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

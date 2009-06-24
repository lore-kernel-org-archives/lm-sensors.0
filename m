From: Konstantin Kletschke <konsti@ku-gbr.de>
Date: Wed, 24 Jun 2009 13:44:50 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090624134450.GD16923@punzenstreichler.doom>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 2009-06-24 14:53 +0200 schrieb Jean Delvare:

> The usual way to counter no_clobber is >|, not >>.

I indeed did not knew this, thanks! :)

> Would you be able and willing to apply a patch to your kernel and
> rebuild it, if I come up with something?

Yes of course. I am quite firm even with this i2c stuff and kernel
programming (and watching running or dying when running :-)).

Also I know how things go in developing drivers (or a family of them)
and nobody has the entrire different hardware under his desk. So I have
this onw under my desk and fun in doing whatever you want to it :-)

> This is all very confusing, I admit. I would like you to unload the
> w83627ehf driver and try to read from / write to the chip directly. For
> this you'll need the isadump and isaset tools (part of lm-sensors.)

I will get my hand on these and report.

Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

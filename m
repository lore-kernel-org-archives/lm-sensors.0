From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 05 Jul 2009 11:41:44 +0000
Subject: Re: [lm-sensors] MINSTART has no effect in fancontrol
Message-Id: <20090705134144.3db41b27@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4FFD5F.6060508@gmail.com>
In-Reply-To: <4A4FFD5F.6060508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bal=E1zs,

On Sun, 05 Jul 2009 03:09:51 +0200, H=E1morszky Bal=E1zs wrote:
> In fancontrol MINSTART has no effect (it has, but only for an INTERVAL=20
> period of time).
> The line:
> pwmval=3D"(${tval}-${mint})*(${maxpwm}-${minso})/(${maxt}-${mint})+${mins=
o}"
> should be:
> pwmval=3D"(${tval}-${mint})*(${maxpwm}-${minsa})/(${maxt}-${mint})+${mins=
a}"
> if I understand the configuration options of fancontrol right.

I guess you don't. The formula above is perfectly correct. With your
proposed change, MINSTART would be used instead of MINSTOP for the
speed computations, which is definitely not what we want.

> At the current state, pwmval can be lower than MINSTART

Of course it can, by design. But it can't be lower than MINPWM. I
suggest you read the fancontrol documentation:
  http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/fancontrol.txt
and in particular the graph. You'll see that MINSTART is _not_ used to
compute the fan speed. MINSTART is only used for the initial pulse to
get a fan spinning.

> (so on some temperatures, greater than MINTEMP, the fan won't start).

It should, if your settings are correct. Maybe you have set either
MINSTART or MINSTOP too low for your fan.

That being said, it could be that the MINSTART pulse of 1 second is a
tad too short for some fans. If this is your case then you could
increase the sleep value from 1 to 2 or 3 and see if it helps.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

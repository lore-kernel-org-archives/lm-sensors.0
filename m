From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Date: Tue, 10 Nov 2009 13:42:45 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <4AF96DD5.9090001@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Op 10-11-09 14:31, Daniel Mack schreef:
> Does the change to the min/max parameters to input_set_abs_params()
> also reflect the factor in which the multiplication factor alters?
> 
> In other words: If I scale the read value to the full range reported by
> the input device - will I still get the same value before and after the
> change? If that's the case, I guess the 'breakage' would be acceptable.
So your question is whether this changes the values of the joystick
interface, right? I haven't tested the patch, so Samu could probably
better answer, but looking at the code and with what I know about the
joystick subsystem, it shouldn't as the values are always scaled between
-32000 and 32000 (approximately).

[thinking further....]

So not only this means it's not going to break applications using only
the joystick interface, it also means that the whole business of scaling
the raw values for the joystick subsystem in the patch is completely
useless. Scaling to mG should be done only for the sysfs interface.

Samu, could you confirm my understanding, and fix the patch if necessary?

Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 15 Nov 2009 18:04:56 +0000
Subject: Re: [lm-sensors] [PATCH v2 09/10] lis3: Scale output values to mg
Message-Id: <20091115180456.GA21469@atrey.karlin.mff.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-3-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-4-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-5-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-6-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-7-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-8-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-9-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-10-git-send-email-samu.p.onkalo@nokia.com> <4B001EF2.2090605@tremplin-utc.net>
In-Reply-To: <4B001EF2.2090605@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?iso-8859-2?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, daniel@caiaq.de, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

> Op 10-11-09 13:41, Samu Onkalo schreef:
> > Report output values as 1/1000 of earth gravity.
> After the discussion started by Daniel, I'm willing to accept this patch
> "as is", just with a better log explaining why it's ok to break
> userspace ABI:
>  * the sysfs "position" attribute was never safe to be read as it could
> have different scales depending on the underlying hardware. It's now
> featuring a consistent scale, which is more or less identical to the one
> used by the 12-bits sensors
>  * the joystick interface reports the same values as before, excepted of
> course if "raw" values are requested, in which case the same remark as
> for "position" applies.

agreed.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

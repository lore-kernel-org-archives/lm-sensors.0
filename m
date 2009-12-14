From: Matt Hsu <matt@0xlab.org>
Date: Mon, 14 Dec 2009 03:57:23 +0000
Subject: Re: [lm-sensors] Duplicated driver for LIS302-like device.
Message-Id: <4B25B7A3.6080607@0xlab.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B21B40B.2010007@0xlab.org> <4B2241D0.3050504@cam.ac.uk>
	<4B224641.8050905@tremplin-utc.net>
In-Reply-To: <4B224641.8050905@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, dmitry.torokhov@gmail.com, LM Sensors <lm-sensors@lm-sensors.org>, linux-input@vger.kernel.org


> Hopefully, what you need is already there. Well, of course it depends
> also on what interface you need in userspace for the hardware. 
    Hi Eric,

    I poked series patches you mentioned above.
    These patches add the support of both interface.
    That's great work. Originally, it was my next TODO, integration both 
interfaces.

    Btw, here is the demo for this device. Just FYI.

    
http://matthsu-abacus.blogspot.com/2009/12/motion-sensor-demo-on-beagleboard.html

    I will cherry pick the upstream patches when they are merged into 
2.6.33.

    Cheers,
    Matt
> There is
> currently only position reporting (via joystick interface and sysfs
> file), freefall detection (via a misc device) and selftest (via sysfs
> file). Let me know if you have additional features in your
> implementation, or some bug fixes, and we could incorporate them in the
> lis3lv02d driver.
>
> See you,
> Eric
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

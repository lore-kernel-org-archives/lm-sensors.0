From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: emc6d102 support
Message-Id: <pmJ9bZye.1112170073.2714890.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rafael,

> A minimal patch is attached, but I am not sure about the "template_used = 
> 0"...

Looks OK to me, will apply tonight.

> It seems to be possible to port the support for the extended precision
> since the ADM1027 has support for it. I could do it if there is some
> interest in it. But I am a bit short of time so I can work only during the
> weekend. By the way, sorry for the delay in answering.

No problem. Adding support for the extended precision can be done anytime
later, and actually it might be preferable to postpone it until after
lm_sensors 2.9.1 is released.

What I was minly interested in was that the emc6d102 itself was
recognized by the lm_sensors driver, because the Linux 2.6 driver and
sensors-detect now know about it and it's quite confusing for the user
when suggested to load a driver for his/her chip, and the driver then
doesn't seem to support that chip.

Thanks,
--
Jean Delvare

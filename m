From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Date: Fri, 09 Apr 2010 13:29:53 +0000
Subject: Re: [lm-sensors] [PATCH] lis3lv02d: provide means to disable polled
Message-Id: <4BBF2BD1.5050107@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LNX.2.00.1004091453530.8345@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1004091453530.8345@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Samu Onkalo <samu.p.onkalo@nokia.com>, Pavel Machek <pavel@ucw.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Marcin Derlukiewicz <marcin@derlukiewicz.pl>

On 09/04/10 14:56, Jiri Kosina wrote:
> lis3lv02d driver creates emulated joystick interface for events reported 
> by the sensor.
> Because of HW, this has to be implemented as polled input device, with
> 20Hz frequency.
> 
> This is reported to create 20% CPU usage increase (and proportionaly higher
> power consumption) just for the ipolldevd kernel thread (which is used
> to read the sensor).
> 
> As most users probably only use the freefall functionality of the driver
> and not the joystick interface, provide means for disabling the registration
> of joystick device altogether via module parameter.
> (I'd rather make it default to 0, but this will break backwards compatibility).
Are you saying there is a 20% CPU usage even when the joystick interface
is not open? This should not happen (and this is not happening on my
laptop). The polling should happen only when a userspace app opens the
joystick interface (like running neverball).

So I'd tend to think it's more due to a misconfiguration of the system
(like xserver using the joystick interface as a pointer device) or it's
a bug in the way we set up the polling. Could you investigate and let me
know?

Cheers,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

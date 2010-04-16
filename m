From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Fri, 16 Apr 2010 12:06:37 +0000
Subject: Re: [lm-sensors] [PATCH] lis3lv02d: provide means to disable polled
Message-Id: <4BC852CD.40406@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LNX.2.00.1004091453530.8345@pobox.suse.cz> <4BBF2BD1.5050107@tremplin-utc.net> <alpine.LNX.2.00.1004091532150.8345@pobox.suse.cz> <op.va86rulwgp7y00@linux-r26l.site>
In-Reply-To: <op.va86rulwgp7y00@linux-r26l.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcin Derlukiewicz <marcin@derlukiewicz.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Samu Onkalo <samu.p.onkalo@nokia.com>, Pavel Machek <pavel@ucw.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 16/04/10 13:41, Marcin Derlukiewicz wrote:
:
> sorry for the delay, had a crunch time
> 
> here is the link for this lsof:
> https://bugzilla.novell.com/attachment.cgi?id54953
So apparently, it's opened by mplayer. Indeed, by default mplayer always
opens the first joystick device, because some people like to  control a
movie with a joystick.

I don't think much can be done from the kernel point of view. Maybe
there are even people who enjoy controlling their movies by moving their
laptop! Here, my ~/.mplayer/config looks like:
[default]
input=js-dev=/dev/input/js8

You could also put a udev rule to change the name of this joystick to
something like js1.

All I could think of in the kernel side to improve this situation would
be to give more information about joystick devices, and define a subtype
"accelerometer", which mplayer could avoid selecting by default. I don't
know enough the input interface to know if this already exists...

See you,
Eric


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

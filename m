From: Henrik Rydberg <rydberg@euromail.se>
Date: Mon, 24 Aug 2009 21:49:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: applesmc: restore keyboard
Message-Id: <4A930AE0.2070007@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1250976832-9801-1-git-send-email-rydberg@euromail.se> <20090824140717.e7011b8c.akpm@linux-foundation.org>
In-Reply-To: <20090824140717.e7011b8c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nicolas@boichat.ch, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 22 Aug 2009 23:33:52 +0200
> "Henrik Rydberg" <rydberg@euromail.se> wrote:
> 
>> On resume from suspend, the driver currently resets the logical
>> state as if it was brought up from halt. This patch uses the
>> dev_pm_ops.resume method to synchronize the hardware with the
>> memorized logical state, bringing back the backlight to the level
>> prior to suspend.
> 
> What are the runtime effects of this change?

The patch has zero impact on a running system, only suspend/resume
behavior is affected.

Precondition: Suspend computer with keyboard backlight brightness
greater than zero.

Before patch: On resume, the backlight stays off.

After patch: On resume, the backlight is set to the brightness prior to
suspend.

There is one side-effect of the patch: the accelerometer no longer
re-calibrates on resume, but keeps the calibration from before suspend.
I consider this a good change, but it is after all a change.

Henrik


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

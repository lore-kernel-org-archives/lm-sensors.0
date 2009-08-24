From: Henrik Rydberg <rydberg@bitmath.org>
Date: Mon, 24 Aug 2009 23:37:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: applesmc: restore keyboard
Message-Id: <4A932456.9000500@bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1250976832-9801-1-git-send-email-rydberg@euromail.se> <20090824140717.e7011b8c.akpm@linux-foundation.org>
In-Reply-To: <20090824140717.e7011b8c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, nicolas@boichat.ch, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

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
> 

My apologies, the patch has two flaws.

1) For macbook models without keyboard backlight, the resume function
will fail internally, presumably resulting in a small unnecessary delay.

2) The accelerometer does not reset properly after hibernation.

Please drop this patch from -mm, I am sending a corrected patch
with a slightly different title. Sorry about this.

Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

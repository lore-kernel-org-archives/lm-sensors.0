From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 24 Aug 2009 21:07:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: applesmc: restore keyboard
Message-Id: <20090824140717.e7011b8c.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1250976832-9801-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1250976832-9801-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: nicolas@boichat.ch, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, rydberg@euromail.se

On Sat, 22 Aug 2009 23:33:52 +0200
"Henrik Rydberg" <rydberg@euromail.se> wrote:

> On resume from suspend, the driver currently resets the logical
> state as if it was brought up from halt. This patch uses the
> dev_pm_ops.resume method to synchronize the hardware with the
> memorized logical state, bringing back the backlight to the level
> prior to suspend.

What are the runtime effects of this change?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

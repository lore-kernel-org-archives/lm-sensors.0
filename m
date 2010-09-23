From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 23 Sep 2010 19:43:13 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Add support for new LIS3DC /
Message-Id: <20100923124313.7794e8f6.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5hd3s5nglg.wl%tiwai@suse.de>
In-Reply-To: <s5hd3s5nglg.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, =?ISO-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, 23 Sep 2010 08:01:31 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> A new version of LIS3 chip has slight incompatibilities from former
> versions.  This patch adds the minimal support for it.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2
>   Rebased to patch "lis3: Fix Oops with NULL platform data (v2)"
> 

Wait.  I did my own rebasing and came up with a different patch, with
two extra hunks:

@@ -301,8 +311,9 @@ static irqreturn_t lis302dl_interrupt(in
 	wake_up_interruptible(&lis3_dev.misc_wait);
 	kill_fasync(&lis3_dev.async_queue, SIGIO, POLL_IN);
 out:
-	if (lis3_dev.pdata && lis3_dev.whoami = WAI_8B && lis3_dev.idev &&
-	    lis3_dev.idev->input->users)
+	if (lis3_dev.pdata &&
+		(lis3_dev.whoami = WAI_8B || lis3_dev.whoami = WAI_3DC) &&
+		lis3_dev.idev && lis3_dev.idev->input->users)
 		return IRQ_WAKE_THREAD;
 	return IRQ_HANDLED;
 }

and

@@ -742,7 +762,7 @@ int lis3lv02d_init_device(struct lis3lv0
 	 * io-apic is not configurable (and generates a warning) but I keep it
 	 * in case of support for other hardware.
 	 */
-	if (dev->pdata && dev->whoami = WAI_8B)
+	if (dev->pdata && (dev->whoami = WAI_8B || dev->whoami = WAI_3DC))
 		thread_fn = lis302dl_interrupt_thread1_8b;
 	else
 		thread_fn = NULL;


Did you drop those changes deliberately?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

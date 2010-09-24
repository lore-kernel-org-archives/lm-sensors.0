From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 24 Sep 2010 14:14:26 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <s5hlj6r1b5p.wl%tiwai@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>
	<20100924135802.GA18109@ericsson.com>
In-Reply-To: <20100924135802.GA18109@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Samu Onkalo <samu.p.onkalo@nokia.com>, =?UTF-8?B?w4lyaWM=?= Piel <Eric.Piel@tremplin-utc.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

At Fri, 24 Sep 2010 06:58:02 -0700,
Guenter Roeck wrote:
> 
> On Thu, Sep 23, 2010 at 01:58:33AM -0400, Takashi Iwai wrote:
> > The recent addition of threaded irq handler causes a NULL dereference
> > when used with hp_accel driver, which has NULL pdata.
> > 
> > Acked-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> > Acked-by: Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: <stable@kernel.org>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Applied.

Oh, does this driver belong to hwmon tree?
Jean told me that this isn't managed in hwmon, so I had an impression
that it's an orphan driver.


thanks,

Takashi

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

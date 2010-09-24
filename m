From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Sep 2010 13:58:02 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <20100924135802.GA18109@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>
In-Reply-To: <s5heiclngqe.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Samu Onkalo <samu.p.onkalo@nokia.com>, =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Sep 23, 2010 at 01:58:33AM -0400, Takashi Iwai wrote:
> The recent addition of threaded irq handler causes a NULL dereference
> when used with hp_accel driver, which has NULL pdata.
> 
> Acked-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> Acked-by: Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: <stable@kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

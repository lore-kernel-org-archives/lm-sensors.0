From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Sep 2010 15:17:59 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <20100924151759.GC18153@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>
 <20100924135802.GA18109@ericsson.com>
 <s5hlj6r1b5p.wl%tiwai@suse.de>
 <20100924163005.7704f63e@endymion.delvare>
 <4C9CBF4E.7080200@cam.ac.uk>
In-Reply-To: <4C9CBF4E.7080200@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Sep 24, 2010 at 11:10:06AM -0400, Jonathan Cameron wrote:
[...]
> Technically hwmon is orphan (according to MAINTAINERS.) But that's not to

If you pull the latest tree, you'll notice that this is no longer correct.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

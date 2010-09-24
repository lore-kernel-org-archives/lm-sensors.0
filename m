From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 24 Sep 2010 17:07:34 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <4C9CDAD6.6080605@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de> <20100924135802.GA18109@ericsson.com> <s5hlj6r1b5p.wl%tiwai@suse.de> <20100924163005.7704f63e@endymion.delvare> <4C9CBF4E.7080200@cam.ac.uk> <20100924151759.GC18153@ericsson.com>
In-Reply-To: <20100924151759.GC18153@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 09/24/10 16:17, Guenter Roeck wrote:
> On Fri, Sep 24, 2010 at 11:10:06AM -0400, Jonathan Cameron wrote:
> [...]
>> Technically hwmon is orphan (according to MAINTAINERS.) But that's not to
> 
> If you pull the latest tree, you'll notice that this is no longer correct.
Excellent!  Glad you two have stepped up, sorry for the misinformation.

I may well have missed it, but if not perhaps a general announce email to the
lm-sensors list to announce it may be worth while to alert anyone like me who
is working on slightly aging branches? (staging-next :)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

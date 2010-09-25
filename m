From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Sep 2010 11:11:17 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <20100925131117.5708d3dd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>
	<20100924135802.GA18109@ericsson.com>
	<s5hlj6r1b5p.wl%tiwai@suse.de>
	<20100924163005.7704f63e@endymion.delvare>
	<4C9CBF4E.7080200@cam.ac.uk>
	<20100924151759.GC18153@ericsson.com>
	<4C9CDAD6.6080605@cam.ac.uk>
In-Reply-To: <4C9CDAD6.6080605@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, =?ISO-8859-1?B?yXJpYw==?= Piel <Eric.Piel@tremplin-utc.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, 24 Sep 2010 18:07:34 +0100, Jonathan Cameron wrote:
> On 09/24/10 16:17, Guenter Roeck wrote:
> > On Fri, Sep 24, 2010 at 11:10:06AM -0400, Jonathan Cameron wrote:
> > [...]
> >> Technically hwmon is orphan (according to MAINTAINERS.) But that's not to
> > 
> > If you pull the latest tree, you'll notice that this is no longer correct.
> Excellent!  Glad you two have stepped up, sorry for the misinformation.
> 
> I may well have missed it, but if not perhaps a general announce email to the
> lm-sensors list to announce it may be worth while to alert anyone like me who
> is working on slightly aging branches? (staging-next :)

It was posted on the list, but not under a subject line you would notice:
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-September/029405.html

I should have updated the subject line before replying, sorry about that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

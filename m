From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Feb 2011 11:51:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/6] hwmon: (w83627ehf) Skip in6 and temp3
Message-Id: <20110210115156.GA24543@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297308953-3479-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297308953-3479-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 10, 2011 at 04:43:45AM -0500, Jean Delvare wrote:
> On Wed, 9 Feb 2011 19:35:47 -0800, Guenter Roeck wrote:
> > temp3 and in6 are mutually exclusive only on W83667HG, not on W83667HG-B.
> 
> Hmm? The datasheet I have (version 1.3, 2009-12-15) for the W83667HG-B
> lists pin 109 as VIN3 / AUXTIN, which correspond to in6 and temp3 in the
> w83627ehf driver. The datasheet for the NCT5571D (which I think is the
> same as W83667HG-B but in a different package) also shows VIN3 / AUXTIN
> on the same pin (54). So this is the same as for the W83667HG.
> 
> With a single pin for both functions, I fail to see how you could have
> both at the same time. What makes you think it is possible for the
> W83667HG-B?
> 
You are right. I have no idea what I was looking at. Sorry, ignore this patch.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

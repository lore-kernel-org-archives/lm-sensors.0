From: Greg Schnorr <gschnorr@cisco.com>
Date: Mon, 07 Mar 2011 21:42:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Improve support for paged
Message-Id: <C99A914D.5A89C%gschnorr@cisco.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1299341303-32570-1-git-send-email-guenter.roeck@ericsson.com>
References: <1299341303-32570-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299341303-32570-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Verified this patch works as expected on such "fan rich" hardware...

On 3/5/11 8:08 AM, "Guenter Roeck" <guenter.roeck@ericsson.com> wrote:

> So far, it seemed like fans would either all be in page 0, or that
> there would be one page per fan.
> 
> Turns out this was a wrong assumption. There is at least one PMBus
> fan controller which supports three pages with four fans each.
> Update code to handle this situation.
> 
> Reported-by: Greg Schnorr <gschnorr@cisco.com>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Greg Schnorr <gschnorr@cisco.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

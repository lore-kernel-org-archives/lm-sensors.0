From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Mar 2011 22:08:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Improve support for paged
Message-Id: <20110307220839.GB14789@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299341303-32570-1-git-send-email-guenter.roeck@ericsson.com>
 <C99A914D.5A89C%gschnorr@cisco.com>
In-Reply-To: <C99A914D.5A89C%gschnorr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Schnorr <gschnorr@cisco.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Mar 07, 2011 at 04:42:37PM -0500, Greg Schnorr wrote:
> Verified this patch works as expected on such "fan rich" hardware...
> 
> On 3/5/11 8:08 AM, "Guenter Roeck" <guenter.roeck@ericsson.com> wrote:
> 
> > So far, it seemed like fans would either all be in page 0, or that
> > there would be one page per fan.
> > 
> > Turns out this was a wrong assumption. There is at least one PMBus
> > fan controller which supports three pages with four fans each.
> > Update code to handle this situation.
> > 
> > Reported-by: Greg Schnorr <gschnorr@cisco.com>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Acked-by: Greg Schnorr <gschnorr@cisco.com>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

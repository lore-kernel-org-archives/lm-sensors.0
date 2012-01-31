From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 31 Jan 2012 21:45:58 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/3] hwmon: (hwmon-vid) Fix checkpatch issues
Message-Id: <1328046358.2261.57.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-31 at 16:15 -0500, Jean Delvare wrote:
> On Wed, 25 Jan 2012 04:43:33 -0800, Guenter Roeck wrote:
> > Fixed:
> > ERROR: code indent should use tabs where possible
> > ERROR: space required before the open parenthesis '('
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > 
> > Not fixed (url):
> > WARNING: line over 80 characters
> > (...)
> 
> Looks alright, but for some reason this patch won't apply here.

Probably because it is based on the top of my -next branch, and I have a
couple of other cleanup patches pending for it.

> Nevertheless:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks, applied.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

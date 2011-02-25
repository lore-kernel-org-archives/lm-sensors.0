From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Feb 2011 21:42:44 +0000
Subject: Re: [lm-sensors] [PATCH v4 3/5] hwmon: (pmbus) Add support for
Message-Id: <1298670164.1735.108.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297969217-9564-1-git-send-email-guenter.roeck@ericsson.com>
	 <1297969217-9564-4-git-send-email-guenter.roeck@ericsson.com>
	 <4D681091.4030008@cam.ac.uk>
In-Reply-To: <4D681091.4030008@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, Greg Schnorr <gschnorr@cisco.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Jonathan,

On Fri, 2011-02-25 at 15:26 -0500, Jonathan Cameron wrote:
> Again, straight forward use of pmbus_core.  Is it actually worth having
> separate modules for each of these special cases?  Could just do the
> old big table of fixed chip info structures in a single driver...
> 
This is actually what I had originally. My reasoning to split it up was
that this makes it easier to add support for additional chips without
having to modify the core driver. Also, I can keep chip specific code
(specifically the _identify and _get_status functions) out of the core
driver.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

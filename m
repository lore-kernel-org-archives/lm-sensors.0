From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Oct 2010 13:31:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: use a muxed resource lock
Message-Id: <20101003133153.GA31608@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101003010635.GB29454@ericsson.com>
 <1286107790-26267-1-git-send-email-me@mortis.eu>
In-Reply-To: <1286107790-26267-1-git-send-email-me@mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Laurens Leemans <laurens@signips.com>, Jonathan Cameron <jic23@cam.ac.uk>, Debian Bug #597820 <597820@bugs.debian.org>, Jean Delvare <khali@linux-fr.org>, Hans de Goede <hdegoede@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Oct 03, 2010 at 08:09:49AM -0400, Giel van Schijndel wrote:
> Sleep while acquiring a resource lock on the Super I/O port. This should
> prevent collisions from causing the hardware probe to fail with -EBUSY.
> 
> Signed-off-by: Giel van Schijndel <me@mortis.eu>

Applied.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

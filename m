From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 23 Mar 2009 00:09:54 +0000
Subject: Re: [lm-sensors] [RFC] SHT15 Sensiron humidity and temperature
Message-Id: <20090322170954.eb0ae9d3.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <497367C6.8010200@cam.ac.uk>
In-Reply-To: <497367C6.8010200@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Jan 2009 17:32:54 +0000 Jonathan Cameron <jic23@cam.ac.uk> wrote:

> +/**
> + * sht15_send_bit() send and individual bit to the device
> + **/

One other thing...

The /** token is specifically for introducing kerneldoc-formatted comments.
But this driver uses it for non-kerneldoc comments.

So please either convert the comments to kerneldoc form or use plain old

/*
 * comment goes here
 */

Thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

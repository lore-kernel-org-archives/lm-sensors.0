From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 24 Feb 2011 14:53:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Speed up detection
Message-Id: <20110224145308.GA6712@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110224112322.3a47636e@endymion.delvare>
In-Reply-To: <20110224112322.3a47636e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 24, 2011 at 05:23:22AM -0500, Jean Delvare wrote:
> Make the LM75/LM75A device detection faster:
> 
> * Don't read the current temperature value when we don't use it.
> * Check for unused bits in the configuration register as soon as we
>   have read its value.
> * Don't use word reads, not all devices support this, and some which
>   don't misbehave when you try.
> * Check for cycling register values every 40 register addresses
>   instead of every 8, it's 5 times faster and just as efficient.
> 
> Some of these improvements come straight from the user-space
> sensors-detect script, so both detection routines are in line now.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

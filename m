From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 31 Aug 2011 17:11:43 +0000
Subject: Re: [lm-sensors] hwmon: (ucd9000/ucd9200) Optimize array walk
Message-Id: <1314810703.2455.20.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110831175341.38102427@endymion.delvare>
In-Reply-To: <20110831175341.38102427@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-08-31 at 11:53 -0400, Jean Delvare wrote:
> Rewrite the loop walking the id array during probe. The new code is
> better adapted to a null-terminated array, and is also clearer and
> more efficient than the original.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Axel Lin <axel.lin@gmail.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Inspired by a previous patch from Axel.
> 
Looks good. I'll (hopefully) test it tonight to be sure, but I don't see
any problems with it, so consider it applied. 

I'll make the same changes in the zl6100 driver.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

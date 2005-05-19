From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: [PATCH 2.6] I2C: Fix macro calls in chip drivers
Message-Id: <20040908193817.GF6976@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040825224408.67c8d4bd.khali@linux-fr.org>
In-Reply-To: <20040825224408.67c8d4bd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 25, 2004 at 10:44:08PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> I noticed that some I2C chip drivers (all written or reviewed by me, I
> feel ashamed to say) misuse macros. Passing function calls
> (simple_strtol in this case) to macros evaluating their argument up to 4
> times is certainly not wise and obviously performs poorly. It is not
> critical in that it happens only when writing to the chips (setting
> limits), which doesn't happen that often. However I'd say it's worth
> fixing.
> 
> Thus, the patch below fixes that, by moving the function calls outside
> of the macro calls.


Applied, thanks.

greg k-h

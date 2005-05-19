From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: [PATCH 2.6] I2C: More verbose w83l785ts driver
Message-Id: <20041124222638.GC3584@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041120120543.77bf9e64.khali@linux-fr.org>
In-Reply-To: <20041120120543.77bf9e64.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 20, 2004 at 12:05:43PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This simple patch increases the verbosity of the w83l785ts hardware
> monitoring driver. I wrote it months ago in the hope it would help solve
> a reported problem [1]. Not sure whether it did (no news from user since
> July), but the extra debug info may help in the future and doesn't hurt
> otherwise, so let's have this in for every user (not that many AFAIK),
> just in case.
> 
> This is obviously non-critical and can be delayed until after 2.6.10 is
> released ;)

Applied, thanks.

greg k-h

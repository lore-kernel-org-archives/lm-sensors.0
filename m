From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Setting w83627hf fan_div preserves fan_min
Message-Id: <20040326215345.GB29797@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040325205143.6820ae6e.khali@linux-fr.org>
In-Reply-To: <20040325205143.6820ae6e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 25, 2004 at 08:51:43PM +0100, Jean Delvare wrote:
> Hi Greg, hi all,
> 
> Here is a patch that updates the w83627hf driver in the exact same way I
> did recently for the w83781d driver. There were two problems:
> 1* Fan divisor storing code was ugly, badly ripped from the 2.4 w83627hf
>    driver and/or the 2.6 w83781d driver.
> 2* Setting fan divisors wouldn't preserve fan mins.
> 
> Exactly the same as w83781d:
> http://archives.andrew.net.au/lm-sensors/msg06952.html
> http://archives.andrew.net.au/lm-sensors/msg07008.html
> 
> No surprise since the w83627hf driver is a fork of the w83781d driver.
> 
> Since the two drivers are strongly similar, I took the code directly
> from the updated w83781d driver. I cannot test the w83627hf driver
> (testers welcome BTW) but this makes me feel confident that the code is
> correct.
> 
> To make it clear, this single patch is the w83627f equivalent of the
> three patches I submitted for the w83781d:
> * Cleanup
> * Refactoring
> * Setting fan_div preserves fan_min
> All in one (much better looking BTW).
> 
> Please apply,

Applied, thanks.

greg k-h

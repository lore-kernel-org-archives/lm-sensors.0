From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Setting w83781d fan_div preserves fan_min
Message-Id: <20040315211200.GB32636@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314174331.60dd549e.khali@linux-fr.org>
In-Reply-To: <20040314174331.60dd549e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 14, 2004 at 05:43:31PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch makes the w83781d driver preserve fan_min settings when the
> user changes fan_divs. This isn't done "by default" because the actual
> fan min value (in RPMs) depends on both the fan_min register and the
> fan_div register. Only two drivers handle it properly at the moment as
> far as I know (lm78 and asb100). Several other drivers would need to be
> fixed the same way, but well, once at a time ;)
> 
> Tested on my AS99127F rev.1.
> 
> Credits go to Philip Pokorny, since I think I remember he is the one who
> introduced the method in the lm78 driver in the first place.
> 
> This tends to increase the size of the three set_store_regs_fan_div
> functions, and I am considering refactoring them at some point. Later
> though.
> 
> Please apply, thanks.

Applied, thanks.

greg k-h

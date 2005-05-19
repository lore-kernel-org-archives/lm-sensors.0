From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH 2.6] w83781d fan_div code refactoring
Message-Id: <20040319212156.GB12366@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040317220839.373babf0.khali@linux-fr.org>
In-Reply-To: <20040317220839.373babf0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 17, 2004 at 10:08:39PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > This tends to increase the size of the three set_store_regs_fan_div
> > functions, and I am considering refactoring them at some point. Later
> > though.
> 
> Here is the promised refactoring. Tested on my AS99127F rev.1, seems to
> work. As for the previous patch, there is a part that I cannot test with
> the AS99127F, so additional testing is welcome.
> 
> I agree this makes the code slightly less readable, but this saves 60
> lines of code (1754 bytes, around 3% of the driver total), and is
> actually far less complex that I first feared.

The patch looks fine to me, so I've applied it, thanks.

greg k-h

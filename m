From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: CVS patch for lm85 fixes and EMC6D100 support
Message-Id: <20030530163527.GA19204@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED78579.9030203@penguincomputing.com>
In-Reply-To: <3ED78579.9030203@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 30, 2003 at 09:23:21AM -0700, Philip Pokorny wrote:
> This patch fixes a race condition in the lm85 driver and adds support for 
> the SMC EMC6D100 and EMC6D101.  The EMC6D100 and 101 chips have some 
> additional features that *are not* currently implemented in the driver, but 
> the chip is detected (by sensors-detect and the lm85 driver).

Nice, care to make a 2.5 patch too?

thanks,

greg k-h

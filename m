From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH 2.6] Fix i2c-algo-bit for adapers that cannot read SCL
Message-Id: <20031204213525.GA2239@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115154351.5bcbf36b.khali@linux-fr.org>
In-Reply-To: <20031115154351.5bcbf36b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 15, 2003 at 03:43:51PM +0100, Jean Delvare wrote:
> 
> Hi Greg,
> 
> Here follows a patch to i2c-algo-bit.c as found in linux-2.6.0-test9,
> with two fixes for adapters that cannot read SCL back. Althouth real
> adapters should be able to read SCL back, there are some that
> cannot, for example the ADM1032 evaluation board I am using. Such
> adapters where supposed to be already supported, but I found a probable
> bug and improved support.
> 
> These changes were applied to our i2c CVS repository two weeks ago and
> have been reviewed by Mark D. Studebaker.
> 
> List of changes:
> 
> * Fix sclhi() for adapters that do not have getscl().
> * Enable bit_test for adapters that do not have getscl().
> * Mostly rewrite test_bus(), cleaner and probably faster.

Applied, thanks.

greg k-h

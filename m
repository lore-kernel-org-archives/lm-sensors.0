From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] S3C2410 i2c updates
Message-Id: <20041109004946.GD25651@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041108105226.GA4412@home.fluff.org>
In-Reply-To: <20041108105226.GA4412@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 08, 2004 at 10:52:26AM +0000, Ben Dooks wrote:
> This patch integrates several fixes to the s3c2410 i2c
> driver
> 
> Shannon Holland:
> 	
> 	- write IICCON in configuration code
> 	- add handling for s3c2410 i2c errata
> 	- fix clock rate divisor calculation
> 
> Ben Dooks:
> 
> 	- s3c2440 detection
> 	- s3c2440 IICLC register setup
> 	- add __exit to the module exit
> 	- remove return from exit code
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Shannon Holland <holland@loser.net>

Applied, thanks.

greg k-h

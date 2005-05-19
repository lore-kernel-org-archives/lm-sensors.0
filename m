From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH] S3C2410 missing I2C_CLASS_HWMON
Message-Id: <20050225200813.GD25915@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050221121745.GA7839@home.fluff.org>
In-Reply-To: <20050221121745.GA7839@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 21, 2005 at 12:17:45PM +0000, Ben Dooks wrote:
> None of the standard sensor drivers currently recognise the s3c24xx
> I2C controller as it does not have I2C_CLASS_HWMON set in the
> adapter class field.
> 
> The attached patch initialises the adapter class to I2C_CLASS_HWMON

Applied, thanks.

greg k-h

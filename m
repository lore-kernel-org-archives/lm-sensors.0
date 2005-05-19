From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH 2.6] I2C: Clean up i2c-amd756 and i2c-prosavage messages
Message-Id: <20041019222836.GG9521@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041016212605.630f6e64.khali@linux-fr.org>
In-Reply-To: <20041016212605.630f6e64.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Oct 16, 2004 at 09:26:05PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> A number of messages in the i2c-amd756 and i2c-prosavage drivers have a
> leading ": " (especially the former). This is a legacy from lm_sensors'
> printks of the 2.4 times. This patch cleans them up. While I was there,
> I dropped a couple useless white spaces and dots as well.
> 
> Please apply,

Applied, thanks.

greg k-h

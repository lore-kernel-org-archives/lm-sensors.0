From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: i2c-s3c2410 functionality and fixes
Message-Id: <20050328210410.GD3752@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050326190444.7c4c5367.khali@linux-fr.org>
In-Reply-To: <20050326190444.7c4c5367.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 26, 2005 at 07:04:44PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch does the following updates to the i2c-s3c2410 bus driver:
> 
> * Properly report the i2c functionality by adding to the
>   `.functionality` field of the adapter
> 
> * Change the dev_err() call on no-ack to an dev_dbg() to make
>   it less noisy when the bus is being probed by i2cdetect, etc.
> 
> * Add I2C_M_REV_DIR_ADDR to fully implement the
>   I2C_FUNC_PROTOCOLO_MANGLING.
> 
> * Ensure that the adapter owner field is set to THIS_MODULE
> 
> Please apply, thanks.
> 
> (Once this is applied, all i2c bus drivers will be properly reporting
> their functionality so I'll be able to go on with the i2c functionality
> core cleanups.)

Applied, thanks.

greg k-h

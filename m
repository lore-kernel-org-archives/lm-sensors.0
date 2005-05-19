From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH 2.6] I2C: New lm92 chip driver
Message-Id: <20050317064023.GG15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306103250.0dd6f040.khali@linux-fr.org>
In-Reply-To: <20050306103250.0dd6f040.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 06, 2005 at 10:32:50AM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This is a new i2c chip driver named lm92. It supports the National
> Semiconductor LM92 and Maxim MAX6635 chips. This time I did not port the
> driver from the lm_sensors project but instead rewrote it. The reason is
> that the original driver has a different structure from the other i2c
> chip drivers, which would have made maintenance harder.
> 
> I don't have a compatible chip myself but could test my code thanks to
> Mark Hoffman's i2c-stub fake bus driver. Later on, James Chapman tested
> it on a real chip, successfully.

Applied, thanks.

greg k-h

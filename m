From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH 2.6] I2C: New PC8736x chip driver
Message-Id: <20041105214729.GE1750@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041029224731.58d0be48.khali@linux-fr.org>
In-Reply-To: <20041029224731.58d0be48.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 29, 2004 at 10:47:31PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This is my port of the pc87360 driver. It supports the hardware
> monitoring functions of the National Semiconductor PC8736x Super-I/O
> family. The PC87360, PC87363 and PC87364 only do fan monitoring and
> control. The PC87365 and PC87366 additionally have voltage and
> temperature monitoring.
> 
> The driver was ported upon request from Wincor-Nixdorf, and tested by
> Rolf M?ller there. I wish to thank Rolf for his very efficient
> cooperation.
> 
> Please apply,
> thanks.

Applied, thanks.

Oh, and I fixed up your MODULE_PARAM warning too :)

greg k-h

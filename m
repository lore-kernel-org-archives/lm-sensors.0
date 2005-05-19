From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: algorithm and bus driver for PCA9564
Message-Id: <20040805234500.GB23286@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1091438873.11210.55.camel@icampbell-debian>
In-Reply-To: <1091438873.11210.55.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 02, 2004 at 10:27:53AM +0100, Ian Campbell wrote:
> Greg, Sensors,
> 
> Attached is a driver for the PCA9564 "Parallel to I2C" chip, it is
> similar in principle to the PCF8584 which is supported by the
> i2c-algo-pcf and i2c-elektor code, however it's not code compatible in
> any way: http://www.semiconductors.philips.com/pip/PCA9564PW.html
> 
> The patch contains the PCA algorithm driver and a bus driver for an ISA
> card. It only supports master send and receive but I'm not sure that the
> Linux i2c stack supports client side operation anyhow, and I have no
> hardware to test on.
> 
> It was tested on a PC104 card containing the PCA chip and an Atmel TPM
> device and also on a separate PC104 card with a DS1307 RTC hotwired onto
> it for testing purposes.
> 
> The driver is against a 2.6 BK tree pulled on Friday. I also have a
> fairly trivial 2.4 backport if that is of interest. 

Looks good, I've applied this to my trees, and will send it off to Linus
after 2.6.8 is out.

thanks,

greg k-h

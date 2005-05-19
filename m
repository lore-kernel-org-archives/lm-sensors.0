From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] Enable I2C_PIIX4 for 64-bit platforms
Message-Id: <20050217222510.GB21188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61L.0502120502580.30117@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0502120502580.30117@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 12, 2005 at 05:12:43AM +0000, Maciej W. Rozycki wrote:
> Hello,
> 
>  Is there any specific reason for the PIIX4 SMBus driver to be disabled on 
> 64-bit platforms?  If not, then please apply the following change.  The 
> MIPS Technologies Malta development board has the 82371EB chip and 
> supports 64-bit configurations.  I've verified the driver to work 
> correctly using 64-bit kernels for both endiannesses.
> 
>   Maciej
> 
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

Applied, thanks.

greg k-h

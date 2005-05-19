From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH 2.6] I2C: Spare 1 byte in lm90 driver
Message-Id: <20041019222743.GC9521@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041011194511.30b86de9.khali@linux-fr.org>
In-Reply-To: <20041011194511.30b86de9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 11, 2004 at 07:45:11PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> I just noticed the other day that the lm90 driver uses an u16 to store
> the value of the 8-bit alarms register. This is most probably due to the
> fact that I originally copied the lm90 driver from the lm83 driver,
> which actually has two 8-bit registers for alarms, and obviously forgot
> to change the variable type.
> 
> Please apply,

Applied, thanks.

greg k-h

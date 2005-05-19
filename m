From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: [PATCH 2.6] Incomplete AT24RF08 corruption prevention in i2c
Message-Id: <20040519070548.GA18660@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516191842.024a907c.khali@linux-fr.org>
In-Reply-To: <20040516191842.024a907c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 16, 2004 at 07:18:42PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The AT24RF08 corruption prevention trick that is found in the i2c eeprom
> driver is not correct. The prevention is activated only conditionally,
> while it should be done all the time.

Applied, thanks.

greg k-h

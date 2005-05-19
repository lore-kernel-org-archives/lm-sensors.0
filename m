From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] Drop out-of-date code in w83781d and w83627hf
Message-Id: <20040622162739.GA595@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040619193753.52b353dd.khali@linux-fr.org>
In-Reply-To: <20040619193753.52b353dd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 19, 2004 at 07:37:53PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Here is a simple patch which drops some out-of-date code in the w83781d
> and w83627hf i2c chip drivers. These bits are left over from the times
> when chip drivers were setting default limits at init.
> 
> Should apply cleanly against your current tree.
> 
> Please apply,
> Thanks.
> 
> Signed-off-by: Jean Delvare <khali at linux-fr dot org>

Applied, thanks.

greg k-h

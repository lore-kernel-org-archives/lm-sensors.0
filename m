From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH 2.6] I2C: Missing newlines in debug messages
Message-Id: <20041112212023.GB2256@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109210252.6cc251bb.khali@linux-fr.org>
In-Reply-To: <20041109210252.6cc251bb.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 09, 2004 at 09:02:52PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> As discussed on IRC, this simple patch fixes broken debug messages
> missing their trailing newlines. I just applied something similar to
> CVS, and will prepare patches for 2.4 as well.

Applied, thanks.

greg k-h

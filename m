From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH 2.6] Add Intel IXP2000 GPIO-based I2C adapter
Message-Id: <20040802231219.GD15751@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040727230649.GA17079@plexity.net>
In-Reply-To: <20040727230649.GA17079@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 27, 2004 at 04:06:49PM -0700, Deepak Saxena wrote:
> 
> Greg,
> 
> Following patch adds support for using GPIO pins on Intel's IXP2000
> Network Processor as a bit-bang I2C adapter. IXP2000 support will
> be coming in via ARM updates once all the various drivers have been
> merged upstream.

Applied, thanks.

greg k-h

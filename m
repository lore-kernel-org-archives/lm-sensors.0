From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH] PPC4xx IIC driver: 0-length transactions bit-banging
Message-Id: <20040708230713.GF20431@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040622185116.GA4146@gate.ebshome.net>
In-Reply-To: <20040622185116.GA4146@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@Stimpy.netroedge.com, linuxppc-embedded@lists.linuxppc.org

On Tue, Jun 22, 2004 at 11:51:16AM -0700, Eugene Surovegin wrote:
> Greg,
> 
> IBM PPC 4xx i2c controller doesn't support 0-length transactions (e.g. used by 
> SMBUS_QUICK). This patch implements bit-banging emulation for such requests and 
> removes temporary kludge added earlier.
> 
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
> 
> Please, apply.

Applied, thanks.

greg k-h

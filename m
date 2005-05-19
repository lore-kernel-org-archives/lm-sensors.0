From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] probe fewer addresses for asb100 (sensors) driver
Message-Id: <20050106215514.GE27899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050102212501.GA17759@jupiter.solarsys.private>
In-Reply-To: <20050102212501.GA17759@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 02, 2005 at 04:25:01PM -0500, Mark M. Hoffman wrote:
> Hi Greg:
> 
> This patch limits SMBus scanning for the asb100 sensor chip
> to just one address - the only one we've ever seen in practice.

Applied, thanks.

greg k-h

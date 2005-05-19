From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] Add support for LM77
Message-Id: <20040708230610.GA20431@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1089231956.4800.63.camel@null>
In-Reply-To: <1089231956.4800.63.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 07, 2004 at 10:25:56PM +0200, Andras BALI wrote:
> Hi Greg,
> 
> This patch (against the current stack) adds support for the
> LM77 sensor chips made by National Semiconductor. Formerly
> this was claimed by the LM75 driver but when I got hold of an
> embedded board (built around the National Geode SC1100 CPU),
> which was equipped with an LM77, it turned out that the two
> chips are not compatible.
> 
> It has been developed with help of, reviewed and approved
> by Jean Delvare.

Applied, thanks.

greg k-h

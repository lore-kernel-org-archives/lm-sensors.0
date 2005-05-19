From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] Add support for LM86, MAX6657 and MAX6658 to lm90
Message-Id: <20040708230654.GD20431@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040704213107.0996e984.khali@linux-fr.org>
In-Reply-To: <20040704213107.0996e984.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 04, 2004 at 09:31:07PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This adds support for the LM86, MAX6657 and MAX6658 sensor chips to the
> lm90 driver. These are less popular than the LM90 and ADM1032 but
> several users have reported to use these, so I added support to the lm90
> driver. All these chips are fully compatible so that's just a matter of
> accepting the new chip ids. I also slightly simplified the detection
> code.
> 
> Should apply fine on top of your current stack.

Applied, thanks.

greg k-h

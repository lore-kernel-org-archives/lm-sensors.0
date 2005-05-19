From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH 2.6] Fix voltage rounding in asb100
Message-Id: <20040415001553.GB27521@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040413190613.765faf39.khali@linux-fr.org>
In-Reply-To: <20040413190613.765faf39.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 13, 2004 at 07:06:13PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This one line patch fixes voltage rounding in the asb100 chip driver.
> It's very similar to a patch I submitted for the lm80 a few days ago.
> 
> It applies cleanly on top of 2.6.5-mm5.

Applied, thanks.

greg k-h

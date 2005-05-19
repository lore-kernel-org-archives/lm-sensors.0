From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] it87 sensor type
Message-Id: <20040224002726.GE24225@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040222113336.68d9de4d.khali@linux-fr.org>
In-Reply-To: <20040222113336.68d9de4d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 22, 2004 at 11:33:36AM +0100, Jean Delvare wrote:
> Greg,
> 
> Here comes a patch by Takeru Komoriya which fixes the way the it87
> driver handles temperature sensor types selection.
> 
> * Use the same values as the CVS driver and sensors program.
> * Better comments.
> * Get rid of the old setting method (already gone in CVS).
> * Handle invalid values correctly.
> 
> I've reviewed Takeru's work and it looks very good. Please apply (should
> apply cleanly on top of your current stack).

Applied, thanks.

greg k-h

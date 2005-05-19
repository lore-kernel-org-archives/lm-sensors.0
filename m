From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] I2C: macintoch/therm_* drivers cleanups
Message-Id: <20041129234235.GA21496@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041129231855.5e7f0bed.khali@linux-fr.org>
In-Reply-To: <20041129231855.5e7f0bed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 29, 2004 at 11:18:55PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch cleans the macintoch/therm_* drivers a bit. It removes
> useless IDs, cleans names (no white space), some coding style fixes as
> well, etc. It's exactly the same as what I posted yesterday as a
> candidate fix to bug #3823:
> http://bugzilla.kernel.org/show_bug.cgi?id823
> 
> Although it isn't the proper fix for that bug, as you underlined, this
> still sounds like a sane set of cleanups for these drivers.
> 
> Please apply,

Applied, thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: checksum in (i2c) eeprom driver
Message-Id: <20041209231744.GA6446@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41B85D43.8070409@verizon.net> <vojkqBdx.1102603548.0379010.khali@localhost>
In-Reply-To: <vojkqBdx.1102603548.0379010.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: sensors@Stimpy.netroedge.com, Deepak Saxena <dsaxena@plexity.net>, LKML <linux-kernel@vger.kernel.org>

On Thu, Dec 09, 2004 at 03:45:48PM +0100, Jean Delvare wrote:
> 
> If the checksumming was that important, I guess it would have been the
> default, which it was not. If it is there for the sole purpose of
> allowing the user to prevent the eeprom driver from taking over
> non-eeprom chips, then the "ignore" module parameter can be used to
> achieve the same effect, faster, plus it is configurable on a
> per-address basis, while the checksum parameter isn't.

I agree, what's wrong with using the ignore stuff instead?

thanks,

greg k-h

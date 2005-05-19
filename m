From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c-piix4 fix undo
Message-Id: <20031217235250.GC6258@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031206221027.45ecfdea.khali@linux-fr.org>
In-Reply-To: <20031206221027.45ecfdea.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 06, 2003 at 10:10:27PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> A few months ago, we added a workaround to i2c-piix4 to help it to work
> on a few boards. The fix was ported to 2.6, the patch is here:
> http://linuxusb.bkbits.net:8080/i2c-2.6/patch@1.1123.21.1
> 
> It since turned out that it also breaks the module for other boards, and
> it even breaks more than it fixes (4 reports since lm_sensors-2.8.1 was
> released). The problem is under investigation by Tom Rini, the author of
> the original fix.
> 
> I suggest that you reverse the fix in Linux 2.6 before 2.6.0 is
> released. Once we have enough information to submit a better one (could
> take some time), I'll send a new patch to you.

Thanks, I've backed this patch out and will send it off to Linus.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [PATCH 2.6] I2C: Do not register useless smsc47m1
Message-Id: <20041119171238.GE19845@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041113161124.1a546464.khali@linux-fr.org>
In-Reply-To: <20041113161124.1a546464.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 13, 2004 at 04:11:24PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> While verifying my stack of patches against what you sent to Linus last
> week, I noticed this one. Looks like I simply forgot to send it to you,
> as I cannot find any trace of it in the lm_sensors mailing-list
> archives.
> 
> The patch prevents an smsc47m1 device from being registered when no
> monitoring function is actually active within the chip. See this ticket
> for background:
>   http://secure.netroedge.com/~lm78/readticket.cgi?ticket01
> This is certainly better to explicitely fail in this case than leave the
> user with an empty sysfs directory (except for alarms), which tends to
> make him/her think of a driver bug, which it isn't (what it really is is
> a BIOS brokenness).
> 
> This isn't fixing any critical bug and can be delayed until after 2.6.10
> is released.
> 
> Thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h

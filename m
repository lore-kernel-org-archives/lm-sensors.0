From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Don't handle kind errors that cannot happen
Message-Id: <20040315211213.GC32636@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313185302.6955c4a9.khali@linux-fr.org>
In-Reply-To: <20040313185302.6955c4a9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 13, 2004 at 06:53:02PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> A number of chip drivers in 2.6.4-mm1 try to handle an error case that
> cannot happen when setting the chip name. The following patch changes
> that.
> 
> Affected drivers: adm1021, it87, lm75, lm78, lm85, w83627hf, w83781d.
> 
> Note that in any case, the worst that could happen (but then again, it
> cannot happen) is that the chip name would be set to an empty string,
> which doesn't hurt much.
> 
> The patch also cleans up a few things in it87, w83627hf and w83781d,
> which are tightly related to the rest of the changes and necessary for
> them to be safe.
> 
> it87: There is only really one "kind" in this driver, so I removed all
> references to other kinds.
> 
> w83627hf: The driver did not handle unknown chips.
> 
> w83781d: The user shouldn't be allowed to force a kind that doesn't
> match the chip's bus type (I2C or ISA). The code was not meant to handle
> that case, although no check was done so far.
> 
> Tested on my AS99127F, works as intended.
> 
> Please apply,

Applied, thanks.

greg k-h

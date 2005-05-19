From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] Hangs with w83781d
Message-Id: <20040224002718.GD24225@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040221151755.7b288c5b.khali@linux-fr.org>
In-Reply-To: <20040221151755.7b288c5b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 21, 2004 at 03:17:55PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here is a patch for the w83781d driver that prevents register bits from
> being arbitrary changed when we force temp2/3 to comparator mode. Keith
> Duthie had been reporting various problems with that driver and finally
> found that this arbitrary change was the cause of them. He also tested
> this patch, which he confirmed to work.
> 
> I have backported this change to the w83781d driver in our CVS
> repository, as well as in our w83627hf, which had the same problem.
> 
> Please apply.

Applied, thanks.

greg k-h

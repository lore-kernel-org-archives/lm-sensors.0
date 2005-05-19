From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ALI1563 SMBus driver fix - take 2
Message-Id: <20050502204011.GA32713@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050421090756.13436.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050421090756.13436.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 21, 2005 at 09:07:56AM -0000, R.Marek@sh.cvut.cz wrote:
> Hello,
> 
> This patch fixes "grave" bugs in i2c-ali1563 driver. It seems on recent
> chipset revisions the HSTS_DONE is set only for block transfers, so we
> must detect the end of ordinary transaction other way. Also due to missing
> and mask, setting other transfer modes was not possible. Moreover the 
> continous byte mode transfer uses DAT0 for command rather than CMD command.
> All those changes were tested with help of Chunhao Huang from Winbond.
> 
> I'm willing to maintain the driver. Second patch adds me as maintainer
> if this is neccessary.

Applied, thanks.

greg k-h

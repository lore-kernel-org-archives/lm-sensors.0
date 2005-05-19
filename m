From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: PATCH: i2c: add adt7461 chip support to lm90 driver
Message-Id: <20050328210433.GE3752@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422C305F.3000301@katalix.com>
In-Reply-To: <422C305F.3000301@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 27, 2005 at 02:34:15PM +0200, Jean Delvare wrote:
> Hi Greg, James, all,
> 
> > > > Attached is another version of my adt7461 patch, for inclusion in
> > > > the 2.6 tree. Reviewed by Jean.
> > 
> > May we have an additional patch to Kconfig for this one?
> 
> Here it finally comes.
> 
> This simple patch adds a mention to the ADT7461 chip in Kconfig, now
> that the lm90 driver supports it.
> 
> Please apply,

Applied, thanks.

greg k-h

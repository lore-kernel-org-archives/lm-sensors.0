From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Discard out-of-date comment in adm1021 driver
Message-Id: <20040325184905.GA30899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040321184051.0fdfd76b.khali@linux-fr.org>
In-Reply-To: <20040321184051.0fdfd76b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 21, 2004 at 06:40:51PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This simple patch discards an out-of-date comment in the adm1021 driver.
> I've done the same in our CVS repository where many more drivers were
> affected.
> 
> I agree it's not very important, but I prefer it to be done before any
> driver with the error is used as a base to port a new driver, and the
> misinformation spreads.
> 
> Please apply,

Applied, thanks.

greg k-h

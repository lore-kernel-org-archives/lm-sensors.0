From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.6] I2C: New hardware monitoring driver: w83627ehf (3rd
Message-Id: <20050502205322.GB9058@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416201701.7e4a5e74.khali@linux-fr.org>
In-Reply-To: <20050416201701.7e4a5e74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 25, 2005 at 10:43:25PM +0200, Jean Delvare wrote:
> Hi Grant,
> 
> > This is a small change to the fan clock divider adjustment performed 
> > in the fan speed measuring code.
> > 
> > Fan max clock divider check changed to be defensive.
> 
> Doesn't change anything as far as I can see, but if it makes you any
> happier, why not...
> 
> > Prevent fan low limit becoming active if it is set to sentinel 255
> > value  (low limit alarm inactive) and prevent fan low limit going to
> > zero.
> 
> Correct, I has missed that point, thanks for noticing.
> 
> Here comes an updated patch. Let's hope it's for good this time!

Applied, thanks.

greg k-h

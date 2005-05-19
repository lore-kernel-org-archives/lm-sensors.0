From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.6] bus scan removal
Message-Id: <20031230200538.GA3163@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031224171931.22744f11.khali@linux-fr.org>
In-Reply-To: <20031224171931.22744f11.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 24, 2003 at 05:19:31PM +0100, Jean Delvare wrote:
> > Unless anyone objects, I'll be writing patches for both linux 2.4.23
> > and 2.6.0, and submit them to Marcelo and Greg, respectively.
> 
> Here we go for 2.6.0. Greg, this patch drops bus scan from i2c-algo-ite
> and i2c-ibm_iic. It also removes the incomplete and broken SLO_IO stuff
> from i2c-algo-ite.

Applied, thanks.

greg k-h

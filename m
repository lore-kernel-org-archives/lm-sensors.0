From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH i2c-pca] improve debugging output
Message-Id: <20050217222517.GC21188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1108135767.3181.59.camel@icampbell-debian>
In-Reply-To: <1108135767.3181.59.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 11, 2005 at 03:29:27PM +0000, Ian Campbell wrote:
> Greg,
> 
> Rework the pca_xfer() function to always print the number of
> successfully completed transfers in a series when debugging, even when
> exiting with an error.
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>

Applied, thanks.

greg k-h

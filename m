From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH 2.6] I2C: unnecessary #includes in asb100.c
Message-Id: <20050131182859.GA21546@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050131050010.GA5334@jupiter.solarsys.private>
In-Reply-To: <20050131050010.GA5334@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 31, 2005 at 12:00:10AM -0500, Mark M. Hoffman wrote:
> Hi Jean, Greg:
> 
> * Jean Delvare <khali@linux-fr.org> [2005-01-25 10:14:49 +0100]:
> > Any reson why asb100.c (in linux 2.6.11-rc2) includes linux/ioport.h and
> > asm/io.h? As an i2c-only chip driver, I don't think it needs these.
> >
> > As a side note, I also wonder what the inclusions of linux/config.h,
> > linux/types.h and asm/errno.h are there for.
> 
> Because they look pretty?  Here's a patch Greg, please apply...

Applied, thanks.

greg k-h

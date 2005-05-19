From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH] EMC6D100 support in the 2.6 kernel
Message-Id: <20050113170908.GA23775@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501131214.02668.rafael.espindola@gmail.com>
In-Reply-To: <200501131214.02668.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 13, 2005 at 02:48:48PM -0200, Rafael ??vila de Esp??ndola wrote:
> --- linux-2.6.10/drivers/i2c/chips/lm85.c	2004-12-24 19:34:30.000000000 -0200
> +++ lm85.c	2005-01-13 10:29:30.000000000 -0200


Much nicer, but can you add the description of the patch, and the
Signed-off-by: line to it, so I can feed it to my patch acceptance
scripts?

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH] EMC6D100 support in the 2.6 kernel
Message-Id: <20050113152357.GB21610@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501131214.02668.rafael.espindola@gmail.com>
In-Reply-To: <200501131214.02668.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 13, 2005 at 12:14:02PM -0200, Rafael ?vila de Esp?ndola wrote:
> I have ported the support for the EMC6D100 sensor from kernel 2.4 to kernel 
> 2.6. In the process I received some comments from Jean Delvare.
> 
> Signed-off-by: Rafael ?vila de Esp?ndola <rafael.espindola@gmail.com>
> --- linux-2.6.10/drivers/i2c/chips/lm85.c 2004-12-24 19:34:30.000000000 -0200
> +++ lm85.c 2005-01-13 10:29:30.000000000 -0200

<snip>

Your email client ate all of the tabs in the patch, preventing the patch
from being able to be applied :(

Care to resend it?

thanks,

greg k-h

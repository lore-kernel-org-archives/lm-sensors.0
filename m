From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: pwm fan control with IT8705F I/O chip it87 module
Message-Id: <20041221191118.GD8916@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
In-Reply-To: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 20, 2004 at 11:40:22PM +0200, Jonas Munsin wrote:
> Greg KH: at the end is a patch to drivers/i2c/chips/it87.c (2.6.10-rc3) which
>  - adds manual PWM
>  - removes buggy "reset" module parameter
>  - fixes some whitespaces


> --- drivers/i2c/chips/it87.c_2.6.10-rc3	2004-12-08 22:30:51.000000000 +0200
> +++ drivers/i2c/chips/it87.c_2.6.10-rc3-jm-60-khali_comments_20041220	2004-12-20 23:28:14.000000000 +0200

Ick, please make your diff so I can apply it with -p1, and not editing
the filename :)

Anyway, I've applied this to my trees, thanks.

greg k-h

From: rmk+lkml@arm.linux.org.uk (Russell King)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Message-Id: <20050511075100.A20000@flint.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670505070621784dbd63@mail.gmail.com> <20050510221615.GA4613@kroah.com>
In-Reply-To: <20050510221615.GA4613@kroah.com>; from greg@kroah.com on Tue, May 10, 2005 at 03:16:15PM -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Yani Ioannou <yani.ioannou@gmail.com>, Dmitry Torokhov <dtor_core@ameritech.net>, Jean Delvare <khali@linux-fr.org>, LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 03:16:15PM -0700, Greg KH wrote:
> +#define __ATTR(_name,_mode,_show,_store) {	\
> +	.attr = {				\
> +		.name = __stringify(_name),	\
> +		.mode = _mode,			\
> +		.private = NULL,		\

We don't specifically initialise elements to NULL or zero.  Is this a
change of policy?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

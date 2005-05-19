From: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] i2c driver changes for 2.5.66
Message-Id: <20030325085505.A16443@flint.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <10485563141404@kroah.com> <10485563161165@kroah.com>
In-Reply-To: <10485563161165@kroah.com>; from greg@kroah.com on Mon, Mar 24, 2003 at 05:38:00PM -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Mon, Mar 24, 2003 at 05:38:00PM -0800, Greg KH wrote:
>  static struct i2c_adapter ioc_ops = {
> -	.name			= "IOC/IOMD",
>  	.id			= I2C_HW_B_IOC,
>  	.algo_data		= &ioc_data,
>  	.client_register	= ioc_client_reg,
>  	.client_unregister	= ioc_client_unreg
> +	.dev			= {
> +		.name		= "IOC/IOMD",
> +	},
>  };

Are you sure that "IOC/IOMD" is a good name to stick in sysfs?
s|/|,| would probably be a good idea.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

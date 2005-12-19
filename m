From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Dec 2005 20:42:37 +0000
Subject: [lm-sensors] [PATCH 2/7] i2c: scx200_acb - debug log cleanup
Message-Id: <20051219214237.03857d67.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191051u6f7c0b38k2c9843a6baed00bf@mail.gmail.com>
In-Reply-To: <808c8e9d0512191051u6f7c0b38k2c9843a6baed00bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> scx200_acb debug log cleanup.

>  	if (!len && rw = I2C_SMBUS_READ) {
> -		dev_warn(&adapter->dev, "zero length read\n");
> +		dev_dbg(&adapter->dev, "zero length read\n");
>  		return -EINVAL;
>  	}

It just happened to me that this test is bogus. len = 0 && rw =
I2C_SMBUS_READ is perfectly valid according to the SMBus specification.
It's a "quick command" with data (1 bit) = 1. I never saw it used in
practice, and everyone seems to agree that this is a weirdness in SMBus'
specification (using the read/write bit as data in this specific case)
but it's still valid.

>  	if (len && !buffer) {
> -		dev_warn(&adapter->dev, "nonzero length but no buffer\n");
> +		dev_dbg(&adapter->dev, "nonzero length but no buffer\n");
>  		return -EFAULT;
>  	}

I think that the whole block should be enclosed by #ifdef DEBUG/#endif,
as this error condition is simply not supposed to happen.

-- 
Jean Delvare


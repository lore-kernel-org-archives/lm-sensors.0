From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040716170716.GD8264@openzaurus.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <10898500322333@kroah.com> <10898500321009@kroah.com>
In-Reply-To: <10898500321009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi!

> +menu "Dallas's 1-wire bus"
> +
> +config W1
> +	tristate "Dallas's 1-wire support"
> +	---help---
> +	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
> +	  such as iButtons and thermal sensors.

Just out of curiosity... are such devices really connected using one wire only,
or is it GND+5V+one data wire, or GND+power&data wire?

-- 
64 bytes from 195.113.31.123: icmp_seq( ttlQ timeD8769.1 ms         

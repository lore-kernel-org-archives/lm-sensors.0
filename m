From: pavel@suse.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] More i2c driver changes for 2.5.65
Message-Id: <20030325093550.GD1083@zaurus.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <10482950873871@kroah.com> <10482950921680@kroah.com>
In-Reply-To: <10482950921680@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi!

> +	.name		= "ADM1021-MAX1617",

Why dash here

> +	.name		= "LM75 sensor",

And space here? Also you should have 
either 2x "sensor" or none at all. 
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

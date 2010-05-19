From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 May 2010 13:16:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp421) Add nfactor support (2nd
Message-Id: <20100519151626.1e1262be@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BF1A760.2010707@theptrgroup.com>
	<20100518113838.GA2052@andre-laptop>
	<4BF2A5A9.6010907@theptrgroup.com>
	<20100519072659.GA2069@andre-laptop>
In-Reply-To: <20100519072659.GA2069@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andre Prendel <andre.prendel@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org, lm-sensors@lm-sensors.org

Hi Andre,

On Wed, 19 May 2010 09:26:59 +0200, Andre Prendel wrote:
> Jean, should we describe this interface in Documentation/hwmon/sysfs-interface
> too? For the moment tmp421 is the only driver implementing it.

If the values are expressed in a standard unit (i.e. not raw register
values) then yes, it would be nice to have a standard interface
described for these files.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

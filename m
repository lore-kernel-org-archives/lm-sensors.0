From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: flex scanner jammed
Message-Id: <20030806174533.77b66fdf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806172523.6ac44fe9.zdavatz@ywesee.com>
In-Reply-To: <20030806172523.6ac44fe9.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok, now I get:
> 
> Next adapter: uni-n 0 (Keywest i2c)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x30
> Client at address 0x48 can not be probed - unload all client drivers
> first! Client at address 0x49 can not be probed - unload all client
> drivers first! Client at address 0x50 can not be probed - unload all
> client drivers first!
> 
> Next adapter: uni-n 1 (Keywest i2c)
> Do you want to scan it? (YES/no/selectively):
> Client at address 0x48 can not be probed - unload all client drivers
> first! Client at address 0x49 can not be probed - unload all client
> drivers first! Client at address 0x50 can not be probed - unload all
> client drivers first!
> 
> Next adapter: mac-io 0 (Keywest i2c)
> Do you want to scan it? (YES/no/selectively):
> Client at address 0x34 can not be probed - unload all client drivers
> first! Client at address 0x56 can not be probed - unload all client
> drivers first!

This could mean you have some other driver already handling these chips.
I would expect the dmasound_pmac module to be one of them. Maybe you
could unload it, then re-run sensors detect. Try lsmod, and if any
module pretends to use i2c-core, it should be unloaded before running
sensors-detect.

> When I type sensors now I get:
> flex scanner jammed

I think this is caused by the "old" (but too recent now) sensors.conf
file in /etc. Copy etc/sensors.conf.eg from lm_sensors-2.7.0 to
/etc/sensors.conf, and the message should go.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

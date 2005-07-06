From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Wed, 06 Jul 2005 17:40:57 +0000
Subject: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C90AB60D4@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506300918.17966.bgardner@wabtec.com>
In-Reply-To: <200506300918.17966.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Evgeniy,

Thanks for the feedback.
I will change the id to be a hex number, ie "236cdc1c00000043\n".

(Qoute about the thermal attribute 'w1_slave')
> I would like to create this files automatically by w1 core and only
> let slave drivers to create it's "private" files themselves.

I'm curious as to why.
I've looked at types of families out there
(http://owfs.sourceforge.net/family.html).
As far as I can tell, only a few of them are thermal class.
Do we really want a generic name 'w1_slave' that means something
different for each family? 

I removed 'w1_slave' from the core because w1_therm is the only family
that uses it.

IMO, the core should only create entries for attributes that are
applicable to all families. 
The only attribute that is present for all families is the 64-bit id.

Thanks,
Ben


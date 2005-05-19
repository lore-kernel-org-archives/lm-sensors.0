From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040412180029.424facf4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You should take a look at lm_sensors2/prog/hotplug/p4b_smbus.c and
> associated Makefile and README.
> 
> Beware however that in some (most?) cases, the SMBus is actually
> disabled/hidden simply because there's nothing on it.

Hm sorry, it looks like you *already* tried this and it didn't work.

It might be just because the LPC controller's id differs. The SMBus ID
should be the same. Just try replacing:

#define ICH4 0x24c0
#define ICH4_SMBUS 0x24c3

with

#define ICH4 0x24cc
#define ICH4_SMBUS 0x24c3

Maybe it'll work, who knows.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

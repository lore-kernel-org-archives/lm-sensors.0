From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040412175450.3310074a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> I've been trying to get the readings off a Centrino notebook (a
> Toshiba Satelite M30).
> 
> The sensor relevant pci entries (24c3/24c0) are missing:

You should take a look at lm_sensors2/prog/hotplug/p4b_smbus.c and
associated Makefile and README.

Beware however that in some (most?) cases, the SMBus is actually
disabled/hidden simply because there's nothing on it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

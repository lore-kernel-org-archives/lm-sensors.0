From: sensors-reply@Reaktor.HaDiKo.DE (Christoph Heine)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-viapro and via686a don't mix with linux-2.6.0-test1
Message-Id: <20030715142051.GA14443@h111.hadiko.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

With kernel 2.6.0-test1 (likely with lm-sensors 2.8.0 too), it is
possible to load both via686a and i2c-viapro, but only one of them will
work, depending on which was loaded first. 

The reason for this is, that both drivers feel responsible for
the VIA_82C686_4 and once the probe was successful, it is registered
only to the driver which was loaded first. (So, you can load another
driver for the device but the probe function will never get called). 

Sorry for not providing a patch, I have on clue how to fix this
properly.

Bye,
Christoph

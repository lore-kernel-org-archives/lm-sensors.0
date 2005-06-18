From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 18 Jun 2005 21:51:23 +0000
Subject: [lm-sensors] Asus A8000 (SMBus 2Eh) Inquiry/Request
Message-Id: <42B47B29.2070208@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
In-Reply-To: <20050618063459.94021.qmail@web60417.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi thank you for a report.
> Sensor
> * Asus A8000 (SMBus 2Eh)
> 
> Temperature
> * Motherboard
> * CPU
> * /dev/hda
> * /dev/sda
> 
> Fans
> * CPU
> * Chasis (Case)
> 
> Voltages
> * CPU Core
> * +2.5 V
> * +3.3 V
> * +5 V
> * +12 V
> * VTR

This chip may be compatible with lm85

you need to load your bus driver
modprobe i2c-i801
(most likely)
modprobe lm85 force=0,0x2e

Then you can run:
 sensors

To see some results. Please send them back to us. Above is a bit dangerous. Be sure that your fans will spin when the system is under load
or reboot the notebook after you obtained the results. As far I could see from the dump the temperatures should be reported OK.

If "no chips found" please look to log what has gone wrong.

Good luck.

Regards

Rudolf

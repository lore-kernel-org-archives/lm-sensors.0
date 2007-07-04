From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Jul 2007 06:37:19 +0000
Subject: Re: [lm-sensors] ADT7467
Message-Id: <20070704083719.68d638f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <681988.38608.qm@web92003.mail.cnb.yahoo.com>
In-Reply-To: <681988.38608.qm@web92003.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dong,

On Tue, 3 Jul 2007 01:30:24 +0800 (CST), Dong Li wrote:
> I installed an ADT7467 evaluation board on my motherboard. The
> sensors-detect (lm-sensor 10.3) can detect it in my system
> (linux kernel 2.6.21).
> 
> ***********************************************************
> Driver 'to-be-written' (should be inserted)
> Detects correctly
> * Bus ''SMBUS PIIX4 adapter at 0500"
>   Busdriver 'i2c-piix4', I2C address 0x2e
>   Chip 'Analog Device ADT7467 or ADT7468' (Confidence:7)
> 
> *************************************************************
> However when I run the sensors-detect again, it can't detect the
> ADT7467 any more. Only after I reboot the system and run
> sensors-detect, it can detect it again.
> 
> Any comment here?
> (...)
> By the way, the evaluation board attached to the motherboard
> through PCI bus.

I have such an evaluation board from Analog Devices too, and I could
never get it to work properly when plugged into a PCI slot. So instead,
I powered it using the molex connector (+5V and +12V) and the USB
connector (+3.3V), and I connected the I2C bus directly to the
motherboard (I have an SMBus header on my motherboard.) As far as I
remember, that worked well. Maybe you want to try that way too.

BTW, you also need to make sure that you do not have another chip at
address 0x2e on this I2C bus, for example a hardware monitoring chip on
the motherboard itself. Otherwise it'll never work.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

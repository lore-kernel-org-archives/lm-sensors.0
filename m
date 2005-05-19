From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-801 (fwd)
Message-Id: <20021124192348.13e316b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200211192101.gAJL1Vj03615@shire.frodo.local>
In-Reply-To: <200211192101.gAJL1Vj03615@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Mark, Phil, any idea?
Is it supposed to be fixed in the CVS?

Begin forwarded message:

Date: Sun, 24 Nov 2002 14:21:00 +0000
From: Szabolcs Barsony <bvelvet@freemail.hu>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c-801


Hi,

I have run sensors-detect and it did not find anything. I have read the
Docs as well.
According the "SUPPORTED I2C BUS DEVICES - STATUS" table i2c-i801 driver

supports 82801AA, BA, CA, CAM, DB chips. When i do "modprobe i2c-i801" I
got the following error message:
Nov 24 14:16:00 localhost kernel: i2c-core.o: i2c core module
Nov 24 14:16:00 localhost kernel: i2c-i801.o version 2.6.5 (20020915)
Nov 24 14:16:00 localhost kernel: i2c-i801.o: Error: Can't detect I801, 
function 3!
Nov 24 14:16:00 localhost kernel: i2c-i801.o: I801 not detected, module
not inserted.

I have checked i2c-i801.c and it does not recognise PCI ID of my
chipset.
Will it help if I add my PCI ID to the list?

Regards,
Szabolcs


On Friday 22 November 2002 22:09, you wrote:
> > I have a notebook with the following devices. Is it supported by the
> > lm_sensors package? If not is there any chance to be supported?
>
> Please run sensors-detect before asking this kind of question. Read
> the docs, too. We can't help you if you don't help yourself first.

-- 
      .-.
     /v\    L   I   N   U   X
    // \\  >Phear the Penguin<
   /(   )\
    ^^-^^
___________________________________
Linux is like a wigwam. No gates, no windows just an apache inside.





-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

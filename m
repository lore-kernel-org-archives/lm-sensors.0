From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 16 Sep 2005 11:56:21 +0000
Subject: [lm-sensors] sensord and RAM SPD
Message-Id: <yBt03L31.1126863972.0366910.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050916094258.GA26164@bode.aurel32.net>
In-Reply-To: <20050916094258.GA26164@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Aurelien,

[Aurelien Jarno]
> sensord currently fails decode correctly RAM SPD in most cases
> and thus fails to determine the RAM size. It seems the corresponding
> code is a bit outdated.
>
> Please find attached a patch to fix that. Most of the code is taken
> from sensors.

Considering that:
* the code was outdated for a long time and nobody complained;
* SPD EEPROMs are not sensors;
* SPD EEPROM values never change;
* eeprom support will be ultimately dropped from libsensors;
I'd prefer that we plain drop eeprom support from sensord.

Thanks,
--
Jean Delvare

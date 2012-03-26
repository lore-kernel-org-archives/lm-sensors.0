From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 Mar 2012 20:47:13 +0000
Subject: Re: [lm-sensors] Not detecting all fan RPMs
Message-Id: <20120326224713.0378a02d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
In-Reply-To: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Mar 2012 12:21:25 -0800, Glenn Hollowell wrote:
> 
> Thanks Jean and Guenter, see below for SENSORS -version and -detect. gh
> 
> user@dfdot-user1:~> sensors -v
> sensors version 3.3.2 with libsensors version 3.3.2 
> user@dfdot-user1:~> sensors-detect
> # sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
> # System: To Be Filled By O.E.M. To Be Filled By O.E.M. [To Be Filled By
> O.E.M.]
> # Board: ASRock 880G Extreme3
> (...)
> Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-3)
> Do you want to scan it? (yes/NO/selectively): yes
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)

No extra hardware monitoring chip found I'm afraid, which suggests
multiplexed fan input pin. Which we can't support without detailed
board schematics which you'll most likely never obtain from the vendor.
And even then, supporting that would be a mess.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

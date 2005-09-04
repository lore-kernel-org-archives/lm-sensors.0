From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Sep 2005 14:04:08 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <20050904140404.170a98be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Grant,

> Something is there :)  Yes, there _is_ an lm78 onboard: LM78CCVF-J.
> (...)
> Next adapter: SMBus PIIX4 adapter at 5000
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x69

Not on SMBus.

> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!

Not here either...

Three possibilities: you have another I2C bus on the board, possibly
GPIO-driven, or the LM78 is at a different ISA address, or the LM78 is
at ISA 0x290 but detection fails.

Try loading the lm78 module with force_lm78=9191,0x290. Also try isadump
0x295 0x296. Both should give results if assertion #3 is correct.

If not, there's not much we can do without additional information about
your motherboard. Look at the manual for additional information or ask
the manufacturer directly. At least try to know what chip the LM78 is
wired to.

--=20
Jean Delvare

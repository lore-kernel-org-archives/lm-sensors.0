From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: FORCING A CHIP DRIVER
Message-Id: <20050213112535.52026db8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <420A513E.22821.4D0695@localhost>
In-Reply-To: <420A513E.22821.4D0695@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Udo,

> FORCING A CHIP DRIVER
> You asks on your webside for contacting you with the result if so
> 'forcing' a driver to load. Well, my ASUS A7V880 motherboard (ITE
> 8712F Super IO Sensors-Chip) and SuSE 9.1 works fine with Kernel
> driver `it87.o' using modprobe it87 force_it87=9191,0x0c00

Thanks for reporting.

What version of lm_sensors are you using? Since version 2.8.3 (or Linux
2.6.7), the address of the IT8712F chip can be autodetected, so you
should not need to force it anymore.

> Thanks to your excellent project 'lm_sensors'.

Thanks :')

--=20
Jean Delvare

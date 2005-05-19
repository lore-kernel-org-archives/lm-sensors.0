From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: IBM NetVista info
Message-Id: <1077554185.403a2c093f162@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0402231012030.19067@liberty.intra.assembly.state.ny.us>
In-Reply-To: <Pine.LNX.4.58.0402231012030.19067@liberty.intra.assembly.state.ny.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Zing Zing Shishak <shishz@alum.rpi.edu>:

> Here's my info from a sensors-detect run on a IBM NetVista TYPE
> 6792-2DU:
> 
>  BIOS vendor (ACPI): PTLTD
>  System vendor (DMI): IBM
>  BIOS version (DMI): 20KT43AUS

You must be using a slightly old version of sensors-detect, since we
removed the report request in newer releases of lm_sensors. Anyway,
thanks for the report.

It happens that I am personnaly looking for Netvista owners for tests on
another project of mine, dmidecode:
http://www.nongnu.org/dmidecode/

I would appreciate it much if you could get the CVS version of it and
give a try to the included "vpddecode" tool, and report results
(directly) to me. I plan to release a new version before the end of the
month, so testers are welcome.

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

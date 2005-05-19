From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: IBM Thinkpad A21p and lm-sensors
Message-Id: <20030913232545.1087cdec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063195270.14124.86.camel@kant.mcmillan.net.nz>
In-Reply-To: <1063195270.14124.86.camel@kant.mcmillan.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have an IBM Thinkpad A21p,and I believe that this model is more
> recent than those that are affected by the problems with lm-sensors.
> 
> Model Name: IBM Thinkpad A21p
> Model Number: 2629-HWA
> BIOS vendor (ACPI): PTLTD 
> System vendor (DMI): IBM
> BIOS version (DMI): KYET27WW (1.04b)
> 
> Can anyone confirm or deny that for me?

No, we can't. IBM could, but never provided the list we requested.

If you are willing to take the risk, you're free to edit the code to
bypass the checks (both in sensors-detect and i2c-piix4 if that
applies). If your thinkpad is recent, it's probably safe (but I'm not
liable in any way for saying that, I guess but I don't *know*). If you
do, please report. If you get anything working, we'll eventually start a
white list of known to work thinkpads.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

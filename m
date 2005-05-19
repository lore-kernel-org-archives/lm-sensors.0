From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c kernel patch issue with bttv-if module
Message-Id: <20030718144514.5a6348a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F16DAEA.1060802@themattpad.com>
In-Reply-To: <3F16DAEA.1060802@themattpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> >Almost everything is updated, so it may work for you.
>
> It does...sort of, temps are still off, but not by much (vs. BIOS)

Someone on this list (I can't remember who) once explained that the
temperature as shown in the BIOS screen is usually higher than the one
of an idling Linux system, because the loop that waits for a user event
in the BIOS screen is poorly designed and leads to a high CPU load.
Well, that may depend on the BIOS designer, but that may be your case.

You could think that comparing the values with another OS such as
Windows would lead to better results, but that's not necessarily true. I
remember my good old Pentium II 400 system had an idle temperature of 38
deg C under Windows 98 and 32 deg C under Linux (as reported by the BIOS
right after reboot, so it isn't a matter of which software was used). It
really depends on how each OS wastes its time, so to say.

Anyway, you most probably don't need a 1 degree accuracy. (BTW, most
people don't know that but most temperature sensors have an accuracy of
3 to 4 deg C, although they generally have a resolution of 1 deg C.)
What matters is not the "absolute" value. What matters is to know the
"normal value" to be able to detect overheating.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

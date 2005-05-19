From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Probs with lm-sensor and IBM TP 20
Message-Id: <20031228160832.383a9ecc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>  BIOS vendor (ACPI): PTLTD
>  System vendor (DMI): IBM
>  BIOS version (DMI): IYET59WW (1.20 )
>  Sorry, we won't let you go on. IBM systems are known to have
>  serious problems with lm_sensors, resulting in hardware failures.
>  For more information, see README.thinkpad or
>  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad.
>  We used two methods to determine your system's vendor, and they led
>  to different results. We'd appreciate to have feedback about such
>  systems. Please, take some time and contact the lm_sensors mailing
>  list at <sensors@stimpy.netroedge.com>.
>  We need the following information:
>   * The brand and model of your system
>   * The BIOS vendor (ACPI) displayed above
>   * The System vendor (DMI) displayed above
>  Thanks!

That's an IBM Thinkpad T20, isn't it?

Thanks for reporting. We have switched to a different detection method
though, using IBM's specific VPD records. We believe it should be more
reliable that way. Would you be wanting to try it out? Just get the CVS
version of sensors-detect here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

I am also working on a stand-alone VPD decoder as part of the dmidecode
project. If you are wanting to help here too, contact me directly and
I'll send you the source code (the project is hosted on Savannah, those
use isn't really convenient these days, as you may know already).

Thanks again!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: KT400a / VT8235
Message-Id: <20040125190541.170aa4d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075043549.1154.39.camel@flaptop>
In-Reply-To: <1075043549.1154.39.camel@flaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The other possibility to get temperature and/or fan information is
> > ACPI, especially for laptops. This is how I get temperature from
> > mine.
> 
> how did you get that to work, if i may ask? (i was under impression
> that ACPI used lm_sensors?)

Not at all. This is a completely different (and amazingy complicated)
thing. I can't even call it a driver since it does soooo many things
(from IRQ routing to power management and thermal control). There's not
much you have to do to get it work now that it is integrated into both
the 2.4 and 2.6 kernels. Enable ACPI and its "Thermal Zone" option while
configuring your kernel, and then browse /proc/acpi for information.
Especially the 'thermal_zone" subdirectory could be of interest to you.

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

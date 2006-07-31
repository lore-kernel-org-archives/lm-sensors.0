From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 31 Jul 2006 15:50:58 +0000
Subject: [lm-sensors] i810 adm1021
Message-Id: <20060731175058.426037de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1154355042.8040.29.camel@localhost>
In-Reply-To: <1154355042.8040.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> the information i posted above was AFTER i forced the use of the
> address. i have since unloaded the modules and i2cdump shows the same
> information. i am attaching herewith the output of decode-dimms.pl.
> seems nothing anomalous. what do you think?

Looks OK, else the checksums would be failing.

> i thought this SHOULD be a basic feature of laptops. oh well... do you
> think there is any other option for me to get CPU temperature (and fan
> control?)

On most laptops you can get one temperature from ACPI. Try loading the
"thermal" and "fan" modules, then take a look
in /proc/acpi/thermal_zone and /proc/acpi/fan, respectively.

You might also have a temperature sensor in your hard disk drive, which
you can read using smartmontools, or the dedicated tool "hddtemp". I
don't much like it because you need to be root to get the information.

Hope that helps,
-- 
Jean Delvare


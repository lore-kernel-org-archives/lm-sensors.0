From: j2fuentes@gmail.com (JF)
Date: Tue, 01 Aug 2006 15:29:33 +0000
Subject: [lm-sensors] i810 adm1021
Message-Id: <1154446173.24843.4.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1154355042.8040.29.camel@localhost>
In-Reply-To: <1154355042.8040.29.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2006-07-31 at 17:50 +0200, Jean Delvare wrote:
> On most laptops you can get one temperature from ACPI. Try loading the
> "thermal" and "fan" modules, then take a look
> in /proc/acpi/thermal_zone and /proc/acpi/fan, respectively.
> 

thanks for the suggestions. i have loaded the "thermal" and "fan"
modules, however, the directories /proc/acpi/thermal_zone
and /proc/acpi/fan are still empty. well, i guess that means there is no
monitoring tool whatsoever. 

> You might also have a temperature sensor in your hard disk drive, which
> you can read using smartmontools, or the dedicated tool "hddtemp". I
> don't much like it because you need to be root to get the information.
> 
> Hope that helps,

with hddtemp, at least i can get the temperature of my HD. thanks
again..



From: Charles <c@catcons.co.uk>
Date: Mon, 05 Dec 2011 14:26:30 +0000
Subject: Re: [lm-sensors] Kernel module asus_atk0110
Message-Id: <4EDCD1C6.40307@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EDA27AA.7030203@catcons.co.uk>
In-Reply-To: <4EDA27AA.7030203@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/12/11 18:33, Luca Tettamanti wrote:
> Hi,
> 
[snip]
> 
> It's not easy to do, proper detection would require the full ACPI
> stack in userspace.
> 
[snip]
> You shouldn't need to load the driver manually; if it's not
> auto-loaded then your board is not recognized by the driver.
> ASUS has changed the ATK0110 interface from time to time, so hopefully
> a few tweaks is all that's needed.
> Please send me a copy of this file:
> /sys/firmware/acpi/tables/DSDT
> 
> Luca

Thanks Luca :)

Slackware loads (auto-loads?) modules via the /etc/rc.d/modules symlink.
 One problem may be that I am using a symlink target manually edited
from the 2.6.33.4 version instead of the 2.6.38.7 version.

ACPI modules in the original 2.6.33.4 version, commented out ready for
uncommenting by the sysadmin include (I have omitted "obviously"
irrelevant ones): button, fan, processor and thermal.  I disabled
acpi-cpufreq in favour of cpufreq_ondemand.  Would you like me to try
any changes?

I temporarily commented out w83627ehf and added asus_atk0110 then
removed kernel option acpi_enforce_resources=lax, rebooted and created a
file by catting /sys/firmware/acpi/tables/DSDT which I am sending you
off list.

Best

Charles





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

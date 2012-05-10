From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 May 2012 08:14:07 +0000
Subject: Re: [lm-sensors] asus_atk0110 doesn't work on motherboard P8B WS
Message-Id: <20120510101407.64f2a38b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAAF8EA.3070202@free.fr>
In-Reply-To: <4FAAF8EA.3070202@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Julien,

On Thu, 10 May 2012 01:08:26 +0200, ACCART Julien wrote:
> I'm trying to get sensors informations on Asus P8B WS but it doesn't work.
> 
> kernel : 3.2.15
> lm-sensors : 3.1.2
> 
> When I launch :
> modprobe asus_atk0110
> the module loads successfully (no message in dmesg and it is visible in 
> lsmod) but it doesn't create anything in /sys/class/hwmon/
> 
> Could you help me?

It would seem that Asus stopped implementing the ATK0110 ACPI interface
on recent boards. Most likely this is the case on your system. Maybe
Luca (Cc'd) can investigate and confirm.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

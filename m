From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 02 Nov 2012 09:09:23 +0000
Subject: Re: [lm-sensors] f71882fg not showing motherboard temps
Message-Id: <50938DC3.5020802@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5091A80D.3090101@embarqmail.com>
In-Reply-To: <5091A80D.3090101@embarqmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 11/02/2012 06:29 AM, Logan Freijo wrote:

<snip>

> Device 09 no longer shows up.
> ls -lR /sys/bus/pnp/devices/00\:09/
> and
> cat /sys/bus/pnp/devices/00\:09/id
> return "No such file or directory"
>

Yeah, that is due to the pnpacpi=off option you
are using, please boot without that (or any other
special options), and then repeat the 2 above
commands. This will give us an idea if it will be
feasible to fix this in a way which will not
require passing those special kernel cmdline
options.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

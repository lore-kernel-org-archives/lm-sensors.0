From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 11 May 2007 21:45:04 +0000
Subject: Re: [lm-sensors] hwmon K8 sensor in processor up to revision E.
Message-Id: <4644E3E0.6080008@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070511014240.1a5bb02c.miknix@gmail.com>
In-Reply-To: <20070511014240.1a5bb02c.miknix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please can you send the dsdt.bin table, output of sensors-detect and lspci?
Also what is your board manufacturer/model ?

do generate the dstd.bin do:

cat /proc/acpi/dsdt > /tmp/dsdt.bin


> Despite the K8 sensor my ACPI offers me two more sensors.
> $cat /proc/acpi/thermal_zone/THRC/temperature
> temperature:             55 C
> $cat /proc/acpi/thermal_zone/THRS/temperature
> temperature:             47 C

Hmm this is bit strange. The CPU seems to be totally idle.

> "Temperature known as TCaseMax was specified for processors up to revision E.
> This temperature is defined as temperature between heat-spreader and CPU
> case, so the internal CPU temperature supplied by this driver can be higher.
> There is no easy way how to measure the temperature which will correlate
> with TCaseMax temperature."


This is something different. Lets find out from sensors-detect and dsdt table 
where does acpi take the infos.

Thanks,
Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

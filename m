From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 19 May 2009 09:11:15 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.29.3 1/1] hwmon: added support for the
Message-Id: <4A1277B3.5000906@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
In-Reply-To: <9EE81EBECB70824985BE0EDA8DC9B5150214E42C@VIECLEX01.frequentis.frq>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/19/2009 10:39 AM, Engelmayer Christian wrote:
> From: Christian Engelmayer<christian.engelmayer@frequentis.com>
>
> Added support for the GPIO definition/status registers and the alarm
> enable/status
> registers provided by the MAX6650/MAX6651 fan-speed regulator and monitor
> chips.
>
> Signed-off-by: Christian Engelmayer<christian.engelmayer@frequentis.com>

<snip>

Hmm,

I'm not sure we should be exporting gpio functionality like this. First of
all the gpio function usually is fixed by how the IC is wired up, so I would
expect that to be set by the BIOS / firmware. And when not, this should be
set through a board configuration file, exporting this to userspace feels wrong.

The same can be said for toggling the pin when its an output, its function will
depend upon how its wired up again, and I would expect some higher level interface
(like an ACPI interface or whatever) expose its functionality in a more sane way.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

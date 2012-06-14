From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jun 2012 22:07:21 +0000
Subject: Re: [lm-sensors] w83627 driver bug report
Message-Id: <20120614220721.GA21037@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJWOtEk9=VgY_uS1ik91A1Pvh5iwM1vaC9rWGiGu3B+6wrajJw@mail.gmail.com>
In-Reply-To: <CAJWOtEk9=VgY_uS1ik91A1Pvh5iwM1vaC9rWGiGu3B+6wrajJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 14, 2012 at 09:33:01AM -0400, Igor Netkachev wrote:
> Greetengs,
> 
> 
> We experience permanent problem with w83627dhg driver on serveral machines.
> 
> Software version: lm_sensors-2.10.7-9.el5
> Sensors driver name: w83627dhg-isa-0a10
> OS: CentOS release 5.8 (Final)
> 
> 
> ======
> Description:
> ======
> We use lm_sensors together with nagios/nrpe check_sensors plugin in order to
> monitor sensors' status. The problem is that after editing sensors.conf
> according to our needs (e.g. ignoring inactive fans or setting min and max
> values for specific sensors) and applying the changes with "sensors -s"
> command, the sensor's configuration drops back to defaults at a random moment
> usually within ~5-30 hours after "sensors -s" has been run. This makes nagios/
> nrpe to set the false alarm and send an e-mail to the customer, and this brings
> us a lot of pain as long as it happens almost every night.
> 
> ====
> Example:
> ====
> Below there's sensors' output right after it fell back to defaults:
> 
> root@working ~ # sensors
> w83627dhg-isa-0a10
> Adapter: ISA adapter
> Case Fan: 11637 RPM  (min = 12053 RPM, div = 1) ALARM
> CPU Fan:  11739 RPM  (min =    0 RPM, div = 1) ALARM
> CPU Temp:  +38.0 C  (high =  +0.0 C, hyst = +60.0 C)  [CPU diode ]
> AUX Temp:  +29.5 C  (high = +45.0 C, hyst = +60.0 C)  [thermistor]
> vid:      +1.300 V
> 
> Running "sensors -s" again solves the problem...
> 
> root@working ~ # sensors -s
> root@working ~ # sensors
> w83627dhg-isa-0a10
> Adapter: ISA adapter
> Case Fan: 11440 RPM  (min = 6026 RPM, div = 2)
> CPU Fan:  11637 RPM  (min = 6026 RPM, div = 2)
> CPU Temp:  +38.0 C  (high = +56.0 C, hyst = +60.0 C)  [CPU diode ]
> AUX Temp:  +29.5 C  (high = +45.0 C, hyst = +60.0 C)  [thermistor]
> vid:      +1.300 V
> 
> but only for ~5-30 hours, until it drops back to defaults again.
> 
> At the moment we haven't found any dependencies between the bug itself and os/
> chassis, it occurs on different machines and OSes (so far we had it on CentOS 5
> /6 and Debian 5/6).
> Please investigate. Feel free to request any additional information you might
> need.
> 
Hi Igor,

it almost looks like the chip might reset itself.

Of course that could be caused by anything, but it is odd that it happens 
on multiple machines. Do those machines use IPMI or ACPI to access the chip,
by any chance ? ASUS systems do that, for example, and the use of a hwmon chip
driver is generally not recommended for such machines and may cause all sorts
of issues.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

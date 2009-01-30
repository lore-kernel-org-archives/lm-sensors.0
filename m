From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:23:06 +0000
Subject: Re: [lm-sensors] Chassis intrusion detection
Message-Id: <20090130182306.5e02b268@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
In-Reply-To: <f188924b0901240908g1fde798fsfaba824938e9dc03@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

On Sat, 24 Jan 2009 18:08:47 +0100, Fred . wrote:
> Some computer cases (chassis) have a switch that gets triggered if the
> case is opened, this sends a signal to the motherboard via a wire
> connected to the switch.
> 
> Can lm_sensors read this? Does lm_sensors have support for this?

Some of our hardware monitoring drivers have support for this feature.
However we don't have an established standard for it. libsensors
doesn't have support.

> How do I use it?

Read the documentation of your hardware monitoring driver, and look for
the appropriate sysfs attribute somewhere under /sys/class/hwmon.

> Can I have a script that wipes encryption keys if the case is opened?

We don't have anything like that, so you'll have to write some custom
code if you need to do this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

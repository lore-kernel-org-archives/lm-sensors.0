From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 13 Mar 2006 09:31:49 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <0syt0ZSj.1142242309.3381560.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Harald,

On 2006-03-12, Harald Dunkel wrote:
> > I've replied to you on the LKML already:
> > http://lkml.org/lkml/2006/3/8/52
>
> Sure, in this posting you suggested to follow-up on this topic
> on this mailing list, including the version of sensors and the
> output of sensors-detect on this mailing list. Please also
> note that on the second run the sensor has changed to
> "thermistor".

When moving a discussion from one list to another, it's usually
appreciated that you mention the original thread, so that new readers
know what has already been said and don't start again from scratch.
Nevermind, and sorry for the fresh welcome ;)

I don't see the version of lm_sensors in your second report, I'll
assume 2.10.0.

I'm surprised that the thermal sensor types changed from "diode" to
"thermistor". These settings are not supposed to change on their own.
Did you change anything in your configuration file? It probably doesn't
matter much here, as these inputs seem to be unused, but I'm curious.

The output of sensors-detect is interesting:

> Next adapter: SMBus I801 adapter at 5000
> (...)
> Client found at address 0x2d
(All Failed)
> Client found at address 0x2f
(All Failed)

These are typical addresses for hardware monitoring chips, so I start
suspecting that one of these is your real fans + temperatures sensor
chip, either a recent or rare type which we don't know about yet.

Please provide the output of the following commands (which will dump the
contents of these chips for further analysis) as root:

modprobe i2c-dev
i2cdump 0 0x2d b
i2cdump 0 0x2f b

Thanks,
--
Jean Delvare


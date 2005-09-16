From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 16 Sep 2005 16:15:31 +0000
Subject: [lm-sensors] sensord and RAM SPD
Message-Id: <Muh67ezs.1126879592.8517790.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050916094258.GA26164@bode.aurel32.net>
In-Reply-To: <20050916094258.GA26164@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

[David Goodenough]
> One little comment, while eeprom support may not really be a
> sensor, it is a almost always there and when someone says that
> they can not get sensors working if eeprom works then at least
> the basics are working properly,

What it actually means is that the SMBus driver is functional. This
doesn't really help, because cases of non-working SMBus drivers are
rather rare.

Most hardware monitoring devices these days are embedded in Super-I/O
chips. For these, we do not care about the SMBus and eeprom is of no
help.

Also, missing eeproms don't prove anything, there are motherboards which
do not expose their SPD EEPROMs on the SMBus. So it's a hint at best.

> its just a matter of finding the
> right chip for sensing (and in many economy boards there are
> none).  I think it is useful in initial setup and if it causes no
> problems it should be retained for that reason alone.

I know others (MDS I think) agree with you, but I don't.

From a support point of view, it does not make any difference when a user
reports "no sensors found" with or without eeproms in "sensors". In
any case we have to ask him/her for a full sensors-detect output, or
i2cdetect output, and/or lspci output, before we can conclude or ask
him/her fore more. The fact that the SMBus is working is an information
we can use only in later steps of the investigation, because
non-functional SMBus are the least probable cause of problems. It's so
rare that I don't mind having to ask explicitely.

Since linux 2.6.14-rc1, the hardware monitoring drivers have a dedicated
class, eeprom doesn't have it. Since lm_sensors 2.9.2, eeproms are no
longer shown to Linux 2.6 users, even for older 2.6 kernels. We may keep
support for some times, not to disturb 2.4 kernel users, but that's
about it. Look at the eeprom-specific code in libsensors, you'll see
why I want to get rid of it. It just doesn't fit in the picture.

If you really want to check whether the SMBus is working or not,
i2cdetect and i2cdump will do it. If you think they are too hard to use
for the average user, you can add an automatic mode to i2cdetect, which
will list all available busses and probe them all. You may have it dump
the contents of chips in the 0x50-0x57, these are certainly EEPROMs.
These are disgnostics tools, they are meant for the job, I don't mind
extending them. Sensors and libsensors are no diagnostics tools.

Thanks,
--
Jean Delvare

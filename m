From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: p4b_smbus and other modules
Message-Id: <20040209194813.7b1a7769.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <485309134.20040121132926@spin.it>
In-Reply-To: <485309134.20040121132926@spin.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On my Asus P4PE, Mandrake Linux 9.0, lm_sensors 2.8.2, sensors works
> fine if I manually issue the following commands:
> 
> insmod p4b_smbus
> modprobe i2c-core
> modprobe i2c-i801
> modprobe i2c-dev
> modprobe i2c-proc
> modprobe asb100
> 
> (BTW, is i2c-dev really needed? And what about module "eeprom", which
> sensors-detect suggested to add? I suppose it's related to the "Chip
> `SPD EEPROM'" it detects, but I don't know what it is...)

I2c-dev is only needed for raw access to the chips. Typically this is
needed by sensors-detect, and not anymore after that. So you can skip it.

SPD EEPROM is something different, provided by the eeprom module. This
is related to memory modules present on your system. Memory modules have
an EEPROM with information that can be accessed through i2c busses, so
we have a driver for them in our package, although these are not
sensors.

> The problem is that, when issuing the first command "insmod
> p4b_smbus", lots of error lines are reported to syslog.
> If I add p4b_smbus in /etc/modules to make it load at boot time, those
> errors appear again, preventing other non-i2c modules from loading
> correctly.
> 
> I attach the error log. As you can see, all following i2c modules are
> loaded fine (last six lines in the file).
> 
> Moreover, I found a p4b_smbus module already installed on my system:
> /lib/modules/2.4.19-35mdk/kernel/3rdparty/p4b_smbus/p4b_smbus.o.gz
> 
> While I manually copied the one built from lm_sensors sources here:
> /lib/modules/2.4.19-35mdk/kernel/drivers/hotplug/p4b_smbus.o

You should never have two modules with the same name. This is likely to
cause the problem you encounter. You should rename one of them so you
are sure to load the one you want. That said, their module may work as
well, so you could simply consider not using lm_sensors' one.

> When I do insmod by hand, the system tells me it's using the latter.
> Now, you might have understood that I'm rather newbie with regards to
> modules... what should I do with these two modules? Where should I
> copy the new one? What should I do with the old one? Is this related
> to the errors reported?

Maybe removing the new one will solve the problem directly. If not, this
may be a distribution-related problem of hotplug stuff. You could try
telling your system not to handle the p4b_smbus module as a hotplug one.
I don't know much about hotplug but I think you just need to add it to
/etc/hotplug/blacklist.

With a single module named p4b_smbus and the system not taking care
about it in your back, I'd expect the insmod to be much quiter.

Hope that helps and sorry for not answering before, I don't know much
about hotplug and was hoping that someone with more knowledge would
answer.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

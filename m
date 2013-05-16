From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 May 2013 11:37:11 +0000
Subject: Re: [lm-sensors] Linux drivers
Message-Id: <20130516133711.1d753eef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB68DB2AA0F98748814ADCB4C9FBCE4716BAAC18@DNCE04.ent.ti.com>
In-Reply-To: <BB68DB2AA0F98748814ADCB4C9FBCE4716BAAC18@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 16 May 2013 12:53:09 +0200, Jean Delvare wrote:
> On Thu, 16 May 2013 09:06:40 +0000, Van Lembergen, Lieven wrote:
> > -              extended temperature enabling without patching the init?? Can that be done?
> 
> The driver doesn't yet support the extended temperature format. This
> could be added, you can either contribute it as a patch or wait for (or
> even sponsor) someone to implement it for you.

Sorry, I meant: setting (or clearing) the extended temperature format
is not supported. The extended temperature format itself is supported
already.

The proper mode is supposed to have been set by the BIOS/firmware. If
for some reason this doesn't work for you, the proper way would be to
pass the setting as platform data when you instantiate the device. If
for some reason you can't do that, you can overwrite the configuration
register using i2cset (from package i2c-tools) and the i2c-dev driver,
before the tmp401 driver gets loaded.

We _could_ add a module parameter or a sysfs attribute to select it,
but this means extra code in the driver, and caution is needed because
the value of many registers depend on the format so we would have to
update them all at once to preserve existing settings. A module
parameter would be suboptimal because all chips handled by the driver
would need to have the same setting.

Yet another approach would be to auto-select the range depending on
which limits are set. This means even more code, but has the advantage
to not introduce a new interface.

Guenter, what do you think?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

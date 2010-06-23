From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Jun 2010 12:38:19 +0000
Subject: Re: [lm-sensors] Starting up sensors failed
Message-Id: <20100623143819.5b67698b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTin5YgS58dgFucaJc1byomXnF0m0p5_n-YgezrL-@mail.gmail.com>
In-Reply-To: <AANLkTin5YgS58dgFucaJc1byomXnF0m0p5_n-YgezrL-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Jun 2010 14:17:38 +0200, borat Gunter wrote:
> Hello Everyone,
> 
> i have done the *sensors-detect*, and the summary output looks like:
> 
>  *Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus PIIX4 adapter at 0440'
>     Busdriver `i2c-piix4', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 1)

If you see this, this means you are running a VERY old version of
sensors-detect. So, try the latest version first [1], and then report
again if it still doesn't work.

[1] http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

> 
> I will now generate the commands needed to load the I2C modules.
> 
> To make the sensors modules behave correctly, add these lines to
> /etc/modprobe.conf:
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> To load everything that is needed, add this to some /etc/rc* file:
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-piix4
> # I2C chip drivers
> modprobe eeprom
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----cut here----
> 
> WARNING! If you have some things built into your kernel, the list above
> will contain too many modules. Skip the appropriate ones! You really should
> try these commands right now to make sure everything is working properly.
> Monitoring programs won't work until it's done.
> 
> Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
> insserv: can not symlink(../arkeia, rc2.d/S06arkeia): File exists
> insserv: can not symlink(../arkeia, rc3.d/S06arkeia): File exists
> insserv: can not symlink(../arkeia, rc4.d/S06arkeia): File exists
> insserv: can not symlink(../arkeia, rc5.d/S06arkeia): File exists

These errors come from your distribution and are unrelated to
lm-sensors.

> 
> *and then i tried to ignore these error message to start the sensors,
> unfortunately failed.
> *:~ # /etc/init.d/lm_sensors start
> Starting up sensors:                                                 failed*
> 
> Can somebody help me? What does insserv mean? And how to correct it?

"failed" isn't descriptive enough for us to help you. You'll have to
figure out which command in /etc/init.d/lm_sensors (which again is part
of your distribution and not lm-sensors) failed.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

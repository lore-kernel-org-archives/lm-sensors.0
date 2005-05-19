From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Ticket #1764
Message-Id: <20040903110311.M50543@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> To make the sensors modules behave correctly, add these lines to
> /etc/modules.conf:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> options it87 ignore=-1,0x290
> #----cut here----
> 
> To load everything that is needed, add this to some /etc/rc*
> file:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-viapro
> modprobe i2c-isa
> # I2C chip drivers
> modprobe lm90
> modprobe eeprom
> modprobe it87
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
> #----cut here----

OK so basically sensors-detect found two sensors on your system, an IT87xx and
an LM90.

The only error it did is about this line:
  options it87 ignore=-1,0x290
Do *not* add this line to modules.conf, it if not needed and will actually
prevent your IT87xx from being properly detected. The problem is supposed to
be fixed in newer versions of the script.

Then your system should be working quite fine after you either load the
drivers manually or restart your system so that the init scripts trigger.

I'll update the ticket with this information.

-- 
Jean Delvare
http://khali.linux-fr.org/

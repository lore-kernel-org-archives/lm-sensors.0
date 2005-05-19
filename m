From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <20041016090904.79d09520.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <416FDE52.2040804@liv.ac.uk>
In-Reply-To: <416FDE52.2040804@liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Richard,

> thanks for the quick response. Now have a consistent 2.8.8 installed, 
> the output of sensors-detect is now:
> (...)

This at least confirms that you have a single monitoring chip on your
board, a Winbond W83627HF (as advertised by Tyan).

> Driver `w83781d' (should be inserted):
>    Detects correctly:
>    * Bus `SMBus I801 adapter at 1460' (Non-I2C SMBus adapter)
>      Busdriver `i2c-i801', I2C address 0x2d (and 0x48 0x49)
>      Chip `Winbond W83627HF' (confidence: 8)
> 
> Driver `w83627hf' (should be inserted):
>    Detects correctly:
>    * ISA bus address 0x0c00 (Busdriver `i2c-isa')
>      Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

Sensors-detect is broken here, it should NOT tell you to load the
w83781d driver. I'm not sure how we can fix that though. Both drivers
support your chip, but only one should be loaded at any given time. The
w83627hf driver is prefered in your case.

> To load everything that is needed, add this to some /etc/rc* file:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> modprobe i2c-isa
> # I2C chip drivers
> modprobe w83781d
> modprobe w83627hf
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
> #----cut here----

Remove i2c-i801 and w83781d from that list.

> This gives two entries in /proc, w83627hf-i2c-0-2d which reads 0 in
> all cases, and w83627hf-isa-0c00, which has broken cpu temps as
> before.

Of course, because the latter prevents accesses from the former.

Please edit your init files as required so as to only load the w83627hf
and i2c-isa drivers, then cold reboot your system. Not certain it'll
help for the temperatures but at least we will have a sane base to work
on.


-- 
Jean Delvare
http://khali.linux-fr.org/

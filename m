From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: lmsensors on Sony PCG-GRX416G
Message-Id: <Pine.LNX.4.58.0502060924040.7839@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502060103.00747.lists@localguru.de>
In-Reply-To: <200502060103.00747.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

If it is the notebook, and it seems so, chances are minimal.
Often they use proprietary controllers so no chance.

You can get temps working by acpi.

If acpi doesnt work try to fix it.

First try to find custom DSDT table for your notebook
(acpi.sf.net)

If you still dont have it here is the "cookbook"

http://forums.gentoo.org/viewtopic.php?t2145

Good luck.

Regads

Rudolf


On Sun, 6 Feb 2005, Marcus Schopen wrote:

> Hei,
>
> is there a chance to get lm-sensors running on a PCG-GRX416G ?
>
> I build i2c 2.8.8 and lmsensors 2.8.8 against a vanilla 2.4.29 kernel. Result
> of sensors-detect:
>
> /etc/modules.conf:
>
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
>
> To load everything that is needed, add this to some /etc/rc* file:
>
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # I2C chip drivers
> modprobe eeprom
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
> #----cut here----
>
> But sensors doesn't find any sensors.
>
> Thanks,
> Marcus
>
>

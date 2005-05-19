From: yml@yml.com (Yermo M. Lamers)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Unresolved Symbols question lm_sensors 2.8.0/i2c 2.8.0/linux
Message-Id: <3F7D08DA.5010509@yml.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F7B83FF.2060409@yml.com>
In-Reply-To: <3F7B83FF.2060409@yml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>I am getting an unresolved symbol (dmi_scan_match) trying to install 
>>lm_sensors 2.8.0 and i2c 2.8.0 under stock RedHat Linux 9.0 install.
> 
> This symbol is exported by the dmi_scan module, which ships with
> lm_sensors. Don't you have it? You really should, if you were able to
> compile i2c-piix4.

Yea, I crawled through the code. I believe it's either user error on my 
part or a bug.

i2c-piix4 compiled just fine:

root@nbi_master lm_sensors-2.8.0]# find . -name "*piix4*"
./doc/busses/i2c-piix4
./kernel/busses/i2c-piix4.c
./kernel/busses/i2c-piix4.d
./kernel/busses/i2c-piix4.o

[root@nbi_master lm_sensors-2.8.0]# find . -exec fgrep -l dmi_scan_mach 
{} \;
./kernel/busses/dmi_scan.c
./kernel/busses/i2c-piix4.c
./kernel/busses/i2c-piix4.o

Maybe it's something simple stupid I did (wouldn't be the first time).

Build i2c-2.8.0
make, make install, depmod -aij

build lm_sensors

make, make install, depmod -a

do the ldconfig thing.

do the sensors-detect thing.

get the unresolved symbol I reported.

How is dmi-scan linked in?

---------------------------------------------------------------------
DTLink Software                                 http://www.dtlink.com
---------------------------------------------------------------------

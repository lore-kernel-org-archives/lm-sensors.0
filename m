From: kress@hal.saar.de (Michael Kress)
Date: Sun, 08 Oct 2006 10:59:42 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <4528DA1E.4070206@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:
> BTW, lm-sensors SVN now has userspace support for that new driver too,
> so you can pick it and install it:
> http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4197-20061007.tar.bz2
>   
Is there a working, more current spec file available around for building
the package as an rpm? There's old ones included in the snapshot
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4197-20061007.tar.bz2
(versions 2.5.0 and 2.8.3)
(My distribution is a centos-4.4)
I tried the one from the centos-4.4 src rpm, but evidently this didn't
work because of all the patches bundled with it.

The sensors-detect recognizes the chip:
Found `Nat. Semi. PC87427 Super IO Fan Sensors'             Success!
    (address 0x840, driver `pc87427')
Found `Nat. Semi. PC87427 Super IO Health Sensors'          Success!
    (address 0x880, driver `to-be-written')
Driver `pc87427' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0840 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87427 Super IO Fan Sensors' (confidence: 9)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0880 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87427 Super IO Health Sensors' (confidence: 9)

[root at matrix lm-sensors-r4197-20061007/prog/sensors]# ./sensors
pc87427-isa-0840
Adapter: ISA adapter

Regards - Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L



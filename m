From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 12:21:36 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061008142136.5b6634cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Michael,

> Jean Delvare wrote:
> > BTW, lm-sensors SVN now has userspace support for that new driver too,
> > so you can pick it and install it:
> > http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4197-20061007.tar.bz2
> >   
> Is there a working, more current spec file available around for building
> the package as an rpm? There's old ones included in the snapshot
> http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4197-20061007.tar.bz2
> (versions 2.5.0 and 2.8.3)
> (My distribution is a centos-4.4)
> I tried the one from the centos-4.4 src rpm, but evidently this didn't
> work because of all the patches bundled with it.

Indeed I see that our spec files are completely out-of-date. And nobody
complained as far as I can remember, so I guess people simply don't
care. In most cases, if you use an rpm-based distribution nowadays,
you'll simply install the packages that come with the distribution
itself, rather than building your own.

If you really want to repackage a rpm based on a different package
version, I guess you're better starting from the .spec file that your
distribution is using for lm_sensors. As you mentioned, you'll have to
deal with extra patches, but either these patches fix things we have
already fixed upstream by now and you can drop them, or they add things
which are specific to your distribution, and you will want these
changes in your package.

Given that every distribution is different, and different versions of
rpm support a different set of features, I fail to see the point in
shipping .spec files at all. They are better maintained by each
distribution. So I propose that we simply delete this RPM directory
from both our i2c and lm-sensors trees. Objections anyone?

> The sensors-detect recognizes the chip:
> Found `Nat. Semi. PC87427 Super IO Fan Sensors'             Success!
>     (address 0x840, driver `pc87427')
> Found `Nat. Semi. PC87427 Super IO Health Sensors'          Success!
>     (address 0x880, driver `to-be-written')
> 
> Driver `pc87427' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0840 (Busdriver `i2c-isa')
>     Chip `Nat. Semi. PC87427 Super IO Fan Sensors' (confidence: 9)
> 
> Driver `to-be-written' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0880 (Busdriver `i2c-isa')
>     Chip `Nat. Semi. PC87427 Super IO Health Sensors' (confidence: 9)

Good.

> [root at matrix lm-sensors-r4197-20061007/prog/sensors]# ./sensors
> pc87427-isa-0840
> Adapter: ISA adapter

Not so good. You should see all the values here. I suspect your new
"sensors" links with an old libsensors. You can check with "sensors -v"
or "ldd sensors".

If you did not install libsensors yet, this is expected. You can force
the new libsensors to be used by adding
$HOME/lm-sensors-r4197-20061007/lib to $LD_LIBRARY_PATH (and exporting
it if needs be.)

Or you can install the library to /usr/local/lib, in which case you'll
need to make sure that /etc/ld.so.conf contains this directory. And you
may have to disable the one in /usr/lib to make sure it doesn't get in
the way.

Hope that helps,
-- 
Jean Delvare


From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 05 Dec 2008 23:44:15 +0000
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <Pine.LNX.4.64.0812051727520.19384@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081203182216.5be504cf@hyperion.delvare>
In-Reply-To: <20081203182216.5be504cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 5 Dec 2008, Jean Delvare wrote:
> [IPMI probe in its own section] This is done now.

The words look good to me.  This is a lot better than suddenly having
the "IPMI Only" option appear in the ISA probing question IMHO.

> No, I do not want to refer to URLs. Administrators running
> sensors-detect in a text-only environment won't enjoy it, and I don't
> want to maintain a web page with extra documentation.

The second half is understandable, but the first half: I guess nobody
used the Web before GUIs were widely available.  :)  (I know: judging by
the numbers, this is almost true.)  But I can understand it: if you have
some huge package like a database, or a big end-user-oriented GUI
program like Gimp or OpenOffice or something, it's OK for some of the
docs to be on the Web.  If you are installing a relatively small
package, maybe on a headless server or one on which you haven't set up
the networking yet, having the documentation locally is preferable.

> Can you please fetch sensors-detect again from SVN and give it a try?

Done.

Short version: Nothing blew up, *and* the new version found everything
that the old (released with 3.0.3) version did.  I didn't have to give
any non-default answers to the new version.

Long version: I unloaded the relevant kernel modules to simulate running
sensors-detect on a system that hasn't had lm_sensors set up before.  I
didn't use any command-line arguments to sensors-detect, and I took all
the defaults by hitting "enter" at each prompt.  I did this for both the
version from lm_sensors 3.0.3 (sensors-detect version 5337) and the
latest version (sensors-detect version 5530).  This is on a system with
an Asus M2N-SLI Deluxe motherboard.

The results from version 5337 (shipped with 3.0.3):

---
Driver `to-be-written' (should be inserted):
    Detects correctly:
    * Bus `SMBus nForce2 adapter at 1c40'
      Busdriver `i2c-nforce2', I2C address 0x2e
      Chip `Analog Devices ADT7475' (confidence: 5)

Driver `it87' (should be inserted):
    Detects correctly:
    * ISA bus, address 0x290
      Chip `ITE IT8716F Super IO Sensors' (confidence: 9)

Driver `k8temp' (should be inserted):
    Detects correctly:
    * Chip `AMD K8 thermal sensors' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
# Chip drivers
# no driver for Analog Devices ADT7475 yet
modprobe it87
modprobe k8temp
/usr/local/bin/sensors -s
#----cut here----
---

The results from version 5530:

---
Driver `it87':
   * ISA bus, address 0x290
     Chip `ITE IT8716F Super IO Sensors' (confidence: 9)

Driver `to-be-written':
   * Bus `SMBus nForce2 adapter at 1c40'
     Busdriver `i2c-nforce2', I2C address 0x2e
     Chip `Analog Devices ADT7475' (confidence: 5)

Driver `k8temp':
   * Chip `AMD K8 thermal sensors' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
modprobe it87
# no driver for Analog Devices ADT7475 yet
modprobe k8temp
/usr/local/bin/sensors -s
#----cut here----
---

The probe order with 5530 was:

southbridge/CPU/memory
super I/O
IPMI
ISA
SMBus

I got the new script via svn this time, so the $Revision$ was replaced
with the actual version number.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

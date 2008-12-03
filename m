From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 03 Dec 2008 21:55:12 +0000
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <Pine.LNX.4.64.0812031543270.18140@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081203182216.5be504cf@hyperion.delvare>
In-Reply-To: <20081203182216.5be504cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 3 Dec 2008, Jean Delvare wrote:
> So, I would like users to give a try to the latest version of
> sensors-detect and report if it works fine for them or not.

Short version: Nothing blew up, but the new version didn't find
something that the old version did, until I gave different options to
the new version.

Long version: I unloaded the relevant kernel modules to simulate running
sensors-detect on a system that hasn't had lm_sensors set up before.  I
didn't use any command-line arguments to sensors-detect, and I took all
the defaults by hitting "enter" at each prompt.  I did this for both the
version from lm_sensors 3.0.3 (sensors-detect version 5337) and the
latest version.  This is on a system with an Asus M2N-SLI Deluxe
motherboard.

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

The results from the first run of the new version, taking all defaults:

---
Driver `it87':
   * ISA bus, address 0x290
     Chip `ITE IT8716F Super IO Sensors' (confidence: 9)

Driver `k8temp':
   * Chip `AMD K8 thermal sensors' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
modprobe it87
modprobe k8temp
/usr/local/bin/sensors -s
#----cut here----
---

The difference is that it didn't find the adt7475.  I re-ran the new
version of sensors-detect, supplying non-default answers, in an attempt
to get it to find the adt7475.  Here are the places where I gave
non-default answers, and the results.

---
Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/no/IPMI ONLY): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Next adapter: SMBus nForce2 adapter at 1c00 (i2c-4)
Do you want to scan it? (yes/NO/selectively): yes
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!

Next adapter: SMBus nForce2 adapter at 1c40 (i2c-5)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x2e
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85'...                No
Probing for `National Semiconductor LM96000 or PC8374L'...  No
Probing for `Analog Devices ADM1027'...                     No
Probing for `Analog Devices ADT7460 or ADT7463'...          No
Probing for `SMSC EMC6D100 or EMC6D101'...                  No
Probing for `SMSC EMC6D102'...                              No
Probing for `SMSC EMC6D103'...                              No
Probing for `Analog Devices ADT7467 or ADT7468'...          No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7475'...                     Success!
     (confidence 5, driver `to-be-written')
Probing for `Analog Devices ADT7476'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `Analog Devices ADM1024'...                     No
Probing for `National Semiconductor LM93'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Winbond W83L785TS-S'...                        No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `Analog Devices ADM1028'...                     No
Probing for `Texas Instruments THMC51'...                   No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Winbond W83791SD'...                           No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

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

Finally, here are some general comments on the new script.

> sensors-detect revision $Revision$

I assume this fixes itself when the script goes through the normal
release process.

> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (yes/no/IPMI ONLY):

You should include a few words in the help text about what IPMI ONLY
does and why you would want to choose it or not choose it.  Will the
script behave with options that have spaces in them?

I hope this helps!

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

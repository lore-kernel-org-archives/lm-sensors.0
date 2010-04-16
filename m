From: Marc <digitelp@yahoo.com>
Date: Fri, 16 Apr 2010 23:36:34 +0000
Subject: [lm-sensors] asus_atk0110 Not Activated  in lm_sensors-3.1.1-3
Message-Id: <697978.38728.qm@web31801.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi...

Runnig Rehat Fedora Core 12 with an Asus k8n-dre motherboard.  It has a NVI=
DE nFORCE Professional 2200 Chip as well as a Winbond W83627THF-A super i/o=
 chip. The linux kernel is kernel-2.6.32.11-99.fc12.x86_64.  Using lm_senso=
rs-3.1.1-3.fc12.x86_64

When I run sensors-detect I get the following

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83627THF/THG Super IO Sensors'             =20
    (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Everything else returns a no until...

Next adapter: SMBus nForce2 adapter at 4c40 (i2c-0)
Do you want to scan it? (YES/no/selectively):=20

Nothing in the summary about it.

The k8temp works fine.  I get temperatures.
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +35.0=B0C                                   =20
Core1 Temp:  +36.0=B0C                                   =20

k8temp-pci-00cb
Adapter: PCI adapter
Core0 Temp:  +36.0=B0C                                   =20
Core1 Temp:  +37.0=B0C                                   =20

But no fan speeds or anything else because when I attempt to load the w8362=
7hf modules I get the following:=20

FATAL: Error inserting w83627hf (/lib/modules/2.6.32.11-99.fc12.x86_64/kern=
el/drivers/hwmon/w83627hf.ko): No such device

Here is the lsmod

Module                  Size  Used by
fuse                   57189  2=20
hwmon_vid               2091  0=20
eeprom                  4947  0=20
i2c_dev                 7529  0=20
sunrpc                193819  1=20
cpufreq_ondemand        8793  2=20
powernow_k8            14706  2=20
freq_table              3947  2 cpufreq_ondemand,powernow_k8
ip6t_REJECT             4222  10=20
nf_conntrack_ipv6      18504  7=20
ip6table_filter         2791  1=20
ip6_tables             16760  1 ip6table_filter
ipv6                  279463  32 ip6t_REJECT,nf_conntrack_ipv6
uinput                  7228  0=20
amd64_edac_mod         15481  0=20
tg3                   101698  0=20
i2c_nforce2             6819  0=20
i2c_core               26876  3 eeprom,i2c_dev,i2c_nforce2
edac_core              39581  4 amd64_edac_mod
edac_mce_amd            7746  1 amd64_edac_mod
k8temp                  3735  0=20
raid1                  19043  2=20
dm_multipath           14558  0=20
ata_generic             3467  0=20
pata_acpi               3395  0=20
floppy                 54666  0=20
pata_amd               11269  4=20
sata_nv                20834  3=20

When I load the w83627ehf I get:
FATAL: Error inserting w83627ehf (/lib/modules/2.6.32.11-99.fc12.x86_64/ker=
nel/drivers/hwmon/w83627ehf.ko): No such device

When I try the w83781d it loads lsmod shows the following:
Module                  Size  Used by
w83781d                28749  0=20
fuse                   57189  2=20
hwmon_vid               2091  1 w83781d
eeprom                  4947  0=20
i2c_dev                 7529  0=20
sunrpc                193819  1=20
cpufreq_ondemand        8793  2=20
powernow_k8            14706  2=20
freq_table              3947  2 cpufreq_ondemand,powernow_k8
ip6t_REJECT             4222  10=20
nf_conntrack_ipv6      18504  7=20
ip6table_filter         2791  1=20
ip6_tables             16760  1 ip6table_filter
ipv6                  279463  32 ip6t_REJECT,nf_conntrack_ipv6
uinput                  7228  0=20
amd64_edac_mod         15481  0=20
tg3                   101698  0=20
i2c_nforce2             6819  0=20
i2c_core               26876  4 w83781d,eeprom,i2c_dev,i2c_nforce2
edac_core              39581  4 amd64_edac_mod
edac_mce_amd            7746  1 amd64_edac_mod
k8temp                  3735  0=20
raid1                  19043  2=20
dm_multipath           14558  0=20
ata_generic             3467  0=20
pata_acpi               3395  0=20
floppy                 54666  0=20
pata_amd               11269  4=20
sata_nv                20834  3=20

Running sensor-detect again produces original results and nothing is loaded=
 into the /etc/sysconfig/lm_sensors, So starting lm_sensors gives me a warn=
ing telling me its not configured.

Same result as directly above when I load the w83791d drive, hav\ing remove=
d the other, including the w83792d, w83793, w83l785ts, w83l786ng, wm831x-hw=
mon and wm8350-hwmon. The lsmod stays the same as above except that the dri=
ver is relplace at the same position with the new driver.

Tried various combinations and permutations and nothing.

Any help would appreciated, and apologizes if it has already been dealt wit=
h.

Regards and thanks...





     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

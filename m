From: "luke.leighton" <luke.leighton@gmail.com>
Date: Mon, 29 Apr 2013 11:34:45 +0000
Subject: [lm-sensors] Gigabyte GA-Z77N-ITX Motherboard it87 sensors module (SuperIO chip ITE 8728)
Message-Id: <CAPweEDz7mv+eouxQeNxL=bxEafZwFgG3BsMW+shK9bhapjVeeA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok.  it took a hell of a long time to find the right information to
get this motherboard to be recognised, so i thought i'd do a quick
report with the appropriate keywords for other people to be able to
find it.   i'm using linux kernel 3.2.0 which is considered reasonably
stable, hence the reason why it was not detected.

the phrase that people are looking for - if they notice it when
running sensors-detect, is:

     "Found unknown chip with ID 0x8728"

with that, it's possible to find this:

     http://www.spinics.net/lists/lm-sensors/msg30897.html

which leads to the correct information which is to add the following
to a file named e.g. /etc/modprobe.d/it87.conf:

    options it87 force_id=0x8720

also by downloading the source code for sensors-detect 3.3 i was able
to ascertain that the SuperIO chip with ID 0x8728 has already been
added, but i had sensors-detect version 3.1 so  modified
/usr/sbin/sensors-detect (version 3.1) around line 1819 to add this:

        }, {
                name => "ITE IT8726F Super IO Sensors",
                driver => "it87",
                devid => 0x8726,
                logdev => 0x04,
                features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
        }, {
                name => "ITE IT8728F Super IO Sensors",
                driver => "it87",
                devid => 0x8728,
                logdev => 0x04,
                features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
        }
);

this was rather unnecessary but may be useful to some: after running,
all it did was add it87 to /etc/modules which i could have done anyway
[but ONLY works with that modprobe.d addition.

also what may be of assistance to some people: the previous answer did
not exactly specify what the line is for modprobe, it assumes
knowledge of how to use modprobe.  the command you are looking for is:

    modprobe it87 force_id=0x8720

also, the following page http://www.lm-sensors.org/wiki/Devices was
also quite terse and not immediately very helpful.  if the advice
about force_id had been on the wiki page, i would have saved about 2
hours of searching.  however, *after* discovering the above, the
information reporting that 0x8728 works with kernel versions 3.3 or
the stand-alone sensors kernel modules became clear [i have 3.2.0].
also, H77N is missing from the wiki page entry, it shows support for
H67 and a couple of others, but H77N i can definitely confirm is
working [with the force_id]

so this is more a sort-of interim thing for people who are using
stable 3.2.0 kernels for the forseeable future, especially debian
users, with this amazing low-cost high-featured motherboard.

l.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

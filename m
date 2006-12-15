From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 15 Dec 2006 13:09:39 +0000
Subject: [lm-sensors] Simplifying hwmon drivers locking
Message-Id: <20061215140939.471935f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Many of our hardware monitoring drivers use two different mutexes for
each device. The second mutex was introduced for ISA-based devices
which use only 2 I/O ports (e.g. LM78 or SiS5595), or for devices which
use banked addressing internally (most Winbond and Asus devices). Since
we added proper locking on "set" sysfs callbacks several months ago, it
happens that in most cases, we end up holding both mutexes (lock and
update_lock) almost always at the same time, so they are redundant.
Having a single mutex would make the code more simple, and slightly
faster. The new w83793 driver is using a single mutex, and I converted
the f71805f and it87 drivers (see attachement.) The former was
straightforward, the latter needed only one adjustment.

I guess that most other drivers using two mutexes could be converted
the same way. The list of candidates follows:
drivers/hwmon/asb100.c
drivers/hwmon/lm78.c
drivers/hwmon/pc87360.c
drivers/hwmon/sis5595.c
drivers/hwmon/smsc47b397.c
drivers/hwmon/smsc47m1.c
drivers/hwmon/w83627ehf.c
drivers/hwmon/w83627hf.c
drivers/hwmon/w83781d.c

To convert a driver, you need to make sure that all non-init register
accesses are done with update_lock held, and adjust the code otherwise
(assuming there are only a few adjustments needed, else it's just not
worth it.) Then lock can simply be dropped. Contributions are welcome,
especially if you are a regular user of the driver. It's an easy task,
just use the provided patch as an example.

Thanks,
-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-simplify-locking-1.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061215/acfaa412/attachment.pl 

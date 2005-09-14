From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 14 Sep 2005 06:44:41 +0000
Subject: [lm-sensors] Query: debug lm78 not seen on ISA bus with 2.6.14-rc1
Message-Id: <tf8fi1t6oub8mes89vm567g6ipgjrm56pk@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi there,

Still have problems with lm78 on 2.6.14-rc1.

Given these added debug statements:

--- linux-2.6.14-rc1/drivers/hwmon/lm78.c-orig  2005-09-14 10:52:47.0000000=
00 +1000
+++ linux-2.6.14-rc1/drivers/hwmon/lm78.c       2005-09-14 13:48:02.0000000=
00 +1000
@@ -494,6 +494,7 @@
                goto ERROR0;
        }

+       dev_dbg(&adapter->dev, "got device\n");
        /* Reserve the ISA region */
        if (is_isa)
                if (!request_region(address, LM78_EXTENT,
@@ -502,9 +503,11 @@
                        goto ERROR0;
                }

+       dev_dbg(&adapter->dev, "reserves ISA region\n");
        /* Probe whether there is anything available on this address. Alrea=
dy
           done for SMBus clients */
        if (kind < 0) {
+               dev_dbg(&adapter->dev, "kind < 0\n");
                if (is_isa) {

 #define REALLY_SLOW_IO
@@ -515,16 +518,19 @@
                                err =3D -ENODEV;
                                goto ERROR1;
                        }
+                       dev_dbg(&adapter->dev, "done +2\n");
                        if (inb_p(address + 3) !=3D i) {
                                err =3D -ENODEV;
                                goto ERROR1;
                        }
+                       dev_dbg(&adapter->dev, "done +3\n");  <<=3D does no=
t get here
                        if (inb_p(address + 7) !=3D i) {
                                err =3D -ENODEV;
                                goto ERROR1;
                        }
 #undef REALLY_SLOW_IO

+                       dev_dbg(&adapter->dev, "after REALLY_SLOW_IO\n");
                        /* Let's just hope nothing breaks here */
                        i =3D inb_p(address + 5) & 0x7f;
                        outb_p(~i & 0x7f, address + 5);
@@ -533,6 +539,7 @@
                                err =3D -ENODEV;
                                goto ERROR1;
                        }
+                       dev_dbg(&adapter->dev, "after hope nothing breaks h=
ere\n");
                }
        }

I get:
# modprobe lm78

[/var/log/debug]
Sep 14 13:51:01 silly kernel: i2c_adapter i2c-9191: Driver lm78-isa registe=
red
Sep 14 13:51:01 silly kernel: i2c_adapter i2c-9191: got device
Sep 14 13:51:01 silly kernel: i2c_adapter i2c-9191: reserves ISA region
Sep 14 13:51:01 silly kernel: i2c_adapter i2c-9191: kind < 0
Sep 14 13:51:01 silly kernel: i2c_adapter i2c-9191: done +2


If I do:
# rmmod lm78
# modprobe lm78 force_lm78=9191,0x290

I get the same now:
[/var/log/debug]
Sep 14 13:53:54 silly kernel: i2c_adapter i2c-9191: Driver lm78-isa unregis=
tered
Sep 14 13:53:58 silly kernel: i2c_adapter i2c-9191: Driver lm78-isa registe=
red
Sep 14 13:53:58 silly kernel: i2c_adapter i2c-9191: got device
Sep 14 13:53:58 silly kernel: i2c_adapter i2c-9191: reserves ISA region
Sep 14 13:53:58 silly kernel: i2c_adapter i2c-9191: kind < 0
Sep 14 13:53:58 silly kernel: i2c_adapter i2c-9191: done +2

# lsmod
Module                  Size  Used by
lm78                   17396  0
hwmon_vid               1984  1 lm78
i2c_isa                 4192  1 lm78
nfsd                   92008  8
exportfs                4512  1 nfsd
tulip                  41536  0
e100                   32964  0

this is linux-2.6.14-rc1 on:
  http://bugsplatter.mine.nu/test/boxen/silly/

I'm not sure where to go next?  Ideas, cluebats please?


Yes, it works on 2.6.13.1 with Jean Delvare's force option:

login as: root
Authenticating with public key "grant@peetoo" from agent
Last login: Wed Sep 14 11:11:59 2005 from magpie.mire.mine.nu
Linux 2.6.13.1a.

The best cure for insomnia is to get a  lot of sleep.
                -- W. C. Fields

root@silly:~# sensors
No sensors found!
root@silly:~# modprobe lm78 force_lm78=9191,0x290
root@silly:~# sensors
lm78-isa-0290
Adapter: ISA adapter
VCore 1:   +2.03 V  (min =3D  +2.18 V, max =3D  +0.59 V)   ALARM
VCore 2:   +1.49 V  (min =3D  +1.30 V, max =3D  +0.35 V)   ALARM
+3.3V:     +3.34 V  (min =3D  +1.44 V, max =3D  +0.70 V)   ALARM
+5V:       +5.08 V  (min =3D  +5.62 V, max =3D  +2.42 V)   ALARM
+12V:     +11.61 V  (min =3D  +4.07 V, max =3D +14.59 V)
-12V:     -10.35 V  (min =3D  -0.00 V, max =3D -11.01 V)   ALARM
-5V:       -4.70 V  (min =3D  -4.79 V, max =3D  -0.00 V)
fan1:        0 RPM  (min =3D 15340 RPM, div =3D 2)          ALARM
fan2:        0 RPM  (min =3D 14062 RPM, div =3D 2)          ALARM
fan3:        0 RPM  (min =3D 67500 RPM, div =3D 2)          ALARM
temp:      +26.0?C  (high =3D   +64?C, hyst =3D   +60?C)
vid:       +3.50 V
alarms:   Chassis intrusion detection                  ALARM

root@silly:~# lsmod
Module                  Size  Used by
lm78                   16504  0              (i2c_isa is compiled in)
i2c_sensor              2816  1 lm78
nfsd                   92008  8
exportfs                4512  1 nfsd
i2c_piix4               7376  0
tulip                  42496  0
e100                   30656  0

Thanks,
Grant.


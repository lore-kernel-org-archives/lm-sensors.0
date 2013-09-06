From: Phil Perry <phil@elrepo.org>
Date: Fri, 06 Sep 2013 13:53:33 +0000
Subject: [lm-sensors] Backporting updated lm85 on RHEL5
Message-Id: <5229DE5D.7060104@elrepo.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I'm trying to backport an updated lm85 driver on RHEL5 to provide=20
support for an EMC6D103 hardware monitoring chip.

Backporting from more recent kernels fails around the patch "Convert to=20
a new-style i2c driver" from 2008-10-17 on RHEL5 and I'm unsure how to=20
fix that.

Then I remembered Jean's stand alone drivers:

http://khali.linux-fr.org/devel/lm-sensors/drivers/lm85/

which appear to potentially support RHEL5 but unfortunately I'm still=20
experiencing problems compiling that code on RHEL5 (see below).

I'd really appreciate any assistance getting a more updated driver=20
available for RHEL5.

Thanks,

Phil


[phil@Quad lm85]$ make modules
   CC [M]  /home/phil/Desktop/tmp/lm85/lm85.o
In file included from /home/phil/Desktop/tmp/lm85/lm85.c:42:
/home/phil/Desktop/tmp/lm85/i2c-compat.h:29: warning: initialization=20
discards qualifiers from pointer target type
/home/phil/Desktop/tmp/lm85/lm85.c:371: error: unknown field =91probe=92=20
specified in initializer
/home/phil/Desktop/tmp/lm85/lm85.c:371: warning: missing braces around=20
initializer
/home/phil/Desktop/tmp/lm85/lm85.c:371: warning: (near initialization=20
for =91lm85_driver.list=92)
/home/phil/Desktop/tmp/lm85/lm85.c:371: warning: initialization from=20
incompatible pointer type
/home/phil/Desktop/tmp/lm85/lm85.c:372: error: unknown field =91remove=92=20
specified in initializer
/home/phil/Desktop/tmp/lm85/lm85.c:372: warning: excess elements in=20
struct initializer
/home/phil/Desktop/tmp/lm85/lm85.c:372: warning: (near initialization=20
for =91lm85_driver=92)
/home/phil/Desktop/tmp/lm85/lm85.c:373: error: unknown field =91id_table=92=
=20
specified in initializer
/home/phil/Desktop/tmp/lm85/lm85.c:373: warning: excess elements in=20
struct initializer
/home/phil/Desktop/tmp/lm85/lm85.c:373: warning: (near initialization=20
for =91lm85_driver=92)
/home/phil/Desktop/tmp/lm85/lm85.c:374: error: unknown field =91detect=92=20
specified in initializer
/home/phil/Desktop/tmp/lm85/lm85.c:374: warning: excess elements in=20
struct initializer
/home/phil/Desktop/tmp/lm85/lm85.c:374: warning: (near initialization=20
for =91lm85_driver=92)
/home/phil/Desktop/tmp/lm85/lm85.c:376: error: unknown field=20
=91address_data=92 specified in initializer
/home/phil/Desktop/tmp/lm85/lm85.c:376: warning: excess elements in=20
struct initializer
/home/phil/Desktop/tmp/lm85/lm85.c:376: warning: (near initialization=20
for =91lm85_driver=92)
/home/phil/Desktop/tmp/lm85/lm85.c: In function =91lm85_detect=92:
/home/phil/Desktop/tmp/lm85/lm85.c:1206: warning: unused variable =91addres=
s=92
/home/phil/Desktop/tmp/lm85/lm85.c: In function =91lm85_probe=92:
/home/phil/Desktop/tmp/lm85/lm85.c:1377: warning: assignment from=20
incompatible pointer type
/home/phil/Desktop/tmp/lm85/lm85.c: In function =91lm85_remove=92:
/home/phil/Desktop/tmp/lm85/lm85.c:1396: warning: passing argument 1 of=20
=91hwmon_device_unregister=92 from incompatible pointer type
make[2]: *** [/home/phil/Desktop/tmp/lm85/lm85.o] Error 1
make[1]: *** [_module_/home/phil/Desktop/tmp/lm85] Error 2
make: *** [modules] Error 2
[phil@Quad lm85]$



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

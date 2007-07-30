From: Tom <i-c-q@chaos2.dtdns.net>
Date: Mon, 30 Jul 2007 16:00:26 +0000
Subject: Re: [lm-sensors] FSC Scylla (and Poseidon,
Message-Id: <46AE0B1A.6040008@chaos2.dtdns.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <46AB90E6.4000801@hhs.nl>
In-Reply-To: <46AB90E6.4000801@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> To test drop the attached fscscy.c and Makefile in a dir, type make and 
> then insmod fscscy.ko

I've got 2 problems with that.
The first was, on Ubuntu 6.06 LTS it won't compile (mutex.h is not where 
expected). Hans sent me another version which does (thanks so far!).

The second is, I can't insmod it. Done manually or by modprobe, I only 
get this message:

root@tsrv02:/usr/local/cvsroot/fscscy# modprobe -v fscscy
insmod /lib/modules/2.6.15-28-server/kernel/drivers/i2c/chips/fscscy.ko
FATAL: Error inserting fscscy 
(/lib/modules/2.6.15-28-server/kernel/drivers/i2c/chips/fscscy.ko): 
Permission denied

Additionally, the following lines appear in syslog:

Jul 30 17:57:22 tsrv02 kernel: [43819906.080000] kobject_register failed 
for  (-13)
Jul 30 17:57:22 tsrv02 kernel: [43819906.170000] 
[kobject_register+107/128] kobject_register+0x6b/0x80
Jul 30 17:57:22 tsrv02 kernel: [43819906.270000] 
[bus_add_driver+118/240] bus_add_driver+0x76/0xf0
Jul 30 17:57:22 tsrv02 kernel: [43819906.370000] 
[pg0+949280896/1069167616] i2c_device_remove+0x0/0x10 [i2c_core]
Jul 30 17:57:22 tsrv02 kernel: [43819906.460000] 
[pg0+949280880/1069167616] i2c_device_probe+0x0/0x10 [i2c_core]
Jul 30 17:57:22 tsrv02 kernel: [43819906.550000] 
[pg0+949282333/1069167616] i2c_add_driver+0x4d/0xd0 [i2c_core]
Jul 30 17:57:22 tsrv02 kernel: [43819906.650000] 
[pg0+950779919/1069167616] fscscy_init+0xf/0x11 [fscscy]
Jul 30 17:57:22 tsrv02 kernel: [43819906.740000] 
[sys_init_module+212/496] sys_init_module+0xd4/0x1f0
Jul 30 17:57:22 tsrv02 kernel: [43819906.820000] 
[sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75

Does anyone know, what's going wrong? What do I have to do to correct this?

cu/2
Torsten a.k.a Tom

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: karsten@maxi-dsl.de
Date: Fri, 22 Oct 2010 11:56:07 +0000
Subject: [lm-sensors] looking for help with W83795ADG
Message-Id: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi lm-sensors team,

first of all many thanks for all the efforts to support the latest hardware!

Recently I acquired a brand new hp ProLiant N36L micro server.  
According to hp's data sheet, it contains a W83795ADG. I've installed  
ubuntu server 10.04.01 (2.6.32-25 as of now), and lm-sensors (3.1.2,  
from ubuntu repositories as far as I remember).

sensors-detect did not identify anything readily useable, so I was  
happy to find http://khali.linux-fr.org/devel/misc/w83795/, linked  
from http://lm-sensors.org/wiki/Devices.
To be honest, I wasn't so sure what I'd need to do with this - I  
downladed the files, did "make all" and "sudo make install" - all went  
fine, no errors, and I could find the w83795.ko file in  
/lib/modules/2.6.32-25-server/kernel/drivers/hwmon which appears  
correct to me.
I also did "sudo modprobe w83795" (no error nor output), however  
running sensors still gives 'No sensors found!'

I guess I'm missing something really obvious (since I don't really  
know what I'm doing...), but don't know where to look..

would be grateful for any help...

regards -

Karsten


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: #1353 still error!!
Message-Id: <20030731143801.5eba368d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>    I've removed that line from dmi_scan.c file, and run the whole
>    compilation from the beginning (I've removed the whole lm_sensors
>    source dir before) but still the same error...
> What should I do now? (I don't want to reinstall linux now but I
> really need this sensors package!)

With a bit of luck, you don't need the dmi_scan module. Try to remove it
from the compilation process. Edit kernel/busses/Module.mk. Comment out
the following line:

KERNELBUSSESTARGETS += $(MODULE_DIR)/dmi_scan.o

becomes:

#KERNELBUSSESTARGETS += $(MODULE_DIR)/dmi_scan.o

And try again. I don't pretend it is a very nice fix, but if it's OK for
you... And if it still fails, at least we will have another information,
this may help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

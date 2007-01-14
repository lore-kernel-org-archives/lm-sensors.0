From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 14 Jan 2007 20:56:10 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk > no
Message-Id: <45AA98EA.5000008@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701071107.50461.christophe.dr@free.fr>
In-Reply-To: <200701071107.50461.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

> Ah..!? On kubuntu 6.10, i use ksensors and it seems that it can monitor 
> temperature from acpi and from lm_sensors. Both lm85 and thermal modules are 
> loaded. The 2 temperatures are consistent : they are almost the same. And i 
> had no crash.
> And, i don't have yet ksensors on suse 10.2 but both thermal and lm85 modules 
> are loaded and no crash detected.
> What is the risk ?

You may read completely wrong temperature, hang the bus, stop the fan, force 
processor to throttle to prevent overheat. I think no real damage will happen, 
but be careful.

Rudolf



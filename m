From: Michel Filipe <michel@milk-it.net>
Date: Thu, 17 Jul 2008 18:13:31 +0000
Subject: [lm-sensors] Sensors at HP Pavilion dv5000 CTO
Message-Id: <200807171513.31993.michel@milk-it.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi! I'm writing a kde4 plasmoid to get informations about temperature sensors, 
but I've many questions before write lm-sensors backend.

Before I want show the informations about my laptop:
lspci http://paste.milk-it.net/825
sensors http://paste.milk-it.net/826

1) Is possible I add temperature of my hard disk in lm-sensors? With hddtemp I 
can get the temperature. I've a FUJITSU MHV2080BH hard disk.
2) How do I do to add nvidia temperature? I'm using nvidia binary driver 
(official) and can get the temperature using "nvidia-settings -q GPUCoreTemp".
3) What is "acpitz-virtual-0"? It returns two temperatures, what are each 
temp? See the paste http://paste.milk-it.net/826.
4) I've a iwl3945 wireless card. I can get the temperature in 
/sys/devices/pci.../temperature adding 260 to result - the driver does this. 
Is possible I add the temperature in lm-sensors?

My english isn't very good, feel free to correct me or ask to rewrite the 
questions. Thanks all! :)
-- 
Michel Filipe
Milk-it Brasil Software House
+55 31 32271009
+55 31 84843953

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

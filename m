From: =?ISO-8859-2?Q?Grzegorz_S=F3jka?= <pld@sojka.co>
Date: Thu, 13 Mar 2014 19:44:53 +0000
Subject: [lm-sensors] hp dc7900
Message-Id: <53220AB5.8010809@sojka.co>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

I'm using HP dc7900 Small Form Factor Business PC as a small home 
server. Since the machine runs 24/7 I would like it to automatically 
shut down in case of overheating or a fan failure. I managed to obtain 
temperatures for both CPU cores (via coretemp). Unfortunately I'm not 
able to monitor fans speed. The sensors-detect script detected also:

Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x0b00

Unfortunately I have no idea what is it and how to use it.

Does anyone know how to configure lm_sensors to obtain fans speed 
readings on my machine??

-- 
Regards
Greg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

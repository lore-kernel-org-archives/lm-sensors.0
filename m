From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031125221206.09002df5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Please provide the output of "ls -l
> > /proc/sys/dev/sensors/eeprom-i2c-0-50".
> 
> [root@workstation1 root]# ls -l /proc/sys/dev/sensors/eeprom-i2c-0-50
> total 0
> -r--r--r--    1 root     root            0 Nov 25 14:36 00
> -r--r--r--    1 root     root            0 Nov 25 14:36 10
> -r--r--r--    1 root     root            0 Nov 25 14:36 20
> -r--r--r--    1 root     root            0 Nov 25 14:36 30
> -r--r--r--    1 root     root            0 Nov 25 14:36 40
> -r--r--r--    1 root     root            0 Nov 25 14:36 50
> -r--r--r--    1 root     root            0 Nov 25 14:36 60
> -r--r--r--    1 root     root            0 Nov 25 14:36 70
> -r--r--r--    1 root     root            0 Nov 25 14:36 80
> -r--r--r--    1 root     root            0 Nov 25 14:36 90
> -r--r--r--    1 root     root            0 Nov 25 14:36 a0
> -r--r--r--    1 root     root            0 Nov 25 14:36 b0
> -r--r--r--    1 root     root            0 Nov 25 14:36 c0
> -r--r--r--    1 root     root            0 Nov 25 14:36 d0
> -r--r--r--    1 root     root            0 Nov 25 14:36 e0
> -r--r--r--    1 root     root            0 Nov 25 14:36 f0

This is correct, so I would say the procfs interface is working OK. So
this is the driver been broken.

Fernando, your problem is exactly the same, as you'll have noticed.

Could you please enable DEBUG in lm_sensors2, recompile and reinstall
it? (All I really want is DEBUG enabled on the eeprom module.) You just
have to edit the Makefile file and uncomment the right line.

Then, unload the old eeprom module, load the new one, and do "cat
/proc/sys/dev/sensors/eeprom-i2c-0-50/*" again. Then take a look at
dmesg (or whichever log the debug stuff will have gone into), and tell
me what you see there, from the moment the module was loaded. Hopefully,
this will help me locate where the bug could hide.

Thanks a lot.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

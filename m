From: Marc Muehlfeld <Marc.Muehlfeld@medizinische-genetik.de>
Date: Thu, 07 Aug 2008 07:14:23 +0000
Subject: [lm-sensors] Getting an alarm even with values between min/max
Message-Id: <489AA0CF.4010509@medizinische-genetik.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

I run lm_sensors 2.6.5 on a Redhat 7.2 machine (it's a server for a legacy 
application).

Nothing changed on the OS for ~3 years and I'm unsure, why I get an alarm 
since a few days on VCore1/VCore2 even the values are in the range:

w83627hf-i2c-0-2c
Adapter: SMBus AMD75x adapter at 80e0
Algorithm: Non-I2C SMBus adapter
#2 VCore1: +1.55 V  (min =  +1.44 V, max =  +1.76 V)       ALARM
#2 VCore2: +1.60 V  (min =  +1.52 V, max =  +1.68 V)       ALARM

What causes this?

Regards
Marc Muehlfeld

-- 
Marc Muehlfeld (Leitung IT)
Zentrum fuer Humangenetik und Laboratoriumsmedizin Dr. Klein und Dr. Rost
Lochhamer Str. 29 - D-82152 Martinsried
Telefon: +49(0)89/895578-0 - Fax: +49(0)89/895578-78
http://www.medizinische-genetik.de


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

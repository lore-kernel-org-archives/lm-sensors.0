From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: eeprom driver
Message-Id: <Pine.GSO.4.40.0202181446200.15292-100000@e450.ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I made the naming change you suggested in eeprom.c
> and fixed decode-dimms and decode-xeon, (...)

Any reason why decode-xeon.pl was not moved to eeprom/ as I suggested?
(not that it is really important, I'm just wondering)

I saw that you reversionned decode-dimms and decode-xeon to 2.6.3.  I
guess we should agree on wether scripts versions are supposed to match
lm_sensors' ones.  I have a general preference for independant versioning,
since it lets us change the scripts without regards to how frequent
lm_sensors itself is released.  Anyway I'd like to know what is expected
to follow the guidelines.  However, I'd insist that the claimed (printed
at runtime) version matches the changes history one(s), and that, in the
case we chose to keep an independant versioning, the required lm_sensors
version be explicitely mentioned.

Regards.

-- 
       /~~       Jean "Khali" Delvare
  -----\_                        mail: delvare@ensicaen.ismra.fr
 --------\                http://www.ensicaen.ismra.fr/~delvare/
---=ISMRA/- ____________________________________________________

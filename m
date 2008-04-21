From: "Pierce Ward" <pierceward@gmail.com>
Date: Mon, 21 Apr 2008 16:37:17 +0000
Subject: [lm-sensors] lm_sensors + IBM xseries 336
Message-Id: <874302b50804210937n5d003656teaa61cbec6d5a65e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Everyone,

I recently setup a Red Hat 4 based system and wish to get lm_sensors
support. Here is my current setup:

lm_sensors-2.8.7-2
kernel-smp-2.6.9-5.EL
IBM Xseries 336

Basically I checked the Devices section of the wiki to check if my
board is compatible. My board is listed as supported: Intel 82801EB ->
i2c-i801 (pastebin of lspci: http://rafb.net/p/0x7zyL96.html ).

However when I run sensors-detect, I get an error about my vendor
being IBM and that their systems aren't supported (as of my lm_sensors
2.8.7 anyway).

Before I go modifying the sensors-detect script I was wondering if
this is safe to do on this system? The error message from
sensors-detect mentions the thinkpad laptop, however I would assume
that an xseries server would be better supported.

Unfortunately I won't be able to update lm_sensors on this box, so I'm
fairly limited in what I can do.

Any help on this is appreciated,
Cheers.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

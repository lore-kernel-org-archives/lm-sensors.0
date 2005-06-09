From: gearoid.murphy@ul.ie (Gearoid Murphy)
Date: Thu, 09 Jun 2005 20:51:31 +0000
Subject: [lm-sensors] Linking Problem
Message-Id: <42A8906C.10707@ul.ie>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
    This should be trivial for everyone here. I'm trying to write a user 
space program i2c device driver. I access the device using /dev but when 
I try to use functions included in the i2c-core my compiler tells me its 
getting an undefined reference. I know this is because I'm not including 
the proper libraries. How do i get around this?. I've tried explicitly 
including the i2c-core.ko in the gcc compile command but this spews out 
errors about other undefined references.
    All I want to do is successfully communicate to an SRF08 sonar using 
the i2c parallel port adapter for the ELV adapter (built using the 
schema in the i2c docs). I'm using debian 2.6+ and am completely at my 
wits end.
    Any help would be brillant.
    Regards,
    Gearoid

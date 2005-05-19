From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: no fan RPM output & low running fan (Copper Silent 2-TC (REV 2))
Message-Id: <200502221703.59024.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

after replacing my "boxed" CPU fan by a noise reduced "Copper Silent 2-TC (REV 
2)" the RPM output of sensors is null, if the fan is running with low speed 
(about 1500 RPM). Sensors will start to give some output at the RPM of 2800. 
Is there a chance get some output at lower fan speed too?

My modules:

# I2C adapter drivers
i2c-viapro
i2c-isa
# I2C chip drivers
#eeprom
via686a

Ciao,
Marcus

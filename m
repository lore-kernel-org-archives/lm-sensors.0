From: cdepauw@gmail.com (Christopher DePauw)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: Self-Serve Support (lm-sensors)
Message-Id: <66a077a80504051659eff2cc9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am unable to load the 'i2c-piix4' module. I am using gentoo linux
AND I have emerged your "i2c" and "lm_sensors" packages.

sensors detect recognizes my bus, but is unable to load the module.
I am unable to manually modrobe the module.

I have tried recompiling my kernel with 'i2c' and 'algo' as modules
and as integrated into the kernel, then tried reemerging "i2c" and
"lm_sensors". Doing this did not give me access to the i2c-piix4
module.

Christopher DePauw

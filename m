From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 24 Jan 2011 20:24:54 +0000
Subject: [lm-sensors] Supported I2C addresses for EMC temperature sensors
Message-Id: <20110124202454.GA640@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

while looking into EMC temperature sensor detection, I noticed a discrepancy 
in some of the I2C chip addresses listed in sensors-detect vs. the addresses 
supported per datasheets.

Per sensors-detect, addresses supported for emc1403, emc1404, and emc1423 are
	i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],

However, adccording to the datasheets, supported addresses should be
	0x18, 0x29, 0x4c, 0x4d 
for emc1403 and emc1404, and
	0x4c
for emc1423.

Any idea what is correct ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

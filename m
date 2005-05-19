From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <20050125195140.395fb259.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> The version of lm_sensors I'm working is 2.9.0. And I find there are
> some codes about 792 in script sensors-detect, But it seems that it
> does NOT work, because it can NOT find W83792D chip. Neither do the
> version 2.8.8. The attachment is the detect result log, you may refer
> to it and check the script again.

The log shows the following error:

Error: First argument not a number!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0       smbus           SMBus I801 adapter at 0500              Non-I2C SMBus adapter

This means that the version of i2cdetect you are using it too old. Make
sure that you have no old version of this tool lying around. The error
causes the SMBus not to be probed at all, which is probably why your
W83792D chip was not detected. With a newer version of i2cdetect
installed, sensors-detect should work fine (hopefully).

-- 
Jean Delvare
http://khali.linux-fr.org/

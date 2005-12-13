From: fredantispam@free.fr (fred)
Date: Tue, 13 Dec 2005 18:45:20 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <439F16C0.60505@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare a ?crit :

> chip is compatible with the older ones. Chances are, it is. But again
> maybe not. If you try it out, please let us know the outcome.

Seems to work fine, this time ;-)

dmesg:
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100

i2cdetect -l:
i2c-1   unknown         SMBus nForce2 adapter at 5100
Algorithm unavailable
i2c-0   unknown         SMBus nForce2 adapter at 5000
Algorithm unavailable

But..., a stupid question : what can I do with this i2c busses ?
What is used for, knowing that it87 provides temp, fan, volt etc.
What does "Algorithm unavailable" mean?
Which one must I use (PCF ? PCA ?)

Thanks, anyway.

-- 
Fred.


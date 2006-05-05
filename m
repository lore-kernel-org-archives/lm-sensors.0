From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 05 May 2006 20:15:03 +0000
Subject: [lm-sensors] Unknown EEPROM type (8)?????? AND CPU temperature
Message-Id: <445BB247.9010208@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFD391091A1B1F4C810F27127FD3BA05A0DC53@ntsvr06.pontassieve.local>
In-Reply-To: <AFD391091A1B1F4C810F27127FD3BA05A0DC53@ntsvr06.pontassieve.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Alessio
> Redhat ES 4 kernel 2.6.9-34.Elsmp,
> Mother board ASUS p5gd2 (bios 1006) with P4 at 3.4Ghz.
> Sensors: sensors version 2.8.7 with libsensors version 2.8.7

Too old version, you have 83627EHF imho. Please try new version
2.9.1/2 should be OK
> i2c /dev entries driver
> CPU0: Temperature above threshold
> CPU1: Temperature above threshold
> CPU1: Running in modulated clock mode
> CPU0: Running in modulated clock mode
> CPU1: Temperature above threshold
> CPU0: Temperature above threshold
> CPU0: Running in modulated clock mode
> CPU1: Running in modulated clock mode

This is done idependetely from hardware and it means
that both CPUs overheat, please check the heatsinks
and/or check the thermal conducting grease between
heatsink and processor. Check fans too.

> 1) Sensor/chipset not recognised.

Old version

> 2) Messages about cpu temperature

See above ;)

Regards
Rudolf


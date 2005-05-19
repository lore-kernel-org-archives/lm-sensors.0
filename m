From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: [Fwd: Weird behaviour of adm1021 with max1617-i2c-0-4c]
Message-Id: <3E1F2316.1040405@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------

To: frodol@dds.nl, phil@netroedge.com
Subject: Weird behaviour of adm1021 with max1617-i2c-0-4c
Date: Fri, 10 Jan 2003 20:37:18 +0100



Hi there,

I own a new Gigabyte GA-7VAXP motherboard with a Via KT400 chipset.

This card seems to have a max1617-i2c-0-4c that is driven by the adm1021 
module.

Here are my settings in sensors.conf for it:

chip "max1617-*"
    ignore "temp"
    label "remote_temp" "Athlon CPU T?"
    set remote_temp_low 10
    set remote_temp_over 70

I was suprised to see that a temperature sensor has a "low" and an "over" 
setting, rather than an "over" and an "hysteresis" setting...

When using it, I get a display that looks correct:

[root@totor etc]# sensors
[... ]
max1617-i2c-0-4c
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Athlon CPU T?:
             +54?C  (min =  +10?C, max =  +70?C)

...but the sensorsd daemon logs in my /var/log/messages the limits as follows:

Jan 10 20:17:36 totor sensord: Chip: max1617-i2c-0-4c
Jan 10 20:17:36 totor sensord: Adapter: SMBus Via Pro adapter at 5000
Jan 10 20:17:36 totor sensord: Algorithm: Non-I2C SMBus adapter
Jan 10 20:17:36 totor sensord:   Athlon CPU T?: 54 C (limit = 70 C, hysteresis 
= 10 C)

...which incorrectly reports the lower limit as being an "hysteresis"...

Hope this report can be of some help.

Best regards.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E



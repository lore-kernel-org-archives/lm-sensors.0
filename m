From: Christopher Cordahi <christophercordahi@nanometrics.ca>
Date: Fri, 22 Aug 2014 22:31:22 +0000
Subject: [lm-sensors] How to compute a voltage that may be positive or negative
Message-Id: <CAF_O4Js3aRF7iofSey0w+F8azTGbawX5vEe9cmHqybk9Qj=yvg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm wondering if this is a valid use case.  I need to perform both a
multiplication and a subtraction to compute an original voltage.

lm sensors 3.2.0 is working fine on Linux 2.6.39.4 reading an ADS1115 ADC
chip that measures a voltage from 0 V to about 2 V.

# uname -srmo
Linux 2.6.39.4 armv5tejl GNU/Linux
# sensors --version
sensors version 3.2.0 with libsensors version 3.2.0
# sensors --bus-list ads1115-i2c-2-4a
bus "i2c-2" "i2c-1-mux (chan_id 0)"
bus "i2c-1" "DaVinci I2C adapter"
# sensors --no-adapter ads1115-i2c-2-4a
ads1115-i2c-2-4a
in4:         +1.14 V
in5:         +1.14 V
in6:         +1.14 V

My problem is that I'd like for the sensor utility to convert the ADC
voltages to the original voltage which are in the range from about -10 V to
about +10 V.

If I modify the sensor configuration as follows, it appears to work
correctly.

root@centaur-3_0009:~# tail -2 /etc/sensors3.conf
chip "ads1115-*"
    compute in4 @*10-10 , (@+10)*10
root@centaur-3_0009:~# sensors --no-adapter ads1115-i2c-2-4a
ads1115-i2c-2-4a
in4:         +1.41 V
in5:         +1.14 V
in6:         +1.14 V

Unfortunately when I adjust the values to their more accurate values, it no
longer converts and reports the original ADC value instead.

root@centaur-3_0009:~# tail -2 /etc/sensors3.conf
chip "ads1115-*"
     compute in4 @*9.72340425532-9.95823902214 ,
(@+9958.23902214)/9.72340425532
root@centaur-3_0009:~# sensors --no-adapter ads1115-i2c-2-4a
ads1115-i2c-2-4a
in4:         +1.14 V
in5:         +1.14 V
in6:         +1.14 V

-- 
Chris
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

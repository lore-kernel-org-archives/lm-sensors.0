From: Leandro de Marco <leandromarco@gmail.com>
Date: Wed, 07 May 2014 14:55:19 +0000
Subject: [lm-sensors] Global hyst value representation
Message-Id: <CAFO4QpA84_mzcA2o9yBLxALQWwHZ_M7A5khqERDaod882ZV0vg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

I am implementing a driver for the TMP512/513 temperature chip.

It has a local temp sensor and 2/3 remote temp sensors. There is a hyst
setting, but this setting is unique and applies for all 3/4 sensors. I am
not sure what is the best way to represent this setting on sysfs.

I read the instructions at Documentation/hwmon/sysfs-interface, and tried
to find other drivers with only one global hyst value, but have found
nothing.

My solution would be to create an attribute temp1_max_hyst, so it will be
listed as subfeature by the lm_sensors library, and explain in the
Documentation that it applies for all sensors.

Any comments or thoughts?

Thanks!


Leandro
--------------------------------------------------------------------------
My Mind is Not for Rent.
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

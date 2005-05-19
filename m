From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Asus P4PE-XS
Message-Id: <1080216483.4062cba337c66@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403251128.45259.a.bitz@gmx.net>
In-Reply-To: <200403251128.45259.a.bitz@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Annette Bitz <a.bitz@gmx.net>:

> > War das mit w83781d treiber oder asb100?
> 
> I have both modules installed, but the w83781d doesn't do anything.
> Without the asb100 module I get no output (except that from the
> eeprom).

OK, this is expected. We completely dropped support for the ASB100 from
w83781d now that it has a specific driver.
 
> I can read them without any problem.
> 
> /proc/sys/dev/sensors# ls
> asb100-i2c-0-2d  chips  eeprom-i2c-0-50
> 
> .../sensors/asb100-i2c-0-2d# ls
> alarms  fan2  fan_div  in1  in3  in5  pwm1   temp2  temp4  vrm
> fan1    fan3  in0      in2  in4  in6  temp1  temp3  vid
> .../sensors/asb100-i2c-0-2d# cat temp1
> 80.0 75.0 29.0
> 
> I think this looks good. On my other server (with other chips) it
> looks similar, and there everything is working fine.

Correct, this looks good. This tends to prove that the driver is working
OK, but the user-space tools are not. This leaves us with two
cantidates: libsensors and sensors.

I suspect that there is either an old sensors binary or an old
libsensors on your system, either of which lacks asb100 support.
Actually, the output of sensors really looks like it doesn't know that
it supports asb100.

So I invite you to check that you are really using sensors version 2.8.5
and libsensors 3.0.3, using the following commands:

$ which sensors

will tell you where the sensors binary is. If you installed lm_sensors
yourself without changing the default installation dir, it should be
/usr/local/bin/sensors. If not, then the problem is there. You can also
try:

$ sensors -v

Same applies for libsensors. Check your whole system for libsensors
(especially /usr/lib and /usr/local/lib) and make sure that older
libraries are not picked up instead of the newly installed one.

$ ldd $(which sensors)

should let you know which libsensors is used by sensors.

Basically, if your distribution has packages for lm_sensors, you should
uninstall them since they are likely to cause the kind of problems you
are encountering at the moment.

As a side note, the output from sensors-detect in your first mail
presents an error which is fixed in 2.8.5, so I also suspect that you
have another sensors-detect binary on your system which is used instead
of the new one.

Get rid of the old stuff and I'd expect everything to work OK :)

> Thanks for your fast answer!

You're welcome :) If was great to refresh my German a bit ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

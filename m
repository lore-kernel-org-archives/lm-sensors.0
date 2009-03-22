From: DaNiMoTh <jjdanimoth@gmail.com>
Date: Sun, 22 Mar 2009 21:48:13 +0000
Subject: [lm-sensors] new driver for adt746x.. need some hints
Message-Id: <7b71803f0903221448m56cf985ev977bb1892e6c5702@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello to the list,

this is the first time that I write on it.

I have written a new driver for the adt746x monitor chip, used in Mac
iBook and Powerbook G4. I referred to the official documentation ( and
new sysfs interface ) and the adt7470 module.

Now I can read the temperature, read/set the high/low temperature
limit and read the fan speed (RPM) from lm-sensors.
The others functionality ( like using an automatic fan speed control,
or setting the temperature over that the fans start) are in
/sys/class/hwmon/hwmon0/device/ , but I can't control these with a
sensors.

So, I have a question:

There is a way to edit these options ?
I tried echo, but it don't work ( permission denied ).

Many thanks

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

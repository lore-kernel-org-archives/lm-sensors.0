From: jk <lm_sensors@kosowsky.org>
Date: Fri, 06 Apr 2007 15:52:31 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <m2irc9biv4.fsf@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>jk wrote:
>> I have a p4pe board with the asb_100 sensor running under linux 2.6.20.
>> 
>> I now notice that the sensors location varies between
>> /sys/bus/i2c/drivers/asb100/0-002d and /sys/bus/i2c/drivers/asb100/2-002d
>> between reboots.
>> 
>> This creates problems for me since I use sensord and a crontab entry to read the
>> sensors but now the location of the sensors in /sys varies with each boot.
>> 
>> Is this a bug?
>> If not is there a way to fix the location of the sensor directory in the /sys
>> heirarch? (Otherwise, I will need to write some klugey shell script to try to
>> find the location at boot-up and then automatically change the crontab entry
>> accordingly.
>> 
>> Thanks!
>> 
>
>Interesting, I've been thinking about this for while, as I foresee problems 
>here in relation to the DMI based motherboard config project we are working on too.
>
>I think that the currently used scheme where busses are purely numbered instead 
>of named needs fixing.
>
>Here is what I have on my system:
>/sys/bus/i2c/devices/0-0050
>/sys/bus/i2c/devices/0-0051
>
>And here is what I would like to have:
>/sys/bus/i2c/devices/viapro-0-0050
>/sys/bus/i2c/devices/viapro-0-0051
>
>The idea here is that the 0 added here is in case one can have multiple 
>instances of the same i2c master driver
>
>So if I would also have an i2c driver for my ati radeon, then it would look like:
>/sys/bus/i2c/devices/viapro-0-0050
>/sys/bus/i2c/devices/viapro-0-0051
>/sys/bus/i2c/devices/radeon-0-00xx
>
>This way the order in which the drivers get loaded doesn't matter. We do 
>ofcourse need to provide compat symlinks with the old names which will still be 
>driver loading order dependend.
>
>Regards,
>
>Hans

Agreed.

Note that I also seem to have an 'extra' layer in that my devices sit
in an asb100 subdirectory (see below) whereas yours seem to sit right
in the /sys/i2c/bus/devices directory. So I guess that mine already
has some 'naming' built in.


I guess my *practical* questions in the meantime until naming gets
changed are the following:

1. Why does the device number prefix change from '0' to '2' on
   different boots? Also, why does the sensor jump to 2-002d when
   there is NO 0-002d or 1-002d sensor? i.e. I would have thought you
   would only get 2-002d if there were already a (conflicting) 0-002d
   or 1-002d sensor.

   Note I believe I have only one asb100 sensor (corresponding to my
   p4pe motherboard) but maybe the numbering gets mixed in with other
   i2c devices (I have a nVIdia GeForce Ti 4600 graphic board, a
   Winfast 2000XP Deluxe analog TV card, and a pcHDTV 5500 digital TV
   card).

2. Why did none of this happen in the 2.4 kernels where I just used
   as99127f-i2c-0-2d all the time?

3. What if anything can I do to 'fix' the sensor to a specific prefix?
   (Perhaps something analogous to what one does in modprobe.conf with
   the index=n option or maybe something to force the boot order to be
   consistent)


For reference, my (current) /sys/i2c/bus/devices tree looks like this:
./asb100
./asb100/0-0048
./asb100/0-0049
./asb100/0-002d
./asb100/bind
./asb100/unbind
./asb100/module
./eeprom
./eeprom/2-0050
./eeprom/0-0052
./eeprom/0-0051
./eeprom/0-0050
./eeprom/bind
./eeprom/unbind
./eeprom/module
./tuner
./tuner/1-0061
./tuner/bind
./tuner/unbind
./tuner/module
./tveeprom
./tveeprom/1-0050
./tveeprom/bind
./tveeprom/unbind
./tveeprom/module
./i2c_adapter
./i2c_adapter/bind
./i2c_adapter/unbind
./i2c_adapter/module

Of course, the sensor I am interested in reading here is: asb100/0-002d

Thanks


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

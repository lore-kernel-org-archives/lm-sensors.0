From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: need help on lm_sensors
Message-Id: <20031205080024.464910f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>  I need some help.I am trying to find the  best version of 
> lm_sensors/i2c that works with 2.2.16 kernel of Linux.I tried lot of 
> versions from 2.4 to 2.7 some of them either give compilation errors
> or depmod -a errors..some successfull.

The last 2.2-compatible version is 2.7.0, as stated on our download
page. Please note that you need to download and install i2c-2.7.0 before
you can get lm_sensors-2.7.0 to compile and work.

> Everytime i see different kind
> of results in sensor_detect.some times i see lm78 gets detected on ISA
> and some time i see it87 getting detected ..different versions bdetect
> defferent sensors.I am not sure if i am missing some thing.

Detection is a delicate process. I2C devices are not identified by a
unique number. Instead, we have to guess what each device could be
reading its contents and compare with a list of known chips. I'm not
that surprised to read that different runs of sensors-detect return
different results.

> when lm78 gets detected if i lode the modules with mod probe some
> times it shows the temparature but if do rmmod and modprobe again..it
> prints no sensors found.

Unless this is a bug in the version of lm_sensors you are using, it may
because you did not reload all the required modules. For sensors to
work, you need to load at least i2c-core, i2c-proc, a bus driver and a
chip driver (lm78 in your case). If you forgot the bus driver, you get
that "no sensors found" message.

> when it87 gets detected if i load the modules it shows me negative 
> temparature allways for temp2(cpu like -58C).

So you more likely have a lm78.

> Can you please help me to get out of this trouble to find the best 
> version of lmsensors and also if yuo can help me in clues in detecting
> the right sensor.

Use 2.7.0.

I'd also recommend that you get the latest sensors-detect version from
CVS:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
and use it instead of the one that comes with 2.7.0. This detection
script doesn't strongly depend on a given version of lm_sensors (except
that newer versions could suggest to load drivers older versions didn't
have). Since we have been improving our detection routines, it might
give better results.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

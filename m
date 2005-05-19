From: dhandler@nycap.rr.com (Dave)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Problem getting lm_sensors to function
Message-Id: <200411072243.39204.dhandler@nycap.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings!

Well .. I think I did everything right.  First let me tell you about my 
system:

Motherboard : K7S5A Pro
Sensor Chip set : SiS 950
Distro : Mandrake 10
Kernel : 2.6.3-19mdk

I did the make user and the make user_install that went great.  Did 
sensor_detect and it found most of the sensors being scanned for.  I copied 
over that config file to the rc.d/init.d directory.

Here's my dumb question.  Was I supposed to put this :

# I2C adapter drivers 
modprobe i2c-isa 
# I2C chip drivers 
modprobe sis5595 
modprobe it87 
# sleep 2 # optional 
/usr/local/bin/sensors -s # recommended

somepalce?  I know it said in some rc.* files .. if so which ones? All oif 
them?

I did enter those commands manually at a console prompt logged in as root.  
Here's what it said to me:

root@alb-69-xxx-xx-xxx dave]# modprobe i2c-isa
[root@alb-69-xxx-xx-xxx dave]# modprobe sis5595
FATAL: Module sis5595 not found.
[root@alb-69-xxx-xx-xxx dave]# modprobe it87
[root@alb-69-xxx-xx-xxx dave]# usr/local/bin/sensors -s
bash: usr/local/bin/sensors: No such file or directory
[root@alb-69-xxx-xx-xxx dave]# /usr/local/bin/sensors -s
it87-isa-0290: Can't access procfs/sysfs file for writing;
Run as root?

I ran menuconfig to see if the sis5595 module was to be created and it is or 
should have been.  There is a 'M' by it.  And the obviously the last error 
message where it fcan't access procfs/sysfs file for writing.

What do I need to do now?  Or do you need more info?  Either way let me know!

Thanks for your help!

Handler

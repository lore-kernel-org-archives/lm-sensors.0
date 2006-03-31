From: jamesd@jml.net (James Davis)
Date: Fri, 31 Mar 2006 09:19:06 +0000
Subject: [lm-sensors] Problems with i2c_i801
Message-Id: <1143796746.10346.10.camel@cressida.cert>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was about to post a support ticket but saw that I ought to post here
instead whilst the system is down. 

I'm running Debian/Etch with a 2.6.15-1-686 kernel. The I think the
system is a Dell Optiplex GX280 which from reading Dell's website gives
me an Intel 915G chipset (if I've correctly identified the system!).
Running sensors detect gave me the following to add to my modules.conf.

#----cut here----
# I2C adapter drivers
i2c-i801
# I2C chip drivers
eeprom
#----cut here----

I've loaded these modules Looking through the output of lsmod I get:

cressida:/home/james# lsmod | grep i2c
i2c_dev                 8640  0
i2c_i801                7916  0
i2c_core               19280  3 eeprom,i2c_dev,i2c_i801

sysfs appears to be correctly mounted:

cressida:/home/james# mount | grep sys
sysfs on /sys type sysfs (rw)

But when I run sensors I get the following output:

cressida:/home/james# sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!
cressida:/home/james#

Any idea what I'm doing wrong? :(

Many thanks,

James



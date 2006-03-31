From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 31 Mar 2006 10:15:26 +0000
Subject: [lm-sensors] Problems with i2c_i801
Message-Id: <20060331121526.629a00ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1143796746.10346.10.camel@cressida.cert>
In-Reply-To: <1143796746.10346.10.camel@cressida.cert>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> I'm running Debian/Etch with a 2.6.15-1-686 kernel. The I think the
> system is a Dell Optiplex GX280 which from reading Dell's website gives
> me an Intel 915G chipset (if I've correctly identified the system!).
> Running sensors detect gave me the following to add to my modules.conf.
> 
> #----cut here----
> # I2C adapter drivers
> i2c-i801
> # I2C chip drivers
> eeprom
> #----cut here----
> 
> I've loaded these modules Looking through the output of lsmod I get:
> 
> cressida:/home/james# lsmod | grep i2c
> i2c_dev                 8640  0
> i2c_i801                7916  0
> i2c_core               19280  3 eeprom,i2c_dev,i2c_i801
> 
> sysfs appears to be correctly mounted:
> 
> cressida:/home/james# mount | grep sys
> sysfs on /sys type sysfs (rw)
> 
> But when I run sensors I get the following output:
> 
> cressida:/home/james# sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> cressida:/home/james#
> 
> Any idea what I'm doing wrong? :(

Where do the "sensors" program come from? Debian package?
Hand-compiled? Which version ("sensors -v")?

Note that no hardware monitoring chip was detected on your system, so
if that's what you are after, fixing the problem above won't help you
much. Either your system has no hardware monitoring chip, or
sensors-detect failed to detect it for some reason. The complete output
of "sensors-detect" may let us help you in the second case.

-- 
Jean Delvare


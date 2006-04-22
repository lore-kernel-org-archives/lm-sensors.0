From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 22 Apr 2006 18:35:15 +0000
Subject: [lm-sensors] asb100 not working in kernel 2.6.16
Message-Id: <20060422183515.GC5933@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44496569.6030100@superig.com.br>
In-Reply-To: <44496569.6030100@superig.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paulo:

* Paulo Roma Cavalcanti <crotalus at superig.com.br> [2006-04-21 20:06:17 -0300]:
> I have been using lm_sensors for a long time
> on an Asus P4S333 motherboard.
> However, they are no longer working with the 2.6.16
> kernel series. During the boot there is a message
> saying it cannot find any i2c information.

This is in fact the same board I used to develop both the sis96x and asb100
drivers in the first place.

> Interesting is that the modules are loaded:
> 
> eeprom                  7249  0
> asb100                 20437  0
> hwmon_vid               2881  1 asb100
> hwmon                   3269  1 asb100
> i2c_sis96x              5829  0
> i2c_core               21697  3 eeprom,asb100,i2c_sis96x
> rfcomm                 36821  0
> l2cap                  24641  5 rfcomm
> 
> But if I try to read the sensors, I get:
> 
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
> My system is a Fedora 4 with latest lm_sensors from ATrpms.
> 
> Linux version 2.6.16-1.2096_FC4 (bhcompile at hs20-bc1-4.build.redhat.com)

I just booted my P4S333 with this kernel under FC4... same result.  Oddly
enough, it works just fine with a vanilla 2.6.16.

Paulo: if you run 'lspci' I think you will find device "00:02.1" to be
missing.  This is the problem.  Somehow, the vendor kernel does not do
the PCI quirk properly to "unhide" that device.  I will look into it
further tomorrow... but at least, the workaround is to use a vanilla
kernel.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 20:20:40 +0000
Subject: [lm-sensors] i2c_piix4 and adm1024 on 2.6 with Tyan S1867
Message-Id: <440B4818.9050701@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Sorry for delay,

> I have a system built around a Tyan Thunder 2500 (S1867) motherboard which has a
> Serverworks OSB4 chipset on it. In the past I have been successful at getting the lm_sensors
> code for an older 2.4 kernel to at least recognise the piix4 smbus and adm1024 chip
> but when I move to a fairly recent 2.6 kernel (2.6.15.3 to be exact), I am having problems
> even getting the piix4 device to be found by the kernel after I load the module. I get
> the following in the dmesg output when I load the module:
> 
> piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
> piix4_smbus 0000:00:0f.0: Unusual config register value
> piix4_smbus 0000:00:0f.0: Try using fix_hstcfg=1 if you experience problems
> piix4_smbus 0000:00:0f.0: Illegal Interrupt configuration (or code out of date)!
> 
> Even though I have the following modules from the 2.6.15.3 kernel tree loaded:
> 
> Module                  Size  Used by
> i2c_dev                 7648  0 
> i2c_piix4               7792  0 
> i2c_core               17024  2 i2c_dev,i2c_piix4
> 

Please can you try:

modprobe i2c-dev
i2cdetect -l
You should see the PIIX4 bus.

Then you can try:
i2cdetect 0
Assuming 0 is the bus ID.
Please post it here.

> I do not see anything regarding I2C in /proc/bus/ and when I try running
> systool to look at the i2c sysfs entries I see nothing either.

You mean the /sys/bus/i2c/devices?

> Any suggestions as to what might be causing this?

Maybe because the driver is not implemnted?

> Is there any progress on porting the ADM1024 module code to the 2.6 kernel tree?

You are the first after many years, so this has no priority (+20) in fact.

If you want you can try to port the driver with our help or pay/donate for that.

Regards
Rudolf




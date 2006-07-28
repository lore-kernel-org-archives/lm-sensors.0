From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Jul 2006 18:37:12 +0000
Subject: [lm-sensors] Macs with Intel 82801G (ICH7 Family)
Message-Id: <20060728203712.da818e24.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

Moving to the sensors list, as I see no i2c bug/problem here.

> It seems that all the Macs (MacBook, MacBook Pro, iMac, Mac Mini) with
> Intel chips use this 82801G chip.
> 
> See: http://www.mactel-linux.org/wiki/Lspci
> 
> I cannot get sensors-detect to detect anything. I'd particularly like to
> monitor CPU temperature, if that's possible. Fan speed would be good too.
>
> Here's some relevant output. Thanks for any help.
> 
> Some output from sensors-detect is currently at:
> http://wiki.debian.org/MacBook

It shows no hardware monitoring chips on the SMBus. There are chips at
addresses 0x38 and 0x3a, it's uncommon, I wonder what chips this can
be. The ISA and Super-I/O probes are skipped so I can't comment on
that. Please provide the complete output of sensors-detect on your
system.

> In my MacBook I also get:
> 
> lspci -v|egrep -e 'ISA|SMBus' -A3
> 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
> Bridge (rev 02)
>         Subsystem: Intel Corporation Unknown device 7270
>         Flags: bus master, medium devsel, latency 0
>         Capabilities: [e0] Vendor Specific Information
> --
> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
> (rev 02)
>         Subsystem: Intel Corporation Unknown device 7270
>         Flags: medium devsel, IRQ 11
>         I/O ports at efa0 [size2]
> 
> lspci -n | grep 00:1f\.0
> 00:1f.0 0601: 8086:27b9 (rev 02)
> 
> lspci -n | grep 00:1f\.3
> 00:1f.3 0c05: 8086:27da (rev 02)

This device most probably works just fine. This is the SMBus master,
which controls your I2C bus. But there don't seem to be known hardware
monitoring chips on it.

> lsmod |grep i2c
> i2c_dev                10144  0
> i2c_i801               11148  0
> i2c_core               22400  3 i2c_dev,eeprom,i2c_i801
> 
> sensors -v
> sensors version 2.10.0 with libsensors version 2.10.0
> 
> sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!

Don't be fooled by this irrelevant message. All it really means is: no
sensors found. I think we fixed that in SVN already.

> dmesg |grep -i error
> i801_smbus 0000:00:1f.3: Error: no response!
> [repeated about 46 times]

You must have debugging enabled. Then this is expected when probing the
bus (as sensors-detect and i2cdetect do, and also all i2c chip drivers
at load time.) Nothing to worry about.

-- 
Jean Delvare


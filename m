From: ballen@gravity.phys.uwm.edu (Bruce Allen)
Date: Thu, 02 Mar 2006 02:12:39 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <Pine.LNX.4.62.0603012012060.27761@trinity.phys.uwm.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>  IPMI kcs interface initialized
>> ipmi device interface
>> eth0: no IPv6 routers present
>
> interestingly there is no info from piix4 module...
>
>>> and try
>>> ls /sys/class
>>> (there is typicaly hwmon class, if yes, list it too)
>> 
>> [root at nemo-slave0017 ~]# ls /sys/class/
>> cpuid  firmware  graphics  hwmon  i2c-adapter  i2c-dev  input  ipmi  mem 
>> misc  msr  net  pci_bus  printer  scsi_device  scsi_host  tty  usb 
>> usb_device  usb_host  vc
>> [root at nemo-slave0017 ~]# ls /sys/class/hwmon/
>> [root at nemo-slave0017 ~]# ls /sys/class/i2c-adapter/
>> i2c-9191
>> [root at nemo-slave0017 ~]# ls /sys/class/i2c-dev/
>> [root at nemo-slave0017 ~]#
>> 
>
> Hmm, it really seems as if BMC "disconnected" i2c bus from HT1000 bus. It 
> would be interesting to try with BMC withdrawn. I'll test once I get the BMC.

I'll give this a try tomorrow also.  It's easy to yank out the BMC.

Cheers,
 	Bruce


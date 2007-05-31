From: "KEITH ROMBERG" <k_romberg@msn.com>
Date: Thu, 31 May 2007 21:16:48 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <BAY117-F35096E5BE5D175AF56AA82932D0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1471217724921110994=="
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
To: lm-sensors@vger.kernel.org

--===============1471217724921110994==
Content-Type: text/plain; format=flowed

Hey Juerg,

OK, I also loaded ipmi_msghandler as I was not loading it before.  I am not 
loading these modules in my rc.local file:

i2c-piix4
i2c-ipmi
eeprom
ipmisensors
ipmi_msghandler
hwmon

in that order.  Looking at /sys/classes, it is empty.  When I manually load 
the modules, via rmmod & modprobe, and look at /var/log/messages the only 
entries are:

May 31 15:01:26 smaug kernel: ipmi message handler version 39.1
May 31 15:01:26 smaug kernel: ipmisensors - IPMI BMC sensors interface


As I said before I am using 2.6.21 patched with the experimential ipmi 
patch.  Juerg what kernel are you using and do you also have a SRSH4 based 
system?  Any other pointers are things to try?

Thanks,
Keith

>
>Keith,
>
>Make sure you have the ipmisensors and ipmi_msghandler modules
>installed. Check if there are any entries under /sys/class/hwmon.
>Check /var/log/messages, it should read something like the following
>after loading the ipmisensors module:
>
>May 30 14:37:54 clim1 kernel: ipmisensors - IPMI BMC sensors interface
>May 30 14:37:54 clim1 kernel: ipmisensors: Registered IPMI 2.0 BMC
>over interface 0
>May 30 14:37:54 clim1 kernel: ipmisensors: Skipping SDR type 0xc0
>May 30 14:37:54 clim1 kernel: ipmisensors: Skipping SDR type 0x8
>May 30 14:37:54 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 1"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 2"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 3"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 4"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 5"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 6"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 7"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 8"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fan 9"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
>sensor "Fan 10"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
>sensor "Fan 11"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold
>sensor "Fan 12"
>May 30 14:37:55 clim1 kernel: ipmisensors: skipping non-threshold sensor 
>"Fans"
>May 30 14:37:55 clim1 kernel: ipmisensors: Skipping SDR type 0x8
>May 30 14:37:55 clim1 kernel: ipmisensors: all sensors detected
>May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 27:
>(type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0xc9; mask=0x0030)
>May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp1 "Temp 
>6"
>May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
>threshold for upper limit
>May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 26:
>(type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0xc9; mask=0x0030)
>May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp2 "Temp 
>5"
>May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
>threshold for upper limit
>May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 25:
>(type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0xc9; mask=0x0030)
>May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp3 "Temp 
>4"
>May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
>threshold for upper limit
>May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 24:
>(type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0xc9; mask=0x0030)
>May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp4 "Temp 
>3"
>May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
>threshold for upper limit
>May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 23:
>(type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0xc9; mask=0x0030)
>May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp5 "Temp 
>2"
>May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
>threshold for upper limit
>May 30 14:37:55 clim1 kernel: ipmisensors: registering sensor 22:
>(type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0xc9; mask=0x0030)
>May 30 14:37:55 clim1 kernel: ipmisensors: sensors.conf: label temp6 "Temp 
>1"
>May 30 14:37:55 clim1 kernel: ipmisensors: using upper critical
>threshold for upper limit
>May 30 14:37:55 clim1 kernel: ipmisensors: registered 6 temp, 0 volt,
>0 current, 0 fan sensors
>
>
>Running sensors works fine for me:
>
>clim1:~# sensors
>bmc-isa-0000
>Adapter: ISA adapter
>temp1:      +0.0���C  (high =    +7���C, hyst =    +0���C)
>temp2:     +44.0���C  (high =    +6���C, hyst =    +0���C)
>temp3:     +40.0���C  (high =    +6���C, hyst =    +0���C)
>temp4:     +31.0���C  (high =   +10���C, hyst =    +0���C)
>temp5:      +0.0���C  (high =   +10���C, hyst =    +0���C)
>temp6:     +18.0���C  (high =    +4���C, hyst =    +0���C)
>
>
>...juerg
>
>
>




--===============1471217724921110994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1471217724921110994==--

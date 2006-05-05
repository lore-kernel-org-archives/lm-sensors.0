From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Fri, 05 May 2006 19:34:49 +0000
Subject: [lm-sensors]
Message-Id: <200605052134.50033.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
Am Mittwoch, 3. Mai 2006 23:37 schrieben Sie:
> Hello Dieter
> Now my questions:
>
> Does it start to work after reboot? 
No. But this is a mobo issue I see with all 2460 Tyan Tiger independent of 
this problem.
> After cold boot? 
No! The reset button does *not* cure the problem. This is different from 
"normal" behaviour"
> After power unplug? 
Yes. Nothing else that helps.
> Have you ACPI in kernel? 
Yes. Any info required on that?
> Have you compiled/loaded/in kernel the thermal module?
I load:
i2c-amd756
i2c-isa
w83781d
eeprom
(in this sequence) during boot. This is done via /etc/sysconfig/lm_sensors. I 
do not know about i2c-dev. However, lsmod | grep i2c gives the following 
output:
i2c_sensor              7936  2 eeprom,w83781d
i2c_isa                 6400  0 
i2c_algo_bit           13448  0 
i2c_amd756             11908  0 
i2c_core               27136  7 
eeprom,w83781d,i2c_sensor,i2c_isa,i2c_algo_bit,ivtv_tveeprom,i2c_amd756
I do not see i2c-dev being loaded. However, it exists compiled as a module, 
therefore I am convinced that it is not residing in the kernel.


> If it will happen again in future you may try following:
It will :-(

This is my homework, I'll be back with you as soon as I have results to tell.
>
> 1) obtain the smb base addr
> 	AMD756_smba = xxx
> Should be in your debug log, you may use value from older log because it
> does not change. Alternatively you may also look into cat /proc/ioports
>
> then you may use the isadump tool
> 2)
> isadump -f xxx
>
> (please replace the xxx with the base address from the log) This will allow
> us to check the status of the SMBDATA and SMBCLK lines and see if they are
> stuck low. Eventually we can try to excersise the DATA and CLK lines to see
> if they are working properly.
>
> You may also try to provoke the failure by running this:
>
> modprobe i2c-dev
> modprobe i2c-amd756
> while true; do i2cdump -y 0 0x2d b > /dev/null; done
Thanks for helping that far. I will unload the debug kernel now as it spits 
about 400 MByte of i2c-debug logs into /var/log/messages.

Takte care,



Dieter Jurzitza


-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------


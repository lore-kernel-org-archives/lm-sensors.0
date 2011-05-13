From: Jeff Rickman <jrickman@myamigos.us>
Date: Fri, 13 May 2011 17:47:07 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DCD6E9B.7020700@myamigos.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010203020409090502010607"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203020409090502010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/2011 11:44 AM, Jean Delvare wrote:
> On Fri, 13 May 2011 09:42:28 -0600, Harry G McGavran Jr wrote:
>> This new i8k seems to work on my system.
>>
>> =========================================
>>
>> XX% /usr/bin/sensors
>> i8k-virtual-0
>> Adapter: Virtual device
>> Left Fan:   64650 RPM
>> Right Fan:  48390 RPM
>
> As said before, you'd need option fan_mult=1 to get proper readings.
> But well, in the long run I guess you'll stop using i8k anyway, as it
> provides fewer values than the emc6w201 driver.
>
>> emc6w201-i2c-0-2e
>> Adapter: SMBus I801 adapter at e8a0
>> Aux:            +1.82 V  (min =  +1.64 V, max =  +1.98 V)
>> CPU VCore:      +1.26 V  (min =  +0.78 V, max =  +1.70 V)
>> +3.3V:          +3.33 V  (min =  +3.08 V, max =  +3.52 V)
>> +5V:            +5.10 V  (min =  +4.66 V, max =  +5.34 V)
>> +12V:          +12.06 V  (min =  +0.81 V, max = +12.81 V)
>> Chassis:       1613 RPM  (min =  300 RPM)
>> CPU:           2153 RPM  (min =  200 RPM)
>> CPU:            +54.0 C  (low  = -127.0 C, high = +88.0 C)
>> Remote Diode 5: +48.0 C  (low  = -127.0 C, high = +75.0 C)
>> Mainboard:      +44.0 C  (low  = -127.0 C, high = +80.0 C)
>>
>> ===============================================
>>
>> The only entry in syslog as a result of the above is:
>>
>> May 13 09:37:40 kahu kernel: [167232.194108] i8k: unable to get SMM BIOS
>> version
>>
>> but that has occurred with all the i8k's I've tried.
>
> Looks very promising. Now let's wait for Jeff's report.
>

I have promising results; no crash messages. "sensors" out that shows 
N/A. See attached.

I still need to use the "force" option or else I get the "no such 
device" error message. See attached.


--------------010203020409090502010607
Content-Type: text/plain;
 name="Dell_Sensors_Testing_6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Dell_Sensors_Testing_6.txt"

# modprobe -v i8k
insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko 
FATAL: Error inserting i8k (/lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko): No such device

# tail /var/log/messages
May 13 12:38:52 XX kernel: [   88.685362] i8k: unable to get SMM Dell signature

# modprobe -v i8k force 
insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko force

# tail /var/log/messages
May 13 12:38:52 XX kernel: [   88.685362] i8k: unable to get SMM Dell signature
May 13 12:39:12 XX kernel: [  108.804152] i8k: unable to get SMM Dell signature
May 13 12:39:12 XX kernel: [  108.805114] i8k: unable to get SMM BIOS version
May 13 12:39:12 XX kernel: [  108.816693] Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)

# sensors
i8k-virtual-0
Adapter: Virtual device
Left Fan:         N/A
Right Fan:        N/A

No further messages in Syslog. No error messages related to running "sensors" command.


--------------010203020409090502010607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010203020409090502010607--

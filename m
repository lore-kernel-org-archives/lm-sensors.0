From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 Apr 2011 12:42:13 +0000
Subject: Re: [lm-sensors] PATCH: systemd integration
Message-Id: <4DB80F25.2090101@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DB430EC.5070007@redhat.com>
In-Reply-To: <4DB430EC.5070007@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks for the review.

On 04/27/2011 10:56 AM, Jean Delvare wrote:
> Hi Hans,
>
> On Sun, 24 Apr 2011 16:17:16 +0200, Hans de Goede wrote:
>> The attached patch:
>> 1) uses systemd's systemctl to start / stop / enable the lm_sensors service on
>> systemd systems (such as Fedora 15)
>> 2) recognizes the new /run dir for run time info (as used by systemd systems)
>> as a possible place where the udev db can live
>> 3) adds a lm_sensor.service file to install under /lib/systemd/system
>>
>> Please review, I'll push it to svn myself once acked.
>
> I don't know anything about systemd, but the patch looks good and I'm
> all for better integration of upstream lm-sensors so that every
> distribution doesn't have to do it all again.

Yes that was the idea (not every distro having to do it all again,
and also consistent behavior between distros).

>
> Comments:
>
>> Index: prog/init/lm_sensors.service
>> =================================>> --- prog/init/lm_sensors.service	(revision 0)
>> +++ prog/init/lm_sensors.service	(revision 0)
>> @@ -0,0 +1,14 @@
>> +[Unit]
>> +Description=lm_sensors for monitoring motherboard sensor values
>
> lm-sensors is not (or shouldn't be) limited to motherboard sensors.
> Sensors on CPU, memory modules and graphics cards are supported too, and
> hopefully hard disk drive temperatures will be someday too.

Agreed (I didn't write the service file it was contributed by a Fedora user).
>
>> +After=syslog.target
>> +
>> +[Service]
>> +EnvironmentFile=/etc/sysconfig/lm_sensors
>> +Type=oneshot
>> +RemainAfterExit=yes
>> +ExecStart=-/sbin/modprobe -qab $BUS_MODULES $HWMON_MODULES
>> +ExecStart=/usr/bin/sensors -s
>> +ExecStop=-/sbin/modprobe -qabr $BUS_MODULES $HWMON_MODULES
>
> Please keep in mind that both $BUS_MODULES and $HWMON_MODULES may be
> empty, which would cause the above modprobe commands to return an
> error. Still it is legitimate to start the service so that "sensors -s"
> is executed.

Right, AFAIK the  - in front of the command tells systemd to ignore
the return value.

>
>> +
>> +[Install]
>> +WantedBy=multi-user.target
>> Index: prog/detect/sensors-detect
>> =================================>> --- prog/detect/sensors-detect	(revision 5939)
>> +++ prog/detect/sensors-detect	(working copy)
>> @@ -2339,7 +2339,7 @@
>>   	if (!$use_udev) {
>>   		# Try some known default udev db locations, just in case
>>   		if (-e '/dev/.udev.tdb' || -e '/dev/.udev'
>> -		 || -e '/dev/.udevdb') {
>> +		 || -e '/dev/.udevdb' || -e '/run/udev') {
>>   			$use_udev = 1;
>>   			$dev_i2c = '/dev/i2c-';
>>   		}
>> @@ -6378,6 +6378,14 @@
>>   		}
>>   		close(SYSCONFIG);
>>
>> +		if (-x "/bin/systemctl"&&
>> +		    -f "/lib/systemd/system/lm_sensors.service") {
>> +			system("/bin/systemctl", "enable", "lm_sensors.service");
>> +			system("/bin/systemctl", "start", "lm_sensors.service");
>> +			# All done, don't check for /etc/init.d/lm_sensors
>> +			return;
>> +		}
>> +
>>   		print "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".
>>   		      "for initialization at boot time.\n"
>>   			unless -f "/etc/init.d/lm_sensors";
>
> Don't you want to display a smiliar message for the systemd case? Users
> installing manually will have to copy prog/init/lm_sensors.service
> to /lib/systemd/system/lm_sensors.service for initialization at boot
> time.

I was going with the assumption that systemd users will get lm_sensors from
their distro. I'll whip up an updated patch adding a check for this.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

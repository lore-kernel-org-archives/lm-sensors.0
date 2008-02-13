From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 13 Feb 2008 12:07:33 +0000
Subject: Re: [lm-sensors] PATCH: make lm_sensors init script return values
Message-Id: <47B2DD85.9020705@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B039BA.8020707@hhs.nl>
In-Reply-To: <47B039BA.8020707@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 

Hi Jean,

Thanks for the thorough review!

> On Mon, 11 Feb 2008 13:04:10 +0100, Hans de Goede wrote:
>> I've received the attached patch through Fedora's bugzilla. It fixes the return 
>> values of the various error exit cases to match the LSB spec:
>> http://refspecs.linux-foundation.org/LSB_3.2.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
>>
>> It looks sane to me, if there are no objections I'll commit it to svn.
> 
>> --- lm_sensors.orig	2008-02-07 11:37:22.000000000 -0500
>> +++ lm_sensors	2008-02-07 11:41:04.000000000 -0500
>> @@ -40,15 +40,15 @@
>>  
>>  	# Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
>>  	# support for sensors.
>> -	[ -e /proc/sys/dev/sensors ] || exit 0
>> +	[ -e /proc/sys/dev/sensors ] || exit 6
> 
> Note that this doesn't work with a 2.6 kernel anyway, which makes me
> wonder whether it's worth keeping these init files in the lm-sensors
> tree. Obviously no distribution uses them as-is.
> 

It helps to read the whole script before jumping to conclusions like this, 
above this is:
if grep -q sysfs /proc/mounts; then
         WITHSYS=1
else
         WITHSYS=0
fi

if [ $WITHSYS = "0" ]; then

So this piece of code doesn't get executed on 2.6 kernels with sysfs enabled. 
And actually atleast one distro (Fedora) is using the scrip as is.

>>  
>>  	# If sensors was not already running, unload the module...
>>  	[ -e /var/lock/subsys/lm_sensors ] || /sbin/modprobe -r i2c-proc >/dev/null 2>&1
>>  fi
>>  
>>  CONFIG=/etc/sysconfig/lm_sensors
>> -[ -r "$CONFIG" ] || exit 0
>> -grep '^MODULE_' $CONFIG >/dev/null 2>&1 || exit 0
>> +[ -r "$CONFIG" ] || exit 6
>> +grep '^MODULE_' $CONFIG >/dev/null 2>&1 || exit 6
> 
> I am worried that this error check (and the one above) is done
> independently of the command, i.e. also for command "status", while the
> document you mentioned above states that the error codes are different
> for this command, and "6" isn't valid there. So I think that the
> configuration file check and loading should be moved to the specific
> commands that need it (start and stop as far as I can see) before you
> can return 6 on missing configuration file.
> 

Good point I'll do a new version of the patch where all these checks are put in 
a function and that function only gets called from the relevant commands.

>>  
>>  # Load config file
>>  . "$CONFIG"
>> @@ -147,7 +147,7 @@
>>  	;;
>>    *)
>>  	echo "Usage: $0 {start|stop|status|restart|reload|condrestart}"
>> -	exit 1
>> +	exit 3
> 
> None of the init scripts in openSuse does this. They all use "exit 1",
> and that sounds reasonable to me. If the user runs "lm_sensors blah",
> it will fail, not because it is an "unimplemented feature" (3) but
> because the user typed a command that doesn't exist. So I wouldn't
> change it, but if you really don't like 1, then 2 ("invalid or excess
> argument(s)") would be a better choice (we have one openSuse script
> that does this.)
> 

Okay, I'll change things to keep exit 1 in this case.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 26 Feb 2008 13:44:21 +0000
Subject: Re: [lm-sensors] PATCH: make lm_sensors init script return values
Message-Id: <47C417B5.3010101@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020400040307050302090203"
List-Id: <lm-sensors.vger.kernel.org>
References: <47B039BA.8020707@hhs.nl>
In-Reply-To: <47B039BA.8020707@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020400040307050302090203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Hans,
> 
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

Fixed, new version attached.

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

I've kept the exit 3, this patch was submitted to make the initscripts work 
with some gui service configuration tools, these will never pass a non existing 
command, but might pass a not supported one, in which case exit 3 is correct. I 
don't think any non automated tools will care, and for the automated ones exit 
3 is the best return code I believe.

New proposed patch attached.

Thanks & Regards,

Hans

--------------020400040307050302090203
Content-Type: text/plain;
 name="lm_sensors-3.0.1-lsb-retcodes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm_sensors-3.0.1-lsb-retcodes.patch"

--- lm_sensors-3.0.1/prog/init/lm_sensors.init	2008-02-26 14:37:51.000000000 +0100
+++ lm_sensors-3.0.1.new/prog/init/lm_sensors.init	2008-02-26 14:25:13.000000000 +0100
@@ -28,31 +28,6 @@
 # in order as normal shell variables with the special names:
 #    MODULE_1, MODULE_2, MODULE_3, etc.
 
-if grep -q sysfs /proc/mounts; then
-	WITHSYS=1
-else
-	WITHSYS=0
-fi
-
-if [ $WITHSYS == "0" ]; then
-	# If sensors isn't supported by the kernel, try loading the module...
-	[ -e /proc/sys/dev/sensors ] || /sbin/modprobe i2c-proc >/dev/null 2>&1
-
-	# Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
-	# support for sensors.
-	[ -e /proc/sys/dev/sensors ] || exit 0
-
-	# If sensors was not already running, unload the module...
-	[ -e /var/lock/subsys/lm_sensors ] || /sbin/modprobe -r i2c-proc >/dev/null 2>&1
-fi
-
-CONFIG=/etc/sysconfig/lm_sensors
-[ -r "$CONFIG" ] || exit 0
-grep '^MODULE_' $CONFIG >/dev/null 2>&1 || exit 0
-
-# Load config file
-. "$CONFIG"
-
 PSENSORS=/usr/local/bin/sensors
 
 if [ ! -x $PSENSORS ]; then
@@ -65,7 +40,47 @@
 RETVAL=0
 prog="lm_sensors"
 
+# This functions checks if sensor support is compiled into the kernel, if
+# sensors are configured, and loads the config file
+check_sensors() {
+	if grep -q sysfs /proc/mounts; then
+		WITHSYS=1
+	else
+		WITHSYS=0
+	fi
+
+	if [ $WITHSYS == "0" ]; then
+		# If sensors isn't supported by the kernel, try loading the module...
+		[ -e /proc/sys/dev/sensors ] || /sbin/modprobe i2c-proc >/dev/null 2>&1
+
+		# Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
+		# support for sensors.
+		if ! [ -e /proc/sys/dev/sensors ]; then
+			echo -n "Starting $prog: kernel does not have sensors support"
+			echo_failure
+			echo
+			exit 5
+		fi
+
+		# If sensors was not already running, unload the module...
+		[ -e /var/lock/subsys/lm_sensors ] || /sbin/modprobe -r i2c-proc >/dev/null 2>&1
+	fi
+
+	CONFIG=/etc/sysconfig/lm_sensors
+	if ! [ -r "$CONFIG" ] || ! grep '^MODULE_' $CONFIG >/dev/null 2>&1; then
+		echo -n "Starting $prog: not configured, run sensors-detect"
+		echo_warning
+		echo
+		exit 6
+	fi
+
+	# Load config file
+	. "$CONFIG"
+}
+
 start() {
+	check_sensors
+
 	echo -n "Starting $prog: loading module "
 
 	modules=`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
@@ -89,6 +104,8 @@
 }
 
 stop() {
+	check_sensors
+
 	echo -n "Stopping $prog: "
 
 	modules=`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
@@ -116,12 +133,14 @@
 dostatus() {
 	$PSENSORS
 	RETVAL=$?
+	if [ $RETVAL -ne 0 ]; then
+		RETVAL=3
+	fi
 }
 
 restart() {
 	stop
 	start
-	RETVAL=$?
 }
 
 condrestart() {
@@ -147,7 +166,7 @@
 	;;
   *)
 	echo "Usage: $0 {start|stop|status|restart|reload|condrestart}"
-	exit 1
+	exit 3
 esac
 
 exit $RETVAL

--------------020400040307050302090203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020400040307050302090203--

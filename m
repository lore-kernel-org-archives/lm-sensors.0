From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 26 Feb 2008 14:11:45 +0000
Subject: Re: [lm-sensors] Patch: don't start initscript by default on
Message-Id: <47C41E21.4060805@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090500050005000409060300"
List-Id: <lm-sensors.vger.kernel.org>
References: <47B04B1C.9070405@hhs.nl>
In-Reply-To: <47B04B1C.9070405@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500050005000409060300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 11 Feb 2008 14:18:20 +0100, Hans de Goede wrote:
>> The attached patch modifies the initscript included with lm_sensors so that it 
>> doesn't start by default on chkconfig using systems.
>>
>> The patch also modifies sensors-detect to activate the initscript once 
>> lm_sensors has been successfully configured.
>>
>> If I don't get any objections I will be committing this to svn in a couple of days.
> 
> Overall I am fine with this change (it doesn't affect openSuse.)
> 
>> diff -up lm_sensors-3.0.1/prog/detect/sensors-detect.foo lm_sensors-3.0.1/prog/detect/sensors-detect
>> --- lm_sensors-3.0.1/prog/detect/sensors-detect.foo	2008-01-22 13:22:47.000000000 +0100
>> +++ lm_sensors-3.0.1/prog/detect/sensors-detect	2008-02-11 13:42:04.000000000 +0100
>> @@ -5943,6 +5943,15 @@ EOT
>>  
>>      if (-x "/sbin/insserv" && -f "/etc/init.d/lm_sensors") {
>>        system("/sbin/insserv", "/etc/init.d/lm_sensors");
>> +    } elsif (-x "/sbin/chkconfig" && -f "/etc/init.d/lm_sensors") {
>> +      system("/sbin/chkconfig", "lm_sensors", "on");
>> +      if (-x "/sbin/service") {
>> +        if (-f "/var/lock/subsys/lm_sensors") {
>> +          system("/sbin/service", "lm_sensors", "restart");
>> +        } else {
>> +          system("/sbin/service", "lm_sensors", "start");
>> +        }
> 
> My only worry is to see the lock file name "leak" to sensors-detect.
> I'd prefer it to be only mentioned in the initialization script
> itself... Is there any problem to calling "restart" unconditionally? Or
> maybe even better, shouldn't we call "stop" at the beginning of
> sensors-detect? Probing for devices while the hwmon drivers are loaded
> has side effects we probably want to avoid anyway.
> 

Calling stop at the start of sensors-detect is a good idea, new version 
attached. This once again shouldn't effect any non RedHat derived distro's, but 
still a quick review would be a good idea I think.

Regards,

Hans

--------------090500050005000409060300
Content-Type: text/plain;
 name="lm_sensors-3.0.1-service-default-off.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="lm_sensors-3.0.1-service-default-off.patch"

--- lm_sensors-3.0.1/prog/init/lm_sensors.init.default-off	2007-04-27 14:34:17.000000000 +0200
+++ lm_sensors-3.0.1/prog/init/lm_sensors.init	2008-02-26 14:55:58.000000000 +0100
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# chkconfig: 2345 26 74
+# chkconfig: - 26 74
 # description: sensors is used for monitoring motherboard sensor values.
 # config: /etc/sysconfig/lm_sensors
 #
--- lm_sensors-3.0.1/prog/detect/sensors-detect.default-off	2008-01-22 13:22:47.000000000 +0100
+++ lm_sensors-3.0.1/prog/detect/sensors-detect	2008-02-26 15:00:07.000000000 +0100
@@ -5673,6 +5673,11 @@ sub main
     exit -1;
   }
 
+  if (-x "/sbin/service" && -f "/etc/init.d/lm_sensors" &&
+      -f "/var/lock/subsys/lm_sensors") {
+    system("/sbin/service", "lm_sensors", "stop");
+  }
+
   initialize_kernel_version();
   initialize_conf;
   initialize_proc_pci;
@@ -5943,6 +5948,11 @@ EOT
 
     if (-x "/sbin/insserv" && -f "/etc/init.d/lm_sensors") {
       system("/sbin/insserv", "/etc/init.d/lm_sensors");
+    } elsif (-x "/sbin/chkconfig" && -f "/etc/init.d/lm_sensors") {
+      system("/sbin/chkconfig", "lm_sensors", "on");
+      if (-x "/sbin/service") {
+        system("/sbin/service", "lm_sensors", "start");
+      }
     } else {
       print "You should now start the lm_sensors service to load the required\n".
             "kernel modules.\n\n";

--------------090500050005000409060300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090500050005000409060300--

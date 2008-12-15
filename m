From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 22:39:35 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-f71882fg-16-add-and-update-doc.patch
Message-Id: <4946DCA7.5060307@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030702070408040705010002"
List-Id: <lm-sensors.vger.kernel.org>
References: <49465C1C.7000800@redhat.com>
In-Reply-To: <49465C1C.7000800@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030702070408040705010002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Jean Delvare wrote:
> On Mon, 15 Dec 2008 14:31:08 +0100, Hans de Goede wrote:
>> Hi Jean,
>>
>> Add some documentation about the f71882fg driver, and update the Kconfig
>> documentation to report the new supported models.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Review:
> 

Thanks, updated version with all found issues fixed attached.

Regards,

Hans


>> Add some documentation about the f71882fg driver, and update the Kconfig
>> documentation to report the new supported models.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> diff -up vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg.foo vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg
>> --- vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg.foo	2008-12-15 13:21:31.000000000 +0100
>> +++ vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg	2008-12-15 14:25:54.000000000 +0100
>> @@ -0,0 +1,89 @@
>> +Kernel driver f71882fg
>> +======================
>> +
>> +Supported chips:
>> +  * Fintek F71882FG or F71883FG
> 
> I certainly hope this is "and", not "or" ;)
> 
>> +    Prefix: 'f71882fg'
>> +    Addresses scanned: none, address read from Super I/O config space
>> +    Datasheet: Available from the Fintek website
>> +  * Fintek F71862FG or F71863FG
> 
> Ditto.
> 
>> +    Prefix: 'f71862fg'
>> +    Addresses scanned: none, address read from Super I/O config space
>> +    Datasheet: Available from the Fintek website
>> +  * Fintek F8000
>> +    Prefix: 'f8000'
>> +    Addresses scanned: none, address read from Super I/O config space
>> +    Datasheet: Not public
>> +
>> +Author: Hans de Goede <hdegoede@redhat.com>
>> +
>> +
>> +Description
>> +-----------
>> +
>> +The Fintek F718xxFG/F8000 Super I/O chip includes complete hardware monitoring
>> +capabilities. It can monitor up to 9 voltages (3 for the F8000), 4 fans and
>> +3 temperature sensors.
> 
> The use of a singular to designate 3 different chips sounds strange
> IMHO.
> 
>> +
>> +This chip also has fan controlling features, using either DC or PWM, in
>> +three different modes (one manual, two automatic).
>> +
>> +The driver assumes that no more than one chip is present, which seems
>> +reasonable.
>> +
>> +
>> +Monitoring
>> +----------
>> +
>> +The Voltage, Fan and Temperature Monitoring uses the standard sysfs
>> +interface as documented in sysfs-interface, without any exceptions.
>> +
>> +
>> +Fan Control
>> +-----------
>> +
>> +Both PWM (pulse-width modulation) and DC fan speed control methods are
>> +supported. The right one to use depends on external circuitry on the
>> +motherboard, so the driver assumes that the BIOS set the method
>> +properly.
>> +
>> +There are 2 modes to specify the speed of the fan, PWM duty cycle (or DC
>> +voltage) mode, where 0-100% duty cycle (0-100% of 12V) is specified. And RPM
>> +mode where the actual RPM of the fan (as measured) is controled and the speed
> 
> Spelling: controlled.
> 
>> +gets specified as 0-100% of the fan#_full_speed file.
>> +
>> +Since both modes work in a 0-100% (mapped to 0-255) scale, there isn't a
>> +whole lot of a difference when modifying fan control settings. The only
>> +important difference is that in RPM mode the 0-100% controls the fan speed
>> +between 0-100% of fan#_full_speed. It is assumed that if the BIOS programs
>> +RPM mode, it will also set fan#_full_speed properly, if it does not then
>> +fan control will not work properly, unless you set a sane fan#_full_speed
>> +value yourself.
>> +
>> +Switching between these modes requires re-initializing a whole bunch of
>> +registers, so the mode which the BIOS has set is kept. The mode is
>> +printed when loading the driver.
>> +
>> +Three different fan control modes are supported; the mode number is written
>> +to the pwm<n>_enable file. Note that not all modes are supported on all
> 
> This mix of # and <n> for channel number is a bit confusing.
> 
>> +chips, and some modes may only be available in RPM / PWM mode on the F8000.
>> +Writing an unsupported mode will result in an invalid parameter error.
>> +
>> +* 1: Manual mode
>> +  You ask for a specific PWM duty cycle / DC voltage or a specific % of
>> +  fan#_full_speed by writing to the pwm<n> file. This mode is only
>> +  available on the F8000 if the fan channel is in RPM mode.
>> +
>> +* 2: Normal auto mode
>> +  You can define a number of temperature/fan speed trip points, which % the
>> +  fan should run at at this temp and which temp a fan should follow using the
>> +  standard sysfs interface. The number and type of trip points is chip
>> +  depended, see which files are available in sysfs.
>> +  Fan/PWM channel 3 of the F8000 is always in this mode!
>> +
>> +* 3: Thermostat mode (Only available on the F8000 when in duty cycle mode)
>> +  The fan speed is regulated to keep the temp the fan is mapped to between
>> +  temp#_auto_point2_temp and temp#_auto_point3_temp.
>> +
>> +Both of the automatic modes require that pwm1 corresponds to fan1, pwm2 to
>> +fan2 and pwm3 to fan3.
>> diff -up vanilla-2.6.28-rc8/drivers/hwmon/Kconfig.foo vanilla-2.6.28-rc8/drivers/hwmon/Kconfig
>> --- vanilla-2.6.28-rc8/drivers/hwmon/Kconfig.foo	2008-12-15 14:26:14.000000000 +0100
>> +++ vanilla-2.6.28-rc8/drivers/hwmon/Kconfig	2008-12-15 14:27:32.000000000 +0100
>> @@ -284,11 +284,12 @@ config SENSORS_F71805F
>>  	  will be called f71805f.
>>  
>>  config SENSORS_F71882FG
>> -	tristate "Fintek F71882FG and F71883FG"
>> +	tristate "Fintek F71862FG, F71882FG and F8000"
>>  	depends on EXPERIMENTAL
>>  	help
>>  	  If you say yes here you get support for hardware monitoring
>> -	  features of the Fintek F71882FG and F71883FG Super-I/O chips.
>> +	  features of the Fintek F71882FG/F71883FG, F71862FG/71863FG
>> +	  and F8000 Super-I/O chips.
>>  
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called f71882fg.
> 
> 
> 

--------------030702070408040705010002
Content-Type: text/plain; name="hwmon-f71882fg-16-add-and-update-doc-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-f71882fg-16-add-and-update-doc-v2.patch"

Add some documentation about the f71882fg driver, and update the Kconfig
documentation to report the new supported models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg.foo vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg
--- vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg.foo	2008-12-15 13:21:31.000000000 +0100
+++ vanilla-2.6.28-rc8/Documentation/hwmon/f71882fg	2008-12-15 14:25:54.000000000 +0100
@@ -0,0 +1,89 @@
+Kernel driver f71882fg
+======================
+
+Supported chips:
+  * Fintek F71882FG and F71883FG
+    Prefix: 'f71882fg'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Available from the Fintek website
+  * Fintek F71862FG and F71863FG
+    Prefix: 'f71862fg'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Available from the Fintek website
+  * Fintek F8000
+    Prefix: 'f8000'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Not public
+
+Author: Hans de Goede <hdegoede@redhat.com>
+
+
+Description
+-----------
+
+Fintek F718xxFG/F8000 Super I/O chips include complete hardware monitoring
+capabilities. They can monitor up to 9 voltages (3 for the F8000), 4 fans and
+3 temperature sensors.
+
+These chips also have fan controlling features, using either DC or PWM, in
+three different modes (one manual, two automatic).
+
+The driver assumes that no more than one chip is present, which seems
+reasonable.
+
+
+Monitoring
+----------
+
+The Voltage, Fan and Temperature Monitoring uses the standard sysfs
+interface as documented in sysfs-interface, without any exceptions.
+
+
+Fan Control
+-----------
+
+Both PWM (pulse-width modulation) and DC fan speed control methods are
+supported. The right one to use depends on external circuitry on the
+motherboard, so the driver assumes that the BIOS set the method
+properly.
+
+There are 2 modes to specify the speed of the fan, PWM duty cycle (or DC
+voltage) mode, where 0-100% duty cycle (0-100% of 12V) is specified. And RPM
+mode where the actual RPM of the fan (as measured) is controlled and the speed
+gets specified as 0-100% of the fan#_full_speed file.
+
+Since both modes work in a 0-100% (mapped to 0-255) scale, there isn't a
+whole lot of a difference when modifying fan control settings. The only
+important difference is that in RPM mode the 0-100% controls the fan speed
+between 0-100% of fan#_full_speed. It is assumed that if the BIOS programs
+RPM mode, it will also set fan#_full_speed properly, if it does not then
+fan control will not work properly, unless you set a sane fan#_full_speed
+value yourself.
+
+Switching between these modes requires re-initializing a whole bunch of
+registers, so the mode which the BIOS has set is kept. The mode is
+printed when loading the driver.
+
+Three different fan control modes are supported; the mode number is written
+to the pwm#_enable file. Note that not all modes are supported on all
+chips, and some modes may only be available in RPM / PWM mode on the F8000.
+Writing an unsupported mode will result in an invalid parameter error.
+
+* 1: Manual mode
+  You ask for a specific PWM duty cycle / DC voltage or a specific % of
+  fan#_full_speed by writing to the pwm# file. This mode is only
+  available on the F8000 if the fan channel is in RPM mode.
+
+* 2: Normal auto mode
+  You can define a number of temperature/fan speed trip points, which % the
+  fan should run at at this temp and which temp a fan should follow using the
+  standard sysfs interface. The number and type of trip points is chip
+  depended, see which files are available in sysfs.
+  Fan/PWM channel 3 of the F8000 is always in this mode!
+
+* 3: Thermostat mode (Only available on the F8000 when in duty cycle mode)
+  The fan speed is regulated to keep the temp the fan is mapped to between
+  temp#_auto_point2_temp and temp#_auto_point3_temp.
+
+Both of the automatic modes require that pwm1 corresponds to fan1, pwm2 to
+fan2 and pwm3 to fan3.
diff -up vanilla-2.6.28-rc8/drivers/hwmon/Kconfig.foo vanilla-2.6.28-rc8/drivers/hwmon/Kconfig
--- vanilla-2.6.28-rc8/drivers/hwmon/Kconfig.foo	2008-12-15 14:26:14.000000000 +0100
+++ vanilla-2.6.28-rc8/drivers/hwmon/Kconfig	2008-12-15 14:27:32.000000000 +0100
@@ -284,11 +284,12 @@ config SENSORS_F71805F
 	  will be called f71805f.
 
 config SENSORS_F71882FG
-	tristate "Fintek F71882FG and F71883FG"
+	tristate "Fintek F71862FG, F71882FG and F8000"
 	depends on EXPERIMENTAL
 	help
 	  If you say yes here you get support for hardware monitoring
-	  features of the Fintek F71882FG and F71883FG Super-I/O chips.
+	  features of the Fintek F71882FG/F71883FG, F71862FG/71863FG
+	  and F8000 Super-I/O chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called f71882fg.

--------------030702070408040705010002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030702070408040705010002--

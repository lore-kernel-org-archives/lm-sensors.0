From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 26 Sep 2006 20:18:20 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <45198B0C.4030606@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <450312F6.4030500@gmail.com>
In-Reply-To: <450312F6.4030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
>> Looking again, I see a point of confusion at least, and a possible problem.
>> It may be one of interpretation, but is worth checking, and possibly 
>> documenting.
>>
>> The *not-yet-read* property pertains to the scan done by update_device(),
>> since thats what reads all sensors the driver supports.
>> But its easy to misconstrue not-yet-read as a property on the individual 
>> alarms.
>>
>> More importantly, any single read of any property will clear unrelated 
>> alarms.
>>     
>
> You are 100% correct. Things are as you describe, by driver design.
>
>   
>> So, with the usual caveats (Ive done something wrong, immature code, etc)
>> I see a few possibilities:
>>
>> 1 - Document the fact - tell users not to do that.
>>     this isnt unreasonable, and far simpler..
>>     
>
> The user can't do anything. The ones we need to tell are the
> application authors. The end user looks at the temperatures in his nice
> GUI, and doesn't decide what is read and when. At best he/she can
> select the global refresh rate, and that's about it.
>
>   


>> 2 - sensors-deamon locks the directory to preclude loss of alarms (is 
>> this possible ? bad idea ?)
>>     
>
> Which daemon?
>
>   
sensorsd - not that it matters.
>> 3 - dunno
>>     
>
> 4 - don't care:
>
> What's the point in spending efforts to make sure that the application
> will see the one-time alarm, while you have absolutely no way to know
> if the user will see it? Unless the application keeps the alarm on
> until the user clicks to confirm that he/she did see the alarm... This
> doesn't sound very friendly.
>
> All GUIs I know of do not present the alarm data at all, by the way.
> Could be because libsensors doesn't make their access very friendly at
> the moment... But it could also be because end users don't care - they
> can simply compare the measurement to the limits, or even judge the
> measurement by themselves. The alarm bits are redundant.
>
> Furthermore, I don't expect any application to actually do selective
> reads. I expect them to read all the values at once, and our drivers
> will work just fine in that case. Do you know of any exiting
> application that does otherwise?
>
>   
no, but sensors is all Ive ever needed.

> In the real world, one-time alarms don't matter. I don't get why chip
> designers almost all did implement alarms that way. Their main use
> right now is for us to write and debug drivers.
>
> So, as much as I agree that there is a flaw in our design, I'd say
> fixing it isn't worth the effort.
>
>   
Works for me :-)

But Ive added a couple lines to Doc/hwmon/sysfs-interface, on the 
assumption that
app-writers will read it, where they now learn of libsensors, but might 
miss this fact otherwise.


Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>

$ diffstat diff.doc-touches.20060926.140844
 Documentation/hwmon/sysfs-interface |    8 ++++----


diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.18-rc6-mm2-sk/Documentation/hwmon/sysfs-interface doc-touches/Documentation/hwmon/sysfs-interface
--- linux-2.6.18-rc6-mm2-sk/Documentation/hwmon/sysfs-interface	2006-09-07 16:09:40.000000000 -0600
+++ doc-touches/Documentation/hwmon/sysfs-interface	2006-09-26 14:04:19.000000000 -0600
@@ -23,6 +23,7 @@ voltages between 0 and +4V. Other voltag
 range using external resistors. Since the values of these resistors
 can change from motherboard to motherboard, the conversions cannot be
 hard coded into the driver and have to be done in user space.
+Therefore, all sysfs values are fixed point numbers.
 
 For this reason, even if we aim at a chip-independent libsensors, it will
 still require a configuration file (e.g. /etc/sensors.conf) for proper
@@ -35,8 +36,9 @@ access this data in a simple and consist
 will have to implement conversion, labeling and hiding of inputs. For
 this reason, it is still not recommended to bypass the library.
 
-If you are developing a userspace application please send us feedback on
-this standard.
+If you are developing a userspace application please send us feedback
+on this standard.  Note that applications are expected to read all the
+sysfs files at once, you may miss transient alarms otherwise.
 
 Note that this standard isn't completely established yet, so it is subject
 to changes. If you are writing a new hardware monitoring driver those
@@ -48,8 +50,6 @@ Each chip gets its own directory in the 
 find all sensor chips, it is easier to follow the device symlinks from
 /sys/class/hwmon/hwmon*.
 
-All sysfs values are fixed point numbers.
-
 There is only one value per file, unlike the older /proc specification.
 The common scheme for files naming is: <type><number>_<item>. Usual
 types for sensor chips are "in" (voltage), "temp" (temperature) and




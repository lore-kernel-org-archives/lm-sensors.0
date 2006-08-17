From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 17 Aug 2006 19:35:30 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <44E4C502.1080005@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jean Delvare wrote:
> Hi Jim,
>
>   
hi !

BTW - are you considering these as 18 bugfix material, or are they
"long standing sub-optimalities" for 19 when it opens ?  (ie when 18 is out)

Obviously (from the experimentalism in my patches), Ive been treating it 
as 19 stuff ;-)
Apologies for making this more *in-need-of-feedback* than it has to be,
but I guess I cant quite resist..

>
> Now I agree that, even then, we probably will never see two 
of the same kind of  (not that the distinction matters here..)
> Super-I/O
> chip on the same board, so that's not really an issue.
>
>   

Um.. I just looked at asb100.c, and Im seeing static decls like:
        static DEVICE_ATTR(..)

Unless Im misunderstanding something, this is sufficient to preclude 
supporting a 2nd device.
IOW, to support multiple devices, drivers would need to create 
attributes, groups, etc out of
kalloc'd memory, sacrificing the (heavy) use of static initialization in 
hwmon/*.c

[jimc at harpo hwmon-stuff]$ grep -rn ATTR grp2/drivers/hwmon/* |wc
   1097    6301  102150


>> 2.  Previous patch built groups at runtime - thats now gone.
>>
>> This patch version declares a separate sub-group for each sensor-type,
>> which allows the same runtime-choices, but now creating attr-groups,
>> instead of looping thru and creating single attrs.
>> As I see it, this copies Marks approach closely.
>>
>> patch includes a code-move to bring 3 volts-related attrs and callbacks up
>> with the code for VIN, so theyre in-scope for the vin-attr-grp declaration.
>>
>> Its had cursory testing, will test over next few days.
>>     
>
> Yeah, I like this one much better, however it does change the code,
> which isn't OK. Not all chips have 3 fans, and not all chips have 3
> temperature sensors. 
Oops yes.
  
I noted the fixed-length loop in these:
        if (data->innr) {
                for (i = 0; i < 11; i++) {
        if (data->innr = 14) {
                for (i = 0; i < 3; i++) {

but overlooked the variant length in these:

        if (data->tempnr) {
                for (i = 0; i < data->tempnr; i++) {..}
        for (i = 0; i < data->fannr; i++) {..}

> The original code did only create the files for
> existing inputs, and I'd like the new code to do the same. It shouldn't
> be too difficult, see how Mark did for the w83627hf driver, it looks
> nice enough to me. For these entries you'll have to keep registering
> them manually, even though you can delete them as a group.
>
>   

Yeah, I guess so.   The only alternative is  *un-conservative*

1 - teach sysfs_create_group(or callees) to selectively create files for 
its members, based upon:
          mode - no read permissions
          or show-handler set to NULL (currently checked, near EACCESS iirc)
      cc'd gregkh for quick execution-with-prejudice, if guilty :-O

2. prior to calling sysfs_create_group() for a group of optional 'files'
    must disable the un-needed files, by zeroing attr->mode.
    fwiw - the disable is slightly weird, but is due to 
initialize-as-enabled design

SO - One more experimental patch - following outline above.
Patch is incremental upon the last one (for easy review ;)
and for its good isolation of the possibly controversial usage of the 
mode field.

Just to reiterate:

I'm resetting attr.mode = 0 for some members, and altering 
sysfs_create_group() to
not create files for disabled/reset members.  It gives us an easy way to
tailor runtime group population while preserving compile-time group 
composition.

This is not in conflict with any static uses Im aware of (FWIW),
the patch only affects groups, not individual device_create_file() uses.
I havent tried repeatedly creating and removing groups, but
I dont see that having any chance of exposing other bugs.
(caveats apply ;-)

> You can probably avoid moving the code around by adding the arrays of
> pointers at the end of the attribute declarations.
>
>   
I thought the move had its own merit, since the moved stuff pertains to 
the voltage 'group'
hence the code belongs together.  ATM, the 'connection' between them is 
evident only
at the end of the (previously mentioned) code-block doing 
device_create_file()s:
       if (data->innr) {... }

IOW, moving it improves existing code organization, ie fit to this model:
for 4 sensor types, code has:
- callbacks,
- static-decls of ATTRs, with initializations referencing those callbacks.
- (now) a group of those ATTRs, tucked in with related code.

(acceptable as separate pre-patch ? ;)



> Thanks,
>   

thanks Jean,
-jimc



diff -ruNp -X dontdiff -X exclude-diffs sys-grp/drivers/hwmon/pc87360.c grp2/drivers/hwmon/pc87360.c
--- sys-grp/drivers/hwmon/pc87360.c	2006-08-16 07:53:00.000000000 -0600
+++ grp2/drivers/hwmon/pc87360.c	2006-08-17 11:54:59.000000000 -0600
@@ -1020,7 +1020,32 @@ static int pc87360_detect(struct i2c_ada
 		pc87360_init_client(client, use_thermistors);
 	}
 
-	/* Register sysfs groups */
+	/* disable group members which arent supported by the
+	   available hardware.  For efficiency, we handle all-or-none
+	   groups separately below, and more variant groups here
+	 */
+
+#	define disable_attr(X) 	(X).dev_attr.attr.mode = 0
+
+	for (i = 0; i < ARRAY_SIZE(fan_input); i++) {
+		if (!FAN_CONFIG_MONITOR(data->fan_conf, i)) {
+			disable_attr(fan_input[i]);
+			disable_attr(fan_min[i]);
+			disable_attr(fan_div[i]);
+			disable_attr(fan_status[i]);
+		}
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
+			disable_attr(pwm[i]);
+	}
+	for (i = data->tempnr; i && i < ARRAY_SIZE(temp_input); i++) {
+		disable_attr(temp_input[i]);
+		disable_attr(temp_min[i]);
+		disable_attr(temp_max[i]);
+		disable_attr(temp_crit[i]);
+		disable_attr(temp_status[i]);
+	}
+
+	/* Register sysfs groups for available hardware */
 
 	if (data->innr && 
 	    sysfs_create_group(&client->dev.kobj,
diff -ruNp -X dontdiff -X exclude-diffs sys-grp/fs/sysfs/group.c grp2/fs/sysfs/group.c
--- sys-grp/fs/sysfs/group.c	2006-06-17 19:49:35.000000000 -0600
+++ grp2/fs/sysfs/group.c	2006-08-17 11:14:57.000000000 -0600
@@ -32,7 +32,8 @@ static int create_files(struct dentry * 
 	int error = 0;
 
 	for (attr = grp->attrs; *attr && !error; attr++) {
-		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
+		if ((*attr)->mode)
+			error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
 	}
 	if (error)
 		remove_files(dir,grp);




From: Tony Griffiths <tonyg@promptu.com>
Date: Mon, 13 Aug 2007 01:29:45 +0000
Subject: Re: [lm-sensors] Incorrect magnitude (=3,
Message-Id: <46BFB409.1060207@promptu.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020609080200090403070006"
List-Id: <lm-sensors.vger.kernel.org>
References: <46B6797A.1080402@promptu.com>
In-Reply-To: <46B6797A.1080402@promptu.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020609080200090403070006
Content-Type: multipart/alternative;
	boundary="------------060306050502010705070602"


--------------060306050502010705070602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean,

Taking on board your comments and looking more closely at the output of 
the sensors command I can see that the values returned to userland from 
the kernel should indeed be x1000 (magnitude 3) and not x100 (mag 2)!

>
> Your fix is probably incomplete: I guess that the high limits should be
> ~80 and ~70 degrees C, and the hyst limits (which appear to really be
> low limits, not hysteresis) presumably -128 degrees C. So the limits
> magnitudes are wrong too.
>
>   
>> [root@noakes lm_sensors-2.10.3]# ipmitool -I open sdr elist
>> Temp             | 01h | ok  |  3.2 | 38 degrees C
>> Temp             | 02h | ok  |  3.3 | 42 degrees C
>> Planar Temp      | 04h | ok  |  7.1 | 32 degrees C
>> VRD 0 Temp       | 05h | ok  |  7.1 | 26 degrees C
>> VRD 1 Temp       | 06h | ok  |  7.1 | 27 degrees C
>> CMOS Battery     | 10h | ok  |  7.1 | 3.08 Volts
>> VCORE            | 11h | ok  |  3.2 | State Deasserted
>> VCORE            | 12h | ok  |  3.3 | State Deasserted
>> PROC VTT         | 13h | ok  |  7.1 | State Deasserted
>> 1.5V PG          | 14h | ok  |  7.1 | State Deasserted
>> 1.8V PG          | 15h | ok  |  7.1 | State Deasserted
>> Presence         | 20h | ok  |  3.2 | Present
>> Presence         | 21h | ok  |  3.3 | Present
>> Fan 1            | 30h | ok  |  7.1 | 3525 RPM
>> Fan 2A           | 31h | ok  |  7.1 | 7650 RPM
>> Fan 2B           | 32h | ok  |  7.1 | 5400 RPM
>> Fan 3A           | 33h | ok  |  7.1 | 7725 RPM
>> Fan 3B           | 34h | ok  |  7.1 | 5550 RPM
>> Fan 4A           | 35h | ok  |  7.1 | 7425 RPM
>> Fan 4B           | 36h | ok  |  7.1 | 5475 RPM
>> Fan 5A           | 37h | ok  |  7.1 | 7500 RPM
>> Fan 5B           | 38h | ok  |  7.1 | 5475 RPM
>> Status           | 40h | ok  |  3.2 | Presence detected
>> Status           | 41h | ok  |  3.3 | Presence detected
>> VRM              | 44h | ok  |  3.2 | Presence detected
>> VRM              | 45h | ok  |  3.3 | Presence detected
>> OS Watchdog      | 50h | ok  |  7.1 |
>> SEL              | 51h | ns  |  7.1 | Disabled
>> Intrusion        | 52h | ok  |  7.1 |
>> Fan Redundancy   | 54h | ok  |  7.1 | Fully Redundant
>> ECC Corr Err     | 01h | ok  | 34.6 | Presence Detected, Configuration Error
>> ECC Uncorr Err   | 02h | ok  | 34.6 | Presence Detected, Configuration Error
>> I/O Channel Chk  | 03h | ns  | 34.6 | Disabled
>> PCI Parity Err   | 04h | ok  | 34.6 | EISA failsafe timeout, Bus 
>> Correctable error
>> PCI System Err   | 05h | ok  | 34.6 | EISA failsafe timeout, Bus 
>> Correctable error
>> SBE Log Disabled | 06h | ok  | 34.6 |
>> Logging Disabled | 07h | ns  | 34.6 | Disabled
>> Unknown          | 08h | ns  | 34.6 | Disabled
>> PROC Protocol    | 0Ah | ns  | 34.6 | Disabled
>> PROC Bus PERR    | 0Bh | ns  | 34.6 | Disabled
>> PROC Init Err    | 0Ch | ns  | 34.6 | Disabled
>> PROC Machine Chk | 0Dh | ns  | 34.6 | Disabled
>> Memory Spared    | 11h | ok  | 34.6 | Fully Redundant
>> Memory Mirrored  | 12h | ok  | 34.6 | Fully Redundant
>> Memory RAID      | 13h | ok  | 34.6 | Fully Redundant
>> Memory Added     | 14h | ok  | 34.6 | Correctable ECC
>> Memory Removed   | 15h | ok  | 34.6 | Correctable ECC
>> PCIE Fatal Err   | 18h | ns  | 34.6 | Disabled
>> Chipset Err      | 19h | ns  | 34.6 | Disabled
>> Err Reg Pointer  | 1Ah | ns  | 34.6 | No Reading
>>
>> The attached patch files fix this problem for the FC7 version of 
>> lm_sensors 2.10.3 !
>>     
>
>   
>> --- ./lib/chips.c.orig	2007-08-06 10:25:49.000000000 +1000
>> +++ ./lib/chips.c	2007-08-06 10:25:01.000000000 +1000
>> @@ -5551,7 +5551,7 @@ static sensors_chip_feature bmc_features
>>                                  SENSORS_BMC_FAN1+9, RW }, 
>>                                  BMC_SYSCTL_FAN1+9, VALUE(1), 0 },
>>      { { SENSORS_BMC_TEMP1, "temp1", NOMAP, NOMAP, R }, 
>> -                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input", 3 },
>> +                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input", 2 },
>>      { { SENSORS_BMC_TEMP1_MIN, "temp1_min", SENSORS_BMC_TEMP1, SENSORS_BMC_TEMP1, 
>>                                 RW }, 
>>                                 BMC_SYSCTL_TEMP1, VALUE(2), 2 },
>>     
>
> Not correct, sorry. The temperature magnitude is standardized to 3 for
> all drivers in Linux 2.6 (see Documentation/hwmon/sysfs-interface). If
> you had to change it to 2 here, it means that the bmcsensors driver
> itself does not respect the standard. The bmcsensors driver needs to be
> fixed, not libsensors.
>   
I'm using ipmisensors, not the older (and ?obsolete?) bmcsensors but the 
same comment applies in either case.

> Or rather, libsensors needs to be fixed for all the other temperature
> channels, to use the standard magnitude of 3 instead of 2.
>
> Yani, looking at the patch which introduced this bug:
> http://www.lm-sensors.org/changeset/2888
> I have too comments:
>
> * in2 and in3 both map to in2_input, and after that all the voltage
> channels are shifted by one. I assume this is a bug? Or were you trying
> to compensate for voltages channels starting at 0 instead of 1?
>   
This shifting bug is caused by the asynchronous nature of the IPMI 
message passing i/f.  The ipmidriver as originally coded simply fired 
off multiple GET requests without waiting for a reply.  It saved the 
pointer to the last SDR object for which a request was issued in the bmc 
object, overwriting any previous value.  In my case, the 2nd GET was 
issued before the response to the 1st GET arrived back resulting in an 
incorrect value being set for the 2nd sensor and everything being 
shifted by one.  Only the last sensor was correct.  I've developed a 
patch to fix this behaviour.

I've also adjusted the SDR list creation to do a list_add_tail() rather 
than list_add().  This ensures that the SDR list is in ascending order 
of SDR number!

The "disconnect" between the kernel driver exporting the sensors data 
via /sys/... and the usermode code needs to be eliminated.  The 'spec' 
does indeed state that TEMP and VOLT values are in milli<xxx> units so 
the change to ipmisensors in decplaces() that returns 2 for TEMP 
readings is incorrect and needs to be reverted to it's previous value of 3.

I've attached a (partial) patch which shows the changes I made to fix 
the usage of the current_sdr pointer.  It also reverts the change in 
decplaces() that returned 2 for TEMP sensors instead of 3.

Of course along with these changes, lib/chips.c needs to be changed to 
make ALL of the bmc/ipmi temp sensor values magnitude 3.

> * Everything in this patch (except the bugs) only duplicates the
> default mappings libsensors uses to convert Linux 2.4 symbols into
> Linux 2.6 sysfs file names. So I believe that the patch was simply not
> needed. As a matter of fact, the min and max limit symbols were left
> untouched, and work fine. Can you please comment on this? I plan to
> revert this changeset.
>
>   


--------------060306050502010705070602
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Jean,<br>
<br>
Taking on board your comments and looking more closely at the output of
the sensors command I can see that the values returned to userland from
the kernel should indeed be x1000 (magnitude 3) and not x100 (mag 2)!<br>
<br>
<blockquote cite="mid:20070812230020.02e3cd35@hyperion.delvare"
 type="cite">
  <pre wrap=""><!---->
Your fix is probably incomplete: I guess that the high limits should be
~80 and ~70 degrees C, and the hyst limits (which appear to really be
low limits, not hysteresis) presumably -128 degrees C. So the limits
magnitudes are wrong too.

  </pre>
  <blockquote type="cite">
    <pre wrap="">[root@noakes lm_sensors-2.10.3]# ipmitool -I open sdr elist
Temp             | 01h | ok  |  3.2 | 38 degrees C
Temp             | 02h | ok  |  3.3 | 42 degrees C
Planar Temp      | 04h | ok  |  7.1 | 32 degrees C
VRD 0 Temp       | 05h | ok  |  7.1 | 26 degrees C
VRD 1 Temp       | 06h | ok  |  7.1 | 27 degrees C
CMOS Battery     | 10h | ok  |  7.1 | 3.08 Volts
VCORE            | 11h | ok  |  3.2 | State Deasserted
VCORE            | 12h | ok  |  3.3 | State Deasserted
PROC VTT         | 13h | ok  |  7.1 | State Deasserted
1.5V PG          | 14h | ok  |  7.1 | State Deasserted
1.8V PG          | 15h | ok  |  7.1 | State Deasserted
Presence         | 20h | ok  |  3.2 | Present
Presence         | 21h | ok  |  3.3 | Present
Fan 1            | 30h | ok  |  7.1 | 3525 RPM
Fan 2A           | 31h | ok  |  7.1 | 7650 RPM
Fan 2B           | 32h | ok  |  7.1 | 5400 RPM
Fan 3A           | 33h | ok  |  7.1 | 7725 RPM
Fan 3B           | 34h | ok  |  7.1 | 5550 RPM
Fan 4A           | 35h | ok  |  7.1 | 7425 RPM
Fan 4B           | 36h | ok  |  7.1 | 5475 RPM
Fan 5A           | 37h | ok  |  7.1 | 7500 RPM
Fan 5B           | 38h | ok  |  7.1 | 5475 RPM
Status           | 40h | ok  |  3.2 | Presence detected
Status           | 41h | ok  |  3.3 | Presence detected
VRM              | 44h | ok  |  3.2 | Presence detected
VRM              | 45h | ok  |  3.3 | Presence detected
OS Watchdog      | 50h | ok  |  7.1 |
SEL              | 51h | ns  |  7.1 | Disabled
Intrusion        | 52h | ok  |  7.1 |
Fan Redundancy   | 54h | ok  |  7.1 | Fully Redundant
ECC Corr Err     | 01h | ok  | 34.6 | Presence Detected, Configuration Error
ECC Uncorr Err   | 02h | ok  | 34.6 | Presence Detected, Configuration Error
I/O Channel Chk  | 03h | ns  | 34.6 | Disabled
PCI Parity Err   | 04h | ok  | 34.6 | EISA failsafe timeout, Bus 
Correctable error
PCI System Err   | 05h | ok  | 34.6 | EISA failsafe timeout, Bus 
Correctable error
SBE Log Disabled | 06h | ok  | 34.6 |
Logging Disabled | 07h | ns  | 34.6 | Disabled
Unknown          | 08h | ns  | 34.6 | Disabled
PROC Protocol    | 0Ah | ns  | 34.6 | Disabled
PROC Bus PERR    | 0Bh | ns  | 34.6 | Disabled
PROC Init Err    | 0Ch | ns  | 34.6 | Disabled
PROC Machine Chk | 0Dh | ns  | 34.6 | Disabled
Memory Spared    | 11h | ok  | 34.6 | Fully Redundant
Memory Mirrored  | 12h | ok  | 34.6 | Fully Redundant
Memory RAID      | 13h | ok  | 34.6 | Fully Redundant
Memory Added     | 14h | ok  | 34.6 | Correctable ECC
Memory Removed   | 15h | ok  | 34.6 | Correctable ECC
PCIE Fatal Err   | 18h | ns  | 34.6 | Disabled
Chipset Err      | 19h | ns  | 34.6 | Disabled
Err Reg Pointer  | 1Ah | ns  | 34.6 | No Reading

The attached patch files fix this problem for the FC7 version of 
lm_sensors 2.10.3 !
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <blockquote type="cite">
    <pre wrap="">--- ./lib/chips.c.orig	2007-08-06 10:25:49.000000000 +1000
+++ ./lib/chips.c	2007-08-06 10:25:01.000000000 +1000
@@ -5551,7 +5551,7 @@ static sensors_chip_feature bmc_features
                                 SENSORS_BMC_FAN1+9, RW }, 
                                 BMC_SYSCTL_FAN1+9, VALUE(1), 0 },
     { { SENSORS_BMC_TEMP1, "temp1", NOMAP, NOMAP, R }, 
-                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input", 3 },
+                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input", 2 },
     { { SENSORS_BMC_TEMP1_MIN, "temp1_min", SENSORS_BMC_TEMP1, SENSORS_BMC_TEMP1, 
                                RW }, 
                                BMC_SYSCTL_TEMP1, VALUE(2), 2 },
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Not correct, sorry. The temperature magnitude is standardized to 3 for
all drivers in Linux 2.6 (see Documentation/hwmon/sysfs-interface). If
you had to change it to 2 here, it means that the bmcsensors driver
itself does not respect the standard. The bmcsensors driver needs to be
fixed, not libsensors.
  </pre>
</blockquote>
I'm using ipmisensors, not the older (and ?obsolete?) bmcsensors but
the same comment applies in either case.<br>
<br>
<blockquote cite="mid:20070812230020.02e3cd35@hyperion.delvare"
 type="cite">
  <pre wrap="">
Or rather, libsensors needs to be fixed for all the other temperature
channels, to use the standard magnitude of 3 instead of 2.

Yani, looking at the patch which introduced this bug:
<a class="moz-txt-link-freetext" href="http://www.lm-sensors.org/changeset/2888">http://www.lm-sensors.org/changeset/2888</a>
I have too comments:

* in2 and in3 both map to in2_input, and after that all the voltage
channels are shifted by one. I assume this is a bug? Or were you trying
to compensate for voltages channels starting at 0 instead of 1?
  </pre>
</blockquote>
This shifting bug is caused by the asynchronous nature of the IPMI
message passing i/f.&nbsp; The ipmidriver as originally coded simply fired
off multiple GET requests without waiting for a reply.&nbsp; It saved the
pointer to the last SDR object for which a request was issued in the
bmc object, overwriting any previous value.&nbsp; In my case, the 2nd GET
was issued before the response to the 1st GET arrived back resulting in
an incorrect value being set for the 2nd sensor and everything being
shifted by one.&nbsp; Only the last sensor was correct.&nbsp; I've developed a
patch to fix this behaviour.<br>
<br>
I've also adjusted the SDR list creation to do a list_add_tail() rather
than list_add().&nbsp; This ensures that the SDR list is in ascending order
of SDR number!<br>
<br>
The "disconnect" between the kernel driver exporting the sensors data
via /sys/... and the usermode code needs to be eliminated.&nbsp; The 'spec'
does indeed state that TEMP and VOLT values are in milli&lt;xxx&gt;
units so the change to ipmisensors in decplaces() that returns 2 for
TEMP readings is incorrect and needs to be reverted to it's previous
value of 3.<br>
<br>
I've attached a (partial) patch which shows the changes I made to fix
the usage of the current_sdr pointer.&nbsp; It also reverts the change in
decplaces() that returned 2 for TEMP sensors instead of 3. <br>
<br>
Of course along with these changes, lib/chips.c needs to be changed to
make ALL of the bmc/ipmi temp sensor values magnitude 3.<br>
<br>
<blockquote cite="mid:20070812230020.02e3cd35@hyperion.delvare"
 type="cite">
  <pre wrap="">
* Everything in this patch (except the bugs) only duplicates the
default mappings libsensors uses to convert Linux 2.4 symbols into
Linux 2.6 sysfs file names. So I believe that the patch was simply not
needed. As a matter of fact, the min and max limit symbols were left
untouched, and work fine. Can you please comment on this? I plan to
revert this changeset.

  </pre>
</blockquote>
<br>
</body>
</html>

--------------060306050502010705070602--

--------------020609080200090403070006
Content-Type: text/plain;
 name="ipmisensors-current_sdr-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmisensors-current_sdr-fix.patch"

--- ./drivers/hwmon/ipmisensors.c.orig	2007-07-03 15:41:58.000000000 +1000
+++ ./drivers/hwmon/ipmisensors.c	2007-08-13 11:09:43.000000000 +1000
@@ -120,10 +120,7 @@ static struct sdrdata *ipmisensors_new_s
 static inline void ipmisensors_add_sdr(struct ipmisensors_bmc_data *bmc,
 				       struct sdrdata *sdr)
 {
-	list_add(&sdr->list, &bmc->sdrs);
-	D_PRINTK(KERN_DEBUG
-	       "ipmisensors: SDR %d: type 0x%02x (%s)\n",
-	       bmc->sdr_count, sdr->stype, sdr->id)
+	list_add_tail(&sdr->list, &bmc->sdrs);
 	bmc->sdr_count++;
 }
 
@@ -156,28 +153,31 @@ static void ipmisensors_sdr_cleanup(stru
 /* worker function for workqueue ipmisensors_workqueue */
 static void ipmisensors_update_bmc(struct work_struct *work)
 {
-	struct ipmisensors_bmc_data *bmc = container_of(work,struct ipmisensors_bmc_data,update_work.work);
+	struct ipmisensors_bmc_data *bmc = container_of(work, struct ipmisensors_bmc_data, update_work.work);
+
+	I_PRINTK(KERN_INFO "ipmisensors: update_bmc start\n")
 
 	/* don't start an update cycle if one already in progress */
 	if (bmc->state != STATE_READING) {
 		struct sdrdata *cursor, *next;
 		bmc->state = STATE_READING;
-		D_PRINTK(KERN_DEBUG "ipmisensors: starting update\n")
+		I_PRINTK(KERN_INFO "ipmisensors: starting update\n")
 
 		/* init semaphore to 1 for update cycle */
 		sema_init(&bmc->update_semaphore, 1);
 
 		/* update each sdr reading */
+		bmc->current_sdr = NULL;
 		list_for_each_entry_safe(cursor, next, &bmc->sdrs, list) {
 			ipmisensors_get_reading(bmc, cursor);
 		}
-	}
+	} else
+		I_PRINTK(KERN_INFO "ipmisensors: update in progress\n")
 
 	/* wait for readings (need timeout?) */
 	down_interruptible(&bmc->update_semaphore);
 
-	D_PRINTK(KERN_DEBUG "ipmisensors: update complete\n")
-
+	I_PRINTK(KERN_INFO "ipmisensors: update complete\n")
 	bmc->state = STATE_DONE;
 
 	/* if the module isn't cleaning up, schedule another update */
@@ -306,8 +307,10 @@ static void ipmisensors_get_reading(stru
 	bmc->tx_message.data_len = 1;
 	bmc->tx_message.data = bmc->tx_msg_data;
 	bmc->tx_msg_data[0] = sdr->number;
-	bmc->current_sdr = sdr;
-
+	if (bmc->current_sdr == NULL) {
+		bmc->current_sdr = sdr;
+	}
+	I_PRINTK(KERN_INFO "SDR reading: #%d\n", sdr->number);
 	ipmisensors_send_message(bmc, bmc->msgid++, &bmc->tx_message);
 	down_interruptible(&bmc->update_semaphore);
 }
@@ -335,9 +338,11 @@ static void ipmisensors_rcv_reading_msg(
 	sdr->status = msg->data[2];
 	sdr->thresholds = msg->data[3];
 
-	D_PRINTK(KERN_DEBUG "ipmisensors: sensor %d (type %d) reading %d\n",
-	       sdr->number, sdr->stype, msg->data[1])
+	I_PRINTK(KERN_INFO "ipmisensors: sensor %d(%s) reading %d\n",
+	       sdr->number, sdr->id, sdr->reading)
 
+	/* Prepare to process next response message after this one! */
+	bmc->current_sdr = list_entry(sdr->list.next, struct sdrdata, list);
 	up(&bmc->update_semaphore);
 }
 

--------------020609080200090403070006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020609080200090403070006--

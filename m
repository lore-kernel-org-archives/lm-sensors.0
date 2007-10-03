From: Corey Minyard <minyard@acm.org>
Date: Wed, 03 Oct 2007 15:53:07 +0000
Subject: Re: [lm-sensors] [Openipmi-developer] IPMI and ipmisensors on an
Message-Id: <4703BAE3.706@acm.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000508050100050104000304"
List-Id: <lm-sensors.vger.kernel.org>
References: <4701E789.5020103@jordet.net>
In-Reply-To: <4701E789.5020103@jordet.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000508050100050104000304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Well, I lied, there was no 0.9 support in the driver, there was one 
thing that had to be handled a little differently.

However, Stian gave me access to the system, and I added support.  Patch 
is attached, I will work on getting it into the 2.6.24.

Thanks, Stian, for access to the system.  Patch is in your sources and 
currently running, but not installed in /lib/modules.

-corey

Stian Jordet wrote:
> On tir, 2007-10-02 at 14:51 -0500, Corey Minyard wrote:
>   
>> There is a big difference between the driver, which just passes messages 
>> around mostly, and the sensor handling, which requires interpretation of 
>> SDRs and things like that.  The driver should work with a 0.9 system, 
>> but the OpenIPMI library will not, for instance.
>>
>> I'd be willing to work on this (the driver part), but I'll need access 
>> to the system.
>>     
>
> That would be truly awesome!
>
> I'll send you the details in a private mail. I have a (small) hope that
> if ipmi_si loads, perhaps the ipmisensors module will read the sensors
> in human readable way...
>
> Anyway, I hope I'll find out :)
>
> Thanks again, everyone!
>
> -Stian
>   


--------------000508050100050104000304
Content-Type: text/x-patch;
 name="ipmi_0.9_support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_0.9_support.patch"

Add support for IPMI 0.9 systems to the IPMI driver.  Just handle
a shorter get device ID command with less information.

Signed-off-by: Corey Minyard <cminyard@mvista.com>

Index: linux-2.6.22/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.22.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.22/drivers/char/ipmi/ipmi_si_intf.c
@@ -2378,20 +2378,9 @@ static int try_get_dev_id(struct smi_inf
 	/* Otherwise, we got some data. */
 	resp_len = smi_info->handlers->get_result(smi_info->si_sm,
 						  resp, IPMI_MAX_MSG_LENGTH);
-	if (resp_len < 14) {
-		/* That's odd, it should be longer. */
-		rv = -EINVAL;
-		goto out;
-	}
-
-	if ((resp[1] != IPMI_GET_DEVICE_ID_CMD) || (resp[2] != 0)) {
-		/* That's odd, it shouldn't be able to fail. */
-		rv = -EINVAL;
-		goto out;
-	}
 
-	/* Record info from the get device id, in case we need it. */
-	ipmi_demangle_device_id(resp+3, resp_len-3, &smi_info->device_id);
+	/* Check and record info from the get device id, in case we need it. */
+	rv = ipmi_demangle_device_id(resp, resp_len, &smi_info->device_id);
 
  out:
 	kfree(resp);
Index: linux-2.6.22/include/linux/ipmi_smi.h
===================================================================
--- linux-2.6.22.orig/include/linux/ipmi_smi.h
+++ linux-2.6.22/include/linux/ipmi_smi.h
@@ -151,23 +151,43 @@ struct ipmi_device_id {
    byte from the get device id response after the completion code.
    The caller is responsible for making sure the length is at least
    11 and the command completed without error. */
-static inline void ipmi_demangle_device_id(const unsigned char *data,
-					   unsigned int  data_len,
-					   struct ipmi_device_id *id)
+static inline int ipmi_demangle_device_id(const unsigned char *data,
+					  unsigned int data_len,
+					  struct ipmi_device_id *id)
 {
+	if (data_len < 9)
+		return -EINVAL;
+	if (data[0] != IPMI_NETFN_APP_RESPONSE << 2 ||
+	    data[1] != IPMI_GET_DEVICE_ID_CMD)
+		/* Strange, didn't get the response we expected. */
+		return -EINVAL;
+	if (data[2] != 0)
+		/* That's odd, it shouldn't be able to fail. */
+		return -EINVAL;
+
+	data += 3;
+	data_len -= 3;
 	id->device_id = data[0];
 	id->device_revision = data[1];
 	id->firmware_revision_1 = data[2];
 	id->firmware_revision_2 = data[3];
 	id->ipmi_version = data[4];
 	id->additional_device_support = data[5];
-	id->manufacturer_id = data[6] | (data[7] << 8) | (data[8] << 16);
-	id->product_id = data[9] | (data[10] << 8);
+	if (data_len >= 6) {
+		id->manufacturer_id = (data[6] | (data[7] << 8) |
+				       (data[8] << 16));
+		id->product_id = data[9] | (data[10] << 8);
+	} else {
+		id->manufacturer_id = 0;
+		id->product_id = 0;
+	}
 	if (data_len >= 15) {
 		memcpy(id->aux_firmware_revision, data+11, 4);
 		id->aux_firmware_revision_set = 1;
 	} else
 		id->aux_firmware_revision_set = 0;
+
+	return 0;
 }
 
 /* Add a low-level interface to the IPMI driver.  Note that if the

--------------000508050100050104000304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000508050100050104000304--

From: =?ISO-8859-1?Q?Per_Dal=E9n?= <per.dalen@appeartv.com>
Date: Wed, 01 Jun 2011 06:44:19 +0000
Subject: Re: [lm-sensors] MAX6642 chip detection and other stuff
Message-Id: <4DE5DFC3.7030201@appeartv.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020601030805020202000209"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110528045113.GA8833@ericsson.com>
In-Reply-To: <20110528045113.GA8833@ericsson.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601030805020202000209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Guenter and Jean,

Sorry for the delay. Much stuff at work...
Here's (Jean's ;) patch.

BR
Per

On 05/28/2011 04:04 PM, Guenter Roeck wrote:
> Hi Jean,
> 
> On Sat, May 28, 2011 at 04:36:31AM -0400, Jean Delvare wrote:
>> Hi Guenter,
>>
>> On Fri, 27 May 2011 21:51:13 -0700, Guenter Roeck wrote:
>>> The attached patch (on top of Per's most recent patch) works quite nicely.
>>> Per, maybe you can just merge it with your patch and resubmit it.
>>
>> Looks good, pretty much what I had in mind. But I think you could make
>> the code even more compact:
>>
>> 	/* sanity check */
>> 	if (i2c_smbus_read_byte_data(client, 0x04) != 0x4D
>> 	 || i2c_smbus_read_byte_data(client, 0x06) != 0x4D
>> 	 || i2c_smbus_read_byte_data(client, 0xff) != 0x4D)
>> 		return -ENODEV;
>>
> Yes, you are right. I didn't do it to avoid a checkpatch warning, but forgot
> that I don't use a variable anymore.
> 
> Guenter


--------------020601030805020202000209
Content-Type: text/plain;
 name="0002-hwmon-max6642-Improve-chip-detection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-hwmon-max6642-Improve-chip-detection.patch"

Improve the detection of MAX6642 by reading non exciting registers (0x04, 0x06 and 0xff). The value of those registers should be the same as the last valid resister read.

Signed-off-by: Per Dalen <per.dalen@appeartv.com>
---
diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index 0f9fc40..4fb0564 100644
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -136,6 +136,12 @@ static int max6642_detect(struct i2c_client *client,
 	if (man_id != 0x4D)
 		return -ENODEV;
 
+	/* sanity check */
+	if (i2c_smbus_read_byte_data(client, 0x04) != 0x4D
+	    || i2c_smbus_read_byte_data(client, 0x06) != 0x4D
+	    || i2c_smbus_read_byte_data(client, 0xff) != 0x4D)
+		return -ENODEV;
+
 	/*
 	 * We read the config and status register, the 4 lower bits in the
 	 * config register should be zero and bit 5, 3, 1 and 0 should be

--------------020601030805020202000209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020601030805020202000209--

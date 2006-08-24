From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 24 Aug 2006 11:26:22 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-timeout-fixes.patch
Message-Id: <44ED8CDE.3060300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44DB23B1.1060102@hhs.nl>
In-Reply-To: <44DB23B1.1060102@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
>> Since this patch fixes the CMOS settings corruption* reported to the
>> list earlier by Sunil Kumar, it should be send upstream ASAP (to GKH who
>> is replacing Linus while Linus is away for a couple of weeks).
> 
> The problem is that your patch doesn't apply to my tree. What is it
> supposed to apply to?
> 

To the latest version of abituguru.c which I send to you (in the form of 
my original submission + all accepted patches). But someone upstream has 
been fixing some spelling mistakes in the comments, which caused the 
patch to not apply to upstream's tree, I've attached a new version 
against upstreams latest tree (2.6.18-rc4-git1).

>> @@ -226,6 +227,10 @@
>>  		timeout--;
>>  		if (timeout = 0)
>>  			return -EBUSY;
>> +		/* sleep a bit before our last few tries, see the comment on
>> +		   this where ABIT_UGURU_WAIT_TIMEOUT_SLEEP is defined. */
>> +		if (timeout <= ABIT_UGURU_WAIT_TIMEOUT_SLEEP)
>> +			msleep(0);
>>  	}
>>  	return 0;
>>  }
> 
> I couldn't find any other use of msleep(0) in the whole kernel tree.
> While I see your point and agree it should work, someone may complain
> that it depends too much on the value of HZ.
> 

msleep(1) will be equally dependent on the value of HZ, with HZ 1000 it 
will sleep 2 ms instead of the expected 1, which is why I use msleep(0), 
with HZ 100 it will sleep 10 ms.

>> @@ -331,7 +338,8 @@
>>  	/* And read the data */
>>  	for (i = 0; i < count; i++) {
>>  		if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
>> -			ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for "
>> +			ABIT_UGURU_DEBUG(retries? 1:3,
> 
> Broken coding style.
> 

How exactly, I guess I should have used spaces somewhere, but where exactly?

>> +				"timeout exceeded waiting for "
>>  				"read state (bank: %d, sensor: %d)\n",
>>  				(int)bank_addr, (int)sensor_addr);
>>  			break;
> 
>> @@ -403,7 +418,7 @@
>>  				   u8 sensor_addr)
>>  {
>>  	u8 val, buf[3];
>> -	int ret = ABIT_UGURU_NC;
>> +	int i, ret = -ENODEV; /* error is the most commen used retval :| */
> 
> Typo: common. Nothing to be worried about, BTW, it's common, although
> suboptimal, to initialize the returned variable to an error value in
> probe functions.
> 

Ok, so I guess the comment may be removed then (but does no harm), I've 
fixed the spelling and left the comment.

>>  		if (buf[0] & ABIT_UGURU_TEMP_HIGH_ALARM_FLAG) {
>> -			ret = ABIT_UGURU_TEMP_SENSOR;
>>  			ABIT_UGURU_DEBUG(2, "  found temp sensor\n");
>> +			ret = ABIT_UGURU_TEMP_SENSOR;
> 
> I see no benefit in swapping these lines.
> 

It makes the exit paths of the temp sensor probe exactly match that of 
the volt sensor probe, making clearer that they the probe method / code 
is identical (except for what is probed).

>> @@ -1303,7 +1328,7 @@
>>  		data->update_timeouts = 0;
>>  LEAVE_UPDATE:
>>  		/* handle timeout condition */
>> -		if (err = -EBUSY) {
>> +		if (!success && (err = -EBUSY || err >= 0)) {
>>  			/* No overflow please */
>>  			if (data->update_timeouts < 255u)
>>  				data->update_timeouts++;
>>
> 
> Can you explain the "err >= 0" part? I don't get it.
> 

I'll first explain the success flag ...

> Also, unrelated to this patch, I wonder why you need a separate
> "success" flag, can't you use !err or err < 0 instead?
> 

No err contains the last value return value of abit_uguru_read, which 
returns < 0 on error or the number of bytes read. Since this code is 
jumped to on short reads (iow less read then asked for) as well as 
errors, the only way to know that everything is ok is to use a success 
flag. I could check that err matches the number of bytes requested by 
the last read done, but err could have that value too because a previous 
read was a short read, in which case the code wouldn't catch the error, 
hence a success flag is needed.

Know to answer your original question:
 > Can you explain the "err >= 0" part? I don't get it.
 >
One of the changes of this path is to not report an error to userspace 
in case of a short read (because those can be caused by timeout errors 
too), but instead just retry the next update, the >= 0 checks for shorts 
reads and treat those like timeout errors (which are catched by the 
-EBUSY test).

I hope this explains.

> Please provide a new patch, that will apply properly to 2.6.18-rc4,
> rc4-git1 or rc4-mm2.
> 

Attached.

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-abituguru-timeout-fixes.patch
Type: text/x-patch
Size: 10274 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060824/65ead001/attachment.bin 

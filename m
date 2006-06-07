From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 07 Jun 2006 21:00:01 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <44873E51.5050404@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

>> +static ssize_t
>> +store_pwm_enable(struct device *dev, struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>>   
>> +	if (data->pwm_enable[nr] != val) {
>>   
> I guess *here* is where you mean non-trivial.
> 
> why not take the lock here -> instead of in both branches of if ?
> 
>> +		if (!val) {
>>   
> you specifically and knowingly dont protect this call,
> and advised us of it in your msg.  It certainly warrants a comment here too.

The call protect itself because it locks on its own. If the lock would be 
before, it tries to lock 2 times and will deadlock.

> 
>> +			store_pwm(dev, attr, "255", 3);
>>   
> and now take the lock.
>> +			mutex_lock(&data->update_lock);
>> +			data->pwm_enable[nr] = val;
>> +		}
>> +		else {
>>   
> repeating, this lock could be hoisted, but for the missing/unstated reason.

I know this code is not perfect, but how can it be done without more locking or 
more confusing temporary variables?

Thanks,

regards
Rudolf


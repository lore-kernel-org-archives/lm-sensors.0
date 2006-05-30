From: ymu@Winbond.com.tw (Yuan Mu)
Date: Tue, 30 May 2006 07:34:15 +0000
Subject: [lm-sensors] [PATCH] Fix the set pwm value will change fan mode
Message-Id: <447BF577.3020001@winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <444610F0.1070809@winbond.com.tw>
In-Reply-To: <444610F0.1070809@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

[snipped]
>> +		data->pwm[nr] = (data->pwm[nr] & 0x7f) | 0x80;
> 
> Equivalent to:
> 		data->pwm[nr] |= 0x80;
> 
Oh, thank you , i will beat my head :(
>> +	} else {
>> +		return -EINVAL;
> 
> You return with the update lock held! It's easier to test the input
> value for validity before taking the lock, this avoids that kind of
> trap and is also more efficient.
> 

Beat my head once more ;)

And do we need to add lock in other store functions in w83792d ?


Best Regards
Yuan Mu







=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ymu.vcf
Type: text/x-vcard
Size: 56 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060530/a715b008/ymu-0001.vcf

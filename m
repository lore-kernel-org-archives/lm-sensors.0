From: Peter.Milne@d-tacq.com (Peter Milne)
Date: Sun, 18 Jun 2006 15:54:42 +0000
Subject: [lm-sensors] PATCH- i2c-iop3xx platform driver avoid addressing
Message-Id: <44957742.80309@d-tacq.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44931779.6050302@d-tacq.com>
In-Reply-To: <44931779.6050302@d-tacq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

Thanks very much for reviewing this patch, you have given me some useful 
insights.
Please consider the revised patch which addresses the issues you raise.

Jean Delvare wrote:

>Hi Peter,
>  
>
>>Avoid addressing self when sending a Master address. Follows instruction 
>>in Intel 80331/80321 manuals.
>>Ignoring this worked previously on 80321, but causes a hang on i2cdetect 
>>on 80331
>>    
>>
>
>Can't you simply disable the slave address? You don't seem to use it
>anyway.
>  
>
Unfortunately there doesn't seem to be any way to disable the slave address.

>BTW, you must be using an old version of i2cdetect, as the slave address
>appears to be forced to 0x02 in the i2c-iop3xx driver (not a smart
>choice...) and i2cdetect does no more scan this address by default.
>  
>
OK, new patch leaves the slave address at default 0.
I note that i2cdetect now scans from 0x3, but I'd still prefer to 
prevent writes to the device's own address since this wedges the unit.


>>+#define I2C_ERR_WRITEMYSAR      (I2C_ERR+10)
>>    
>>
>
>Please use tabs, not spaces, for alignment.
>  
>
After forcing emacs to cooperate, tabs it is.

Thanks


Peter.

-- 
Peter Milne			Peter.Milne at d-tacq.com
D-TACQ Solutions Ltd		www.d-tacq.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-iop3xx.2.patch
Type: text/x-patch
Size: 2430 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060618/4d1092ad/attachment.bin 

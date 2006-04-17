From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 17 Apr 2006 16:04:06 +0000
Subject: [lm-sensors] vt1211 driver (was hwmon/pc87360 as a platform
Message-Id: <4443BC76.3060905@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
>> The SHOW_SET_*_*  constants are just a bit off-putting at first read,
>> but I know what you mean, and I dont have a better idea.
>> maybe SHOW_SETTNG_*_* ?
>> or SHOW_CURR_*_*,   thats confuse-able with the current reading
>>     
>
> Well SHOW_SET_xxx_yyy is supposed to hint that the constant is used in
> both the show_xxx and set_xxx callbacks. It's the best I could come up
> with although I have to admit I didn't spend too much time thinking
> about this....
>
>   
>> you can improve your printks :
>>
>> s/(printk\(KERN_DEBUG)/dev_dbg\(&pdev->dev/;
>> s/(printk\(KERN_ERR)/dev_err\(&pdev->dev/
>> s/(printk\(KERN_INFO)/dev_info\(&pdev->dev/
>>
>> at least where pdev has already been initd
>>     
>
> Hmm... I thought I used printks only in places where pdev is not initialized.
>
>   
I didnt look that carefully.
>> Ill try to read thru the enire patch this weekend sometime.
>>     
>
> I certainly appreciate the review :-)
>
>   
good thing that *this* is so flexible ;-)

> ...juerg
>
>   

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-vt1211-driver-review
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060417/2985cd2c/hwmon-vt1211-driver-review.pl

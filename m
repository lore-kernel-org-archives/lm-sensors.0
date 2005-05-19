From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <41FC27DF.9030301@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll try and answer your other questions below.

Huang0@Winbond.com.tw wrote:
> Dear Jean:
> 
> 
> 
>>>>- Why is the vol_factor array exposed to /proc? Isn't this only
> 
> for
> 
>>>>  debugging?
>>>>  These shouldn't be exposed to the user. If the user needs to
>>>>  adjust computation it can be done in /etc/sensors.conf.
>>>
>>>In the requirements of our customer: the motherboard vendor should
>>>have the permission to modify the voltage factor, so I expose it
> 
> into
> 
>>>/proc. I write it with the reference of our Windows version, the
>>>Windows version GUI supply a interface to modify the voltage factor,
>>>but it need authentication, That's to say, NOT all of the user can
>>>modify it.
>>
>>As I understand it, these factors account for the resistors placed on
>>the motherboard, which are needed to bring all voltages back into the
>>measurable 0V-4V range. Am I correct?
> 
> 
> I do NOT know the exact function of factors, maybe you are right, it is
> used to bring into some voltage range. I may delete the exposed
> interface
> vol_factor in /proc later.
> 

Yes, I assume that the 'factors' will be fixed, and you can remove them in /proc later.

> 
> 
>>Is so, this does indeed not belong to the driver and has to be
> 
> removed.
> 
>>Such computation has always been performed in userspace by libsensors,
>>for all drivers. The reason for this is that libsensors can do almost
>>any mathematical operation, not only apply factors. As a matter of
> 
> fact,
> 
>>the W83792D chip needs more than factors for -5V and -12V (an
> 
> additional
> 
>>offset is needed), and unless I am missing something, your driver
>>doesn't handle that. There is also a kernel development policy which
>>states that conversions should always be moved outside of the kernel
>>when possible, and this is exactly what libsensors is there for.
>>
>>As a side note, I'm already not certain that restricting the access to
>>these values in the Windows world makes sense, but I am certain that
> 
> it
> 
>>makes no sense in the Linux world. The goal of open-source tools is to
>>give the users the possibility to change whatever them want to, and
>>certainly not to put restrictions to what they are allowed to do. And
> 
> at
> 
>>any rate there is no room for such a restriction mechanism in the
>>libsensors framework.
> 
> 
> In my w83792d.c I calculate the voltages according to the data sheet of
> 792,
> Please refer to the page 39(Chapter 8.6), page 41(Chapter 8.7), page 61
> (Chapter 8.28 and 8.29) of 792 Data Sheet.
> Do you mean that I should multiply these factors in user space, instead
> of
> doing that in the driver w83792d.c?
> But I find that in the driver w83781d.c, it also do the translation in
> kernel
> by using such macros:
> #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
> #define IN_FROM_REG(val) (((val) * 16 + 5) / 10)
> 

These macros are not a full conversion, but simply multiply/divide by 10
with some rounding and limit checks.
The sysctl and /proc interfaces don't use floating point, so any floating
point numbers are scaled by 10 (or 100 or 1000) to become integers.


> Would you please give me an example on how to move the translate into
> user space?
> Is it what MDS said:"adjust computation it can be done in
> /etc/sensors.conf"
> 
> 

The best way is to learn is play with 'sensors' and editing sensors.conf.
If you have linux running on a system with an already-supported chip,
you should be able to do this easily.

> 
>>As a side note, the voltage factors were used in your driver for the
>>measured values only, not for the limits (unless I missed something)
> 
> so
> 
>>it was not working correctly anyway.
> 
> 
> Yes, the voltage factors in my driver is only for the measured value,
> NOT for the limits, that's because in the Datasheet of 792, the factors
> for the measured values are different from for the limits, Please refer
> to
> the page 39(Chapter 8.6), page 41(Chapter 8.7), page 61 (Chapter 8.28 
> and 8.29).
> 
> In the driver of w83781d.c I find that the voltage factors are both for
> the measured values and the limits. Do you have any suggestions for my
> 792 driver about it?
> 

Since the factors are only for the measured values, your implementation is fine.
Adjustments in userspace (through /etc/sensors.conf) would apply to
both the measured values and the limits, so  it would not be
possible to adjust the 'factors' without the separate /proc values
for the factors; otherwise the limits would change as well. But as I said,
hopefully the factors are fixed, and the /proc interface for the factors
can be removed.


> 
> 
>>>And I will need your help at that time. For example, to add 792
>>>related codes into the script program "sensors-detect" because I
> 
> know
> 
>>>very few about Perl. :-)
>>
>>The sensors-detect script is supposed to already identify the W83792D
>>chip (since lm_sensors 2.9.0). If it doesn't, let us know and we'll
> 
> fix
> 
>>it.
> 
> The version of lm_sensors I'm working is 2.9.0. And I find there are
> some codes about 792 in script sensors-detect, But it seems that it does
> NOT
> work, because it can NOT find W83792D chip. Neither do the version 2.8.8
> The attachment is the detect result log, you may refer to it and check
> the
> script again.
> 
> 
> 
>>What will obviously require an update though is libsensors. I suppose
>>you will provide a patch together with the driver itself? Seems hard
> 
> to
> 
>>properly test the driver and especially its interaction with "sensors"
>>without this.
> 
> As to libsensors, I know very few about it, Could you give me a simple
> introduction about it? Such as the function of it, and how to update it
> for me, etc.
> 

Please read doc/developers/new_drivers. This gives a brief summary.
If you add support for libsensors and 'sensors', as Jean said,
it will greatly help your ability to debug the driver.
If you need more help, please ask us.
It is best if you do the userspace changes, however if you do not,
we will eventually do it ourselves.

> 
> Thanks
> Best Regards
> Chunhao
> 2005-1-25
> 
> 
> 
> ==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repe
at the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.

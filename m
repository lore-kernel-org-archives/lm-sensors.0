From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <41EC7CAD.4090202@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi chunhao
sorry for delay
holidays and vacation
will review and respond soon :)
mds

Huang0@Winbond.com.tw wrote:
> Hi MDS, Jean, and Mark
> 
> This is chunhao.
> 
> I have sent the w83792d driver source code and datasheet to you
> for about 20 days, But I have NOT get any comments till now.
> 
> Did you review my codes? If you have some suggestions, 
> Please don't hesitate to tell me. :-)
> 
> 
> Thanks
> Best Regards
> 
> Chunhao
> 
> 
> 
>>-----Original Message-----
>>From: Mark Studebaker [mailto:mds4@verizon.net]
>>Sent: 2004?12?24? 01:03
>>To: PI14 HUANG0
>>Cc: PI10 LHHsu; PI14 DZSHEN; sensors@Stimpy.netroedge.com
>>Subject: Re: Winbond 792 source codes for lm_sensor
>>
>>chunhao,
>>we received both the datasheet and the code.
>>thank you very much.
>>I'm sure you'll receive comments soon.
>>mds
>>
>>Huang0@Winbond.com.tw wrote:
>>
>>>Hi MDS, Jean, and Mark
>>>
>>>This is chunhao.
>>>
>>>The 792 driver of trial version has been sent to you,
>>>Please check it, and please just me us a response if
>>>you get it.
>>>
>>>I'd like to add some comments to the 792 driver:
>>>1 The source is just a trial version, I will continue
>>>to modify it, so please don't add it into the cvs.
>>>And I will commit it by lm_sensors cvs, later, which
>>>maybe need your help. :-)
>>>
>>>
>>>2 The file sent to you is only one: w83792d.c
>>>I also modified the following files:
>>>  2.1 prog/sensors/main.c
>>>  2.2 prog/sensors/chips.h
>>>  2.3 prog/sensors/chips.c
>>>  2.4 lib/chips.h
>>>  2.5 lib/chips.c
>>>  2.6 lib/proc.c
>>>If you need refer to them, please tell me.
>>>
>>>3. some of the function are added by me in 792, maybe
>>>they do NOT exist in w83781d.c, I will write some
>>>documents to them when I release it in the future.
>>>For example: the following functions
>>>w83792d_thermal_cruise()
>>>w83792d_fan_tolerance()
>>>w83792d_sf2_points()
>>>w83792d_sf2_levels()
>>>w83792d_fan_cfg()
>>>have something to do with SmartFanI and SmartFanII
>>>mode. As to the SmartFan mode, you may refer to the 792
>>>data sheet.
>>>
>>>
>>>4. If you find some bugs in the source, please don't
>>>hesitate to tell us, and you may also give me some other
>>>suggestions about it.
>>>:-)
>>>
>>>Btw, Do you have an available w83792d chip? If do, maybe
>>>you can do some simple test for me when you are free?
>>>
>>>Thanks
>>>Best Regards
>>>
>>>
>>>Chunhao
>>>
>>>________________________________________
>>>From: PI14 DZSHEN
>>>Sent: 2004?12?23? 16:59
>>>To: 'mds4@verizon.net'; 'khali@linux-fr.org'; 'mhoffman@lightlink.com';
>>
>>'sensors@Stimpy.netroedge.com'
>>
>>>Cc: PI14 HUANG0; PI10 LHHsu
>>>Subject: Winbond 792 source codes for lm_sensor
>>>
>>>Dear all:
>>>  Per my manager?s request (Haoge, lhhsu@winbond.com.tw), I am sending
>>>this 792 source code. If you have any technical questions, please
>>>contact huang0@winbond.com.tw.
>>>
>>>Best regards
>>>
>>>techeng
>>>
>>>
>>
>>=====================================
>>=========The privileged confidential information contained in this
>>email is intended for use only by the addressees as indicated by the original
>>author of this email. If you are not the addressee indicated in this email or
>>are not responsible for delivery of the email to such person, please kindly
>>reply the sender indicating accordingly and delete all copies of it from your
>>computer and network server immediately. We thank you for your cooperation.
>>It is advisable that any unauthorized use of confidential information of
>>Winbond is strictly prohibited; and any information in this email that does
>>not relate to the official business of Winbond shall be deemed as neither given
>>nor endorsed by
>>Winbond.=================================
>>=============If your computer is unable to decode Chinese font,
>>please ignore the following message. They essentially repe
>>a!
>>
>>> t the&nbsp; English statement above.??????????????????
>>
>>?, ?????????????????. ??????????????????
>>???????????????, ???????????????????????
>>?????. ??????, ??????. ????, ???????????????
>>??????????????. ??????????????,????????
>>??????.
>>
>>>
> 
> 
> ==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repe
at the&nbsp; English statement above.???H????t????q?l???]?????K???T, ????v??o?H?H??w?????H?H??\????. ????z??D?Q??w?????H?H??]????]?b???g???v????????U?????H??, ??z?i????o?H?H???Y?N?H??q?q???P????A???????H??. ???z???X?@, ????P??. ?S??????, ????g???v????????q?l????K??T?????O?Q?Y??T??. ?H??P????q?l??~?L????e,???o?????q?l??????N??.

From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux-2.4
Message-Id: <4237A4EE.90601@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you can get it without the line numbers here

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/kernel/chips/w83792d.c

:) :) :)

Huang0@Winbond.com.tw wrote:
> Hi MDS, Jean
> 
> 
>>>Just a couple clarifications:
>>>
>>>1* Not all chips have subclients, in fact most haven't, only Winbond
>>>chips and Asus clones have.
>>>
>>>2* In our current implementation, subclients are registered only to
>>>prevent other drivers to use them. They are not accessed by their
>>>address (the same functions are available from the main address).
>>
>>Khali is correct. It doesn't affect operation of the driver, only
> 
> prevent other
> 
>>drivers from interfering.
>>
>>I added, tested, and checked in the subclient registration code.
>>I also changed the init default to 0, which is our standard.
> 
> 
> I saw the codes related with the subclients on Web CVS just now, thanks.
> 
> 
> 
>>Anyway, I happen to agree with the four points listed, point 3
> 
> (negative
> 
>>fan speed values) being the most important to fix quickly IMHO.
> 
> 
> Since I do NOT have a lm_sensors CVS account, and can NOT login CVS in
> my
> by anonymous account(maybe our company forbid the port),
> I downloaded the w83792d.c from web CVS, deleting the line number on
> each line,
> to get the newest 792 driver modified by MDS. I'm using it to solve the
> points
> MDS sent me.
> 
> Thanks
> Best Regards
> Chunhao
> 
> 
> ==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repe
a!
>  t the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.
> 


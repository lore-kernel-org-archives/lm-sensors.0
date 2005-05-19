From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: A probelm of loading module i2c-ali1563.o
Message-Id: <ETcELAuP.1105693114.0305750.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <265EC8B67800A345A8FB8CA013220F0119E39D@wehqml01>
In-Reply-To: <265EC8B67800A345A8FB8CA013220F0119E39D@wehqml01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> We found the source of i2c-ali1563.c on the internet:
> http://www.kernel-websource.com/linux266/source-i2c-ali1563.htm
> Could you confirm it when you are free?

Picking the sources from some random website doesn't sound really good
;) I would use this one:
http://linux.bkbits.net:8080/linux-2.5/anno/drivers/i2c/busses/i2c-ali1563.c@1.12

At least you'll be sure the file is correct and up-to-date. If you want
the file itself, which I think you can't download from bitkeeper's web
interface, then you should simply download linux-2.6.11-rc1.

> I tried to get the source
> from LM-Sensors CVS, but failed to login for several times:

I did not experience any problem recently. Try again later, if it still
doesn't work you may contact Philip Edelbrock but since it works for me
the problem might be on your side and not on the server side.

> If we have to backport i2c-ali1563 to Linux 2.4 by myself,
> Could you give me some guides about it?

I am not an expert in bus drivers, so say the least. All I can tell is
that the Linux 2.6 i2c-ali1563 driver is based on the Linux 2.6
i2c-ali15x3, i2c-ali1535, and i2c-i801 drivers. This means that if you
compare these drivers with their lm_sensors CVS counterparts and report
the differences to the i2c-ali1563 driver, you should get a driver that
works with lm_sensors CVS. If you have more technical questions, I guess
that the various folks who wrote and ported these bus drivers will be of
more help to you than I can be myself.

--
Jean Delvare



>
>
>Best Regards
>Chunhao
>
>
>> -----Original Message-----
>> From: Jean Delvare [mailto:khali@linux-fr.org]
>> Sent: 2005??1??13?? 20:07
>> To: PI13 CFLi; sensors@Stimpy.netroedge.com
>> Cc: Patrick Mochel; PI10 LHHsu; PI14 DZSHEN; PI14 HUANG0
>> Subject: Re: A probelm of loading module i2c-ali1563.o
>>
>>
>> Hi,
>>
>> > While I'm trying to load the module of the south bridge chip (ULI M1563
>> > B1), it shows
>> >[root@localhost busses]# insmod ./i2c-ali15x3.o
>> >./i2c-ali15x3.o: init_module: No such device
>>
>> Expected, since the M1563 is not supported by this driver.
>>
>> > Is there any module named "i2c-ali1563"? I only found "i2c-ali15x3".
>> >
>> > Does i2c-2.8.8 support this chipset of ULi?
>>
>> There is an i2c-ali1563 driver specifically written by Patrick Mochel for
>> the M1563, but only available for Linux 2.6 at the moment:
>> http://archives.andrew.net.au/lm-sensors/msg26537.html
>>
>> You would need to port it back to 2.4 (i.e. to lm_sensors CVS). Patrick
>> seems to think this would be easy.
>>
>> --
>> Jean Delvare
>
>==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repe!
 at the  English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.

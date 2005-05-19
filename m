From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE1906A5@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, MDS


> This is good news. That said, we don't really have to wait for you to
> finish porting to 2.6 before we commit your 2.4 driver to lm_sensors
> CVS. Both sides are mostly independent. I guess we can commit the 2.4
> driver as soon as MDS is happy with your code (I admit I don't have
> much time to review it myself).

I agree that 792 driver for 2.4 and 2.6 are independent, one of my
colleagues will help me to test the 792 driver for linux-2.4, when he
get another ASUS motherboard with 792 chip a few days later.

I think there should NOT be many bugs in 792 driver for 2.4 after the review
of MDS and me, and wish to commit it into CVS as soon as possible. But my manager
suggested that I commit it only after a full test, so that we can avoid some na?ve
bugs, I agree with him now, but this will lead to the delay in committing
the 792 driver.


> Yes, you should always stick to whatever the latest 2.6 tree is. That way
> you are certain that your code with comply with the latest evolution of
> the 2.6 i2c core.
> 
> When the driver is ready, you will have to send it to Greg KH, in the
> form of a patch against the latest linux 2.6-mm version. Hopefully,
> changes won't be too big between the latest standard 2.6 tree and the
> 2.6-mm version, so you won't have much to change at this point. You may
> work directly with the latest -mm version if you want, but these are
> typically less stable that the regular versions, so I wouldn't
> recommend them as a development environment.

I agree with you, now I'm compiling the kernel linux-2.6.10, which is stable.
I have checked that there are few difference in some bus drivers between 
linux-2.6.10 and linux-2.6.11-rc3.


> I tried to make Documentation/i2c/porting-clients as accurate as
> possible, but I may have missed recent changes done to the i2c subsystem
> in 2.6. If you find errors or missing information, please let me know so
> that I can update the document.

OK, no problem.:-)

> Also note that the sysfs interface to hardware monitoring chips in 2.6 is
> more standardized than the procfs one in 2.4 was, and you really have to
> stick to that standard. See Documentation/i2c/sysfs-interface for
> details. If you have questions about this or find an error in this
> document, let us know as well.

Yes, after the examination to the sysfs-interface of W83627THF(it is on my
motherboard), I find it's really different with the interface of linux-2.4

And we have one question:
we want to add some other sys-interfaces about Winbond Smart FanI and FanII,
for example, in the 792 driver of linux-2.4, I added such interfaces:
fan_cfg,
pwm_flag,
pwm[1-3],
thermal_cruise,
fan_tolerance,
sf2_levels_fan[1-3],
sf2_points_fan[1-3]
[Note: Please refer to the mail and attached pictures sent by me on 2005-01-24]
If I also want to add these interfaces into 792 driver for linux-2.6,
How should I stick to the standard Documentation/i2c/sysfs-interface?
Because it seems that it has no description about SmartFan.

Thanks
Best Regards

Chunhao
2005-02-04


==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repea!
 t the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.

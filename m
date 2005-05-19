From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503091308100.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please can you take a look to other logs (syslog/messages/debug/) and copy
it here (from modrobe of i2c-ali...) until modprobe of w83...

I think I need more information to think about it. I hope Patrick will
have some ideas :)

Regards

Rudolf


On Wed, 9 Mar 2005 Huang0@Winbond.com.tw wrote:

> Hi Rudolf
>
>
> > Would you please try again with debugging enabled?
> > (same case as we did for i801)
>
> I re-compiled my linux-2.6.10 with
> CONFIG_I2C_DEBUG_CORE=y
> CONFIG_I2C_DEBUG_ALGO=y
> CONFIG_I2C_DEBUG_BUS=y
> CONFIG_I2C_DEBUG_CHIP=y
> this time.
>
>
> > 1) reboot/halt, modprobe w83792d, copy logs
> The debug message is:
> Mar  9 19:34:30 pi140001 kernel: i2c_adapter i2c-0: SMBus Error:
> Timeout Device Error Transaction Never Finished
>
>
> > 2) reboot/halt, sensors-detect, copy logs
> Mar  9 19:37:06 pi140001 kernel: i2c /dev entries driver
> Mar  9 19:37:11 pi140001 wait_for_sysfs[5435]: either wait_for_sysfs
> (udev 039) needs an update to handle the device '/class/i2c-dev'
> properly
> (class specific file unavailable) or the sysfs-support of your device's
> driver
> needs to be fixed, please report to
> <linux-hotplug-devel@lists.sourceforge.net>
>
>
> > 3) modprobe w83792d, copy logs
> No debug message output this time.
>
> Thanks
>
> Best Regards
> Chunhao
>
>
> ==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially rep!
 ea!
>  t the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.
>
>

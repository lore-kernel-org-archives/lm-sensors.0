From: JGong@winbond.com (JGong at winbond.com)
Date: Wed, 14 Mar 2007 10:25:02 +0000
Subject: [lm-sensors] lm-sensors and 2.6.18 kernel under debian
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A3163B@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F6AAC5.5050307@wanadoo.fr>
In-Reply-To: <45F6AAC5.5050307@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, S?bastien

>#----cut here----
># I2C adapter drivers
>i2c-i801
>i2c-isa
># I2C chip drivers
># no driver for Winbond W83792D yet
># Warning: the required module smbus-arp is not currently installed on
>your system.
># For status of 2.6 kernel ports see
>http://secure.netroedge.com/~lm78/supported.html
># If driver is built-in to the kernel, or unavailable, comment out the
>following line.
>smbus-arp
>w83627hf
>#----cut here----

According to the message:" no driver for Winbond W83792D yet", I advise you to update the lm_sensors package first. You can download the latest version from the lm_sensors home page.

Then unpack the lm_sensors package and try "make user" and "make user_install".

After that, you can run "sensors-detect" again to see whether it can detect the w83792d chip or not.

Best regards,
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.


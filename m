From: JGong@winbond.com (JGong at winbond.com)
Date: Tue, 09 Jan 2007 06:18:18 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A31586@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, Noah

>There is no temp6_mode file. Only three files in /sys/class/hwmon:
>/sys/class/hwmon/hwmon2/uevent
>/sys/class/hwmon/hwmon1/uevent
>/sys/class/hwmon/hwmon0/uevent
>There's group of temp6 files in the the devices 
>heirarchy: /sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/temp6*

En, you can try this one to see the temp6 mode:

cat /sys/bus/i2c/drivers/w83793/0-002f/temp6_type

Best regards,
Gong Jun



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.


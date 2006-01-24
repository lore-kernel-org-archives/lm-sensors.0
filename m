From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Tue, 24 Jan 2006 06:05:36 +0000
Subject: [lm-sensors] w83627ehf fan controll?
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECED827CB@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051230143805.GA21201@Apollo>
In-Reply-To: <20051230143805.GA21201@Apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
The attachments is the diff of linux-2.6.16-rc1 and my local CVS, These
two patches use new sensor attr and add more functions, any comments and
modify are welcome. Hope someone can help fix the bugs in these patches
and send it out.Thanks.

It depends on "[PATCH 15/17] hwmon: Semaphore to mutex conversions"
hwmon-convert-semaphores-to-mutexes.patch
The first patch is w83627ehf_use_new_sensor_device_attr.patch.txt
w83627ehf_add_more_functions.patch.txt is the second.

Best Regards
Yuan Mu



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: w83627ehf_use_new_sensor_device_attr.patch.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060124/d5f60576/w83627ehf_use_new_sensor_device_attr.patch-0001.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: w83627ehf_add_more_functions.patch.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060124/d5f60576/w83627ehf_add_more_functions.patch-0001.txt

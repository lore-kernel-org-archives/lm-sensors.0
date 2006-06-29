From: ymu@winbond.com (Yuan Mu)
Date: Thu, 29 Jun 2006 07:46:40 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS K8N-VM
Message-Id: <44A38560.1000808@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A326F3.3070300@winbond.com>
In-Reply-To: <44A326F3.3070300@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daan,
> 
> Thanks for your quick response. I am using latest vanilla kernels from 
> kernel.org (so 2.6.17.1 now). Which version will support the voltage 
> stuff in the w83627 driver?
> Btw I also tried some patches for the 410 chip on the nforce2 driver 
> that I found in the lmsensors archive, but those didn't bring me 
> anything either.
Sorry, It seems the voltage support has been added to the w83627ehf driver only 6 days ago ;)
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/hwmon/w83627ehf.c

You can also get the patch from the link.

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.


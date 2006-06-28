From: ymu@winbond.com (Yuan Mu)
Date: Wed, 28 Jun 2006 09:58:41 +0000
Subject: [lm-sensors] About w83627ehf driver....
Message-Id: <44A252D1.4040707@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1151424841.44a159492df27@www.inbox.lv>
In-Reply-To: <1151424841.44a159492df27@www.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
To avoid such questions, i'm backporting the driver to kernel 2.4, i think driver for 2.6
is stable now :)

Hi Andris,
I would send you a workable version later if you wanna to try :)
> 
> I have one question.  I  some days ago get  Asus N4L-VM-DH motherboard. 
> I install i2c and lm-sensors 2.10.0. sensors-detect utility detect 
> w38627ehf sensor, but there is no driver in the lm-sensors package for 
> this sensor.
> When i load lm80 driver, it's dont indicate temperature, fun rpm is 
> indicated (i don't known is it corectly).
> Where can i get driver for this chip and when in the lm-sensors package 
> come inside this driver?
> I use linux with kernel 2.4.17

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.


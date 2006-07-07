From: ymu@winbond.com (Yuan Mu)
Date: Fri, 07 Jul 2006 06:14:23 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <44ADFBBF.9070309@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44893948.2070709@winbond.com>
In-Reply-To: <44893948.2070709@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I revised the driver and make a patch against the file you send to me, please
can you check if it meet your review :)

And some note:
1.I removed some not used MACROs, and fix a wrong register definition.
2.tolerance registers, i stored the register value in cache, so i think no need to use index/2.
3. I leave the update_nonvolatile function there, because update too many registers every time
is just not worthy, if it can change in 300s interval, it also may change in 3s...


-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: w83793_revise_1.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060707/da56796a/attachment.pl 

From: ymu@winbond.com (Yuan Mu)
Date: Thu, 15 Jun 2006 04:24:49 +0000
Subject: [lm-sensors] ASUS K8V-X SE should be supported?
Message-Id: <4490E111.30104@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <448F748D.5000703@dogsbody.org>
In-Reply-To: <448F748D.5000703@dogsbody.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dan,

>> Could someone please help me with the correct modprobe command?
> 
> The force parameter is not worth the trouble I guess more easier would be to
> backport the driver to your kernel version.
> 
Maybe it should be redhat ? they sold EL to you ;)

Ok, i try to make 627ehf work on my board this morning, and the attachment is the results.

1. You need to install EL kernel source first(if not installed)
2. unzip the attachment.
3. "cd lm_sensors26/old"
4. "make install"(i hope you have load the bus driver correctly)


I must said i hope it can help you, but without WARRANTY.It's in a hurry.
And hope you can help test the 627ehf driver which Rudolf and David working on :)

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors26.tar.gz
Type: application/gzip
Size: 12727 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060615/2bf72771/attachment-0001.bin 

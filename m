From: <JGong@nuvoton.com>
Date: Tue, 24 Feb 2009 08:49:53 +0000
Subject: Re: [lm-sensors] W83667HG on ASUS P6T6 WS Revolution
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0020AE0D@ntshml01.nuvoton.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <498B944A.3060502@ioerror.us>
In-Reply-To: <498B944A.3060502@ioerror.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

So far, the w83667hg's pin 109(in6 and temp3's shared pin) selection is only decided by BIOS. So maybe the user has to config the value with the help of its own BIOS readings, and then disables the meaningless output in the sensors.conf file.


Best regards,
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

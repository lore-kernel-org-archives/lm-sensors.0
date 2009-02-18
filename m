From: <JGong@nuvoton.com>
Date: Wed, 18 Feb 2009 10:19:01 +0000
Subject: Re: [lm-sensors] hwmon: add support for w83667hg
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0020AE08@ntshml01.nuvoton.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD2@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD2@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

I am sorry for my long overdue response. I've been busy with some other projects those months.

>This is the same register as temp2, isn't it? Does it mean that in6 and
>temp2 share a pin on the W83667HG chip? If this is the case then only
>one of these features should be exposed. Which one depends on the chip
>configuration.

Yes, the temp2 and the in6 share the pin 109. But I haven't found any configuration register about this issue yet.

>What is the problem exactly and why is it happening? Probably this is
>related to the shared register 0x250 as discussed above. I don't think
>the code is correct, but without the datasheet and chip I can't tell
>for sure. Please explain the situation in details.
 
At that time, when I scanned the spec, I found the bank 0 index 26h was "reversed" and the in6 reading and temp2 reading shared the bank2 index 50h, so I used those codes to stop monitoring the temp2 and read out temp2's register as in6 reading. 

However, recently I consult this problem with my colleague again, he replies that I should still read the in6 at bank 0 index 26h.(It may be the datasheet problem) So I am going to test it on my platform, and make another patch out later.

Best regards,
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

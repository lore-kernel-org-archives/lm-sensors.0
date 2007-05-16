From: Philip Pokorny <ppokorny@penguincomputing.com>
Date: Wed, 16 May 2007 21:16:16 +0000
Subject: Re: [lm-sensors] k8temp
Message-Id: <464B74A0.7010204@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200703212247.05783.tomcw@adelphia.net>
In-Reply-To: <200703212247.05783.tomcw@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>>raw data drawn from a PCI inspection .....
>>
>>$ sudo setpci -s 00:18.3 e4.Bz
>>    
>>
>
>So you are not setting this as the reg value but this  is just a result (7a)
>  
>
No, that command *writes* 7A to PCI space register offset E4.

>>$ sudo lspci -s 00:18.3 -xxx
>>00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
>>e0: 00 00 00 00 7a 20 28 00 19 17 00 00 00 00 00 00
>>    
>>

Which values are of interest here?

Do you know that you can read PCI space using setpci like so:

[root@beluga ~]# setpci -v -s 00:18.3 e4.b e4.w e6.w
00:18.3:e4 = 20
00:18.3:e4 = 0f20
00:18.3:e6 = 164c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

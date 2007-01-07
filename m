From: christophe.dr@free.fr (Christophe de =?iso-8859-1?q?Rivi=E8re?=)
Date: Sun, 07 Jan 2007 10:07:42 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk > no
Message-Id: <200701071107.50461.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have reported this problem in many places and searched the internet a long 
time for a solution but i can't find some suitable fix.
The problem is that i can't monitor and control the sensor chip datas because 
of the lack of smbus detection. Yet this problem had been solved about 2 
years ago when i reported it on this list thanks to the help of Jean 
Delvare :
http://archives.andrew.net.au/lm-sensors/msg29507.html
http://archives.andrew.net.au/lm-sensors/msg29523.html
I am using now an old mandriva 2006 with kernel 2.6.12-27 that is properly 
detecting the smbus and it appears on the lspci as :
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 03) 
But now that i want to jump to a newer distro, none of them is able to detect 
this smbus in spite of the quirks (see above) that is present in the kernel :
$ cat /usr/src/linux/drivers/pci/quirks.c |grep -i w1
                        case 0x184b: /* W1N notebook */
The same lack occured occured on ubuntu 6.10 , suse 10.1, mandriva 2007 and 
suse 10.2 with recent kernels ranging from 2.6.16 to 2.6.18 . No smbus is 
appears on the lspci for any of these distro.
I reported this problem here :
http://www.suseforums.net/index.php?showtopic%980
http://qa.mandriva.com/show_bug.cgi?id%281
But i had no answers.
The sensor monitor and fan speed control is a very interesting feature on this 
laptop for battery saving reasons.
I'd be really glad if someone could help .
Or please someone point me to a better place to report this problem.


Thanks.

-- 
christophe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070107/5d18353e/attachment.bin 

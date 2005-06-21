From: Eric.Pascal@itesoft.com (Eric Pascal)
Date: Tue, 21 Jun 2005 15:57:57 +0000
Subject: TR: [lm-sensors] Patch for w83627hf chipset
Message-Id: <4A9A21CEA07B1F4A973CFCD89B9446C9011182DE@sermaila.itesoft.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anybody could help me describing the procedure to integrate my patch?
Thank you.

-----Message d'origine-----
De : lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org]De la part de Eric Pascal
Envoy? : jeudi 16 juin 2005 09:47
? : BGardner@Wabtec.com
Cc : lm-sensors@lm-sensors.org
Objet : RE: [lm-sensors] Patch for w83627hf chipset


Here is a more standard patch file.
Hope someone would be able to help me on the content.

-----Message d'origine-----
De : BGardner@Wabtec.com [mailto:BGardner@Wabtec.com]
Envoy? : mercredi 15 juin 2005 23:59
? : Eric Pascal
Objet : RE: [lm-sensors] Patch for w83627hf chipset


Hi Eric,

I took a quick look at your patch out of pure curiosity...

There are two problems with the patch format:

1. The diff format looks weird. 
Try this from just above the root of your build tree(s):
$ diff -Naur orig/drivers/i2c/chips/w83627hf.c
new/drivers/i2c/chips/w83627hf.c

2. A bunch of 0x0D characters were added to the patch.
You may be able to use your editor to convert to UNIX line endings or
you can clean it up using tr:
$ cat w83627hf.c | tr -d "\r" > w83627hf.c

I'm not familiar with that part, so I can't comment on the content of
the patch. =)

Ben

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Eric Pascal
Sent: Wednesday, June 15, 2005 4:28 PM
To: lm-sensors@lm-sensors.org
Subject: [lm-sensors] Patch for w83627hf chipset

Hello,
 
I have a patch for the i2c driver of chipset w83627hf that is included
in my Asus P4P800 that enable the Q-fan functionality to autoregulate
fan speed depending on temperature. I have to apply the patch on every
version a the 2.6 kernel I compile, would it be possible to integrate
the patch definately. I'm not the author of the patch but it's very
useful for me. I made a patch fon the 2.6.12-rc6 kernel, it's attached
to this e-mail.
 
Thank you.
 
Eric PASCAL

 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch_w83627hf
Type: application/octet-stream
Size: 15615 bytes
Desc: patch_w83627hf
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050621/73a835ee/patch_w83627hf.obj
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

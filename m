From: Eric.Pascal@itesoft.com (Eric Pascal)
Date: Wed, 15 Jun 2005 23:29:09 +0000
Subject: [lm-sensors] Patch for w83627hf chipset
Message-Id: <4A9A21CEA07B1F4A973CFCD89B9446C9011182C1@sermaila.itesoft.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
 
I have a patch for the i2c driver of chipset w83627hf that is included in my Asus P4P800 that enable the Q-fan functionality to autoregulate fan speed depending on temperature. I have to apply the patch on every version a the 2.6 kernel I compile, would it be possible to integrate the patch definately. I'm not the author of the patch but it's very useful for me. I made a patch fon the 2.6.12-rc6 kernel, it's attached to this e-mail.
 
Thank you.
 
Eric PASCAL

 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch_w83627hf
Type: application/octet-stream
Size: 16817 bytes
Desc: patch_w83627hf
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050615/aa178ba5/patch_w83627hf.obj

From: Warrick Lacey <wlacey@salientsystems.com>
Date: Mon, 02 Jun 2008 18:54:45 +0000
Subject: [lm-sensors] adm1021 in 2.6.9 question..
Message-Id: <484441F5.6000203@salientsystems.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050002090106080509020402"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050002090106080509020402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

We have recently transitioned for a 2.4.x based kernel to the 2.6.9 
kernel and I'm trying to get the onboard temperature sensor working 
under the 2.6.9 kernel. Under the 2.4.x kernel, we needed i2c-core, 
i2c-dev, i2c-proc, dmi-scan, i2c-piix4 and adm1021.

We have not changed hardware (basically a 6U VR7 board), will/should the 
adm1021 device be an ISA device or an I2C device?.

I see that the adm1021 driver is now part of the kernel in 2.6.x but 
what steps to I have to take to get the kernel to recognize and access 
this device under 2.6.9.

Thanks for any help.
Warrick Lacey


--------------050002090106080509020402
Content-Type: text/x-vcard; charset=utf-8;
 name="wlacey.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="wlacey.vcf"

begin:vcard
fn:Warrick Lacey
n:Lacey;Warrick
org:Salient Systems;Engineering
adr:Tuller Road;;4394 Suite K ;Dublin;Ohio;43017;U.S.A.
email;internet:wlacey@salientsystems.com
title:Software Developer
tel;work:(614) 792-5800
tel;cell:(614) 203-1323
x-mozilla-html:FALSE
url:http://www.salientsystems.com
version:2.1
end:vcard


--------------050002090106080509020402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050002090106080509020402--

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 04 Mar 2006 20:59:13 +0000
Subject: [lm-sensors] [PATCH] Add fan control support to W83627EHF
Message-Id: <4409FFA1.7050109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

This is just first shot patch. I finished Yuans work and now we have the ability to control
the fans and two automatic modes. It took me literaly whole day :/

David,
Please can you test the patch as much as possible?
You may need to apply the voltages patch first to be able to patch this.

Second file contains some very simple documentation that should help to test the stuff.

Yuan,

I removed the speed cruise option and reworked the interface. I would like to ask
why you did not allow the FAN4 PWM interface? I checked new datasheet from your website
and it seems that it can be there when checked if correctly programmed.

Thanks,

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_add_fancrt.patch
Type: text/x-patch
Size: 15571 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060304/debc98ee/w83627ehf_add_fancrt-0001.bin
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: docs
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060304/debc98ee/docs-0001.pl

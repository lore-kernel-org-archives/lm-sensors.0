From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH] updated it87 for kernel 2.6
Message-Id: <20040216210601.6dae0bf7.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I found it87 in kernel 2.6 may be based on old module.
It lacks reset_it87 option and smart guardian (sg) features in
lm_sensors cvs.

So I tryed to add these features and made the patch for
linux-2.6.2-rc2. It works well for me.

If you think the attached patch is useful, please merge it in.

Thanks in advance.
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.2-rc2-i2c-it87.patch
Type: application/octet-stream
Size: 13061 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040216/56caa4b3/linux-2.6.2-rc2-i2c-it87.obj

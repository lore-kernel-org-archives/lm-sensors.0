From: Bruce.Lee@landesk.com (Lee, Bruce)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: Support for w83791d
Message-Id: <2B6C784DD3723745978C27C72801F7F8AC80F6@cba0e2k04.cba0.centerbeam.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am trying to monitor sensors on a gateway 980 with an Winbond 83791d
chip.  I am using lm_sensors 2.8.0 and have loaded the w83781d module
(sensors-detect failed to detect this chip) but I am seeing no results.
Is this chip supported and if so, how do I get the module to load and
run correctly? Do I need to do a force_w83791d on the command line and
if so how do I do this?
 
results from lsmod

w83781d                24880   0  (unused)
i2c-i801                5460   0  (unused)
i2c-dev                 5056   0  (unused)
i2c-proc                8084   0  [w83781d]
i2c-core               20164   0  [w83781d i2c-i801 i2c-dev i2c-proc]
 
results from sensors

No sensors found!
 
thanks
Bruce Lee
bruce.lee@landesk.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031111/33023c39/attachment.html

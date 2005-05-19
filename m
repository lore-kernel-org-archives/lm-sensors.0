From: nathook@microtron.org.uk (Nat Hook)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: i2c-voodoo3 bug fix
Message-Id: <1100995535.27226.29.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I noticed that the first time the resolution is changed after bootup,
the changes do not take effect. This is because the bt869_update_client
function gets called twice, almost consecutively (which means on the
second time it doesnt run{because of the jiffies check}), another
variable, "update_required", has been added to allow the force-running
of it (as a test for this has been added to the IF at the start)

please find attached patched code

Thanks

Nat
nathook@microtron.org.uk
-------------- next part --------------
A non-text attachment was scrubbed...
Name: bt869.c
Type: text/x-csrc
Size: 29342 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041121/0f9146d5/bt869.bin

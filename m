From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 27 Mar 2007 00:46:49 +0000
Subject: [lm-sensors] [PATCH RESEND] lm-sensors: add dme1737 support
Message-Id: <191fb4ca0703261746s586b6c85t2a6aa27423c74e6d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes a bug in sensors-detect that prevents the SMSC
DME1737 from being discovered. It also adds full support for the chip
to libsensors and sensors.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm-sensors-add-dme1737-support.patch
Type: text/x-patch
Size: 14944 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070326/436acab0/attachment-0001.bin 

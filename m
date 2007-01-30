From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 30 Jan 2007 22:37:41 +0000
Subject: [lm-sensors] [PATCH] vt1211: add probing of alternate config index
Message-Id: <191fb4ca0701301437h42a66c81lc7056ecf5ad399ba@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The configuration index port of the vt1211 can be accessed at two
different addresses 0x2e or 0x4e, depending on pin strappings. This
patch adds support to scan both addresses during module
initialization.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-vt1211-add-probing-of-alternate-config-index-port.patch
Type: application/octet-stream
Size: 3565 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070130/2a33699f/attachment.obj 

From: Peter.Milne@d-tacq.com (Peter Milne)
Date: Fri, 16 Jun 2006 20:41:29 +0000
Subject: [lm-sensors] PATCH- i2c-iop3xx platform driver avoid addressing self
Message-Id: <44931779.6050302@d-tacq.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Avoid addressing self when sending a Master address. Follows instruction 
in Intel 80331/80321 manuals.
Ignoring this worked previously on 80321, but causes a hang on i2cdetect 
on 80331

Signed-off-by: Peter Milne <peter.milne at d-tacq.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-iop3xx.patch
Type: text/x-patch
Size: 1181 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060616/453289ad/attachment.bin 

From: aurelien.jarno@laposte.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: PCF8591
Message-Id: <E165yoo-0006Us-00@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I have seen that the patch for the PCF8591 has been put in the CVS, but yet 
it doesn't compile. It seems the file kernel/include/sensors.h has not been 
patch (I don't understand why).
So here is a new patch to correct this.

Aurelien Jarno
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pcf8591.patch2
Type: text/x-diff
Size: 849 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20011120/83a41ae8/pcf8591.bin

From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Tue, 13 Oct 2009 21:49:12 +0000
Subject: [lm-sensors] lm-sensors 3.1.1-3 not detecting sensors on Intel
Message-Id: <alpine.DEB.2.00.0910131743530.5034@p34.internal.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

Hello,

# uname -a
Linux box 2.6.31.3 #2 SMP Wed Oct 14 04:55:36 EDT 2009 x86_64 GNU/Linux

I have a DP55KG motherboard, it says Ibex support was added here:
http://www.lm-sensors.org/changeset/5375

# sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

I have all of the modules compiled into the kernel and sensors-detect does 
not find anything.

00:1f.3 SMBus: Intel Corporation Ibex Peak SMBus Controller (rev 05)

Any ideas?

Justin.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

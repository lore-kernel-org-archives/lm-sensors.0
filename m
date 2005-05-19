From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: done rmmod dmasound_pmac; still get error
Message-Id: <20030806180326.6fc889e1.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 17:57:15 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> "rmmod dmasound_pmac" should do it. If you have other drivers that use
> i2c, remove them too.
Done that. I still get:

Next adapter: uni-n 0 (Keywest i2c)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x30
Client at address 0x48 can not be probed - unload all client drivers first!
Client at address 0x49 can not be probed - unload all client drivers first!
Client at address 0x50 can not be probed - unload all client drivers first!

Next adapter: uni-n 1 (Keywest i2c)
Do you want to scan it? (YES/no/selectively):
Client at address 0x48 can not be probed - unload all client drivers first!
Client at address 0x49 can not be probed - unload all client drivers first!
Client at address 0x50 can not be probed - unload all client drivers first!

Next adapter: mac-io 0 (Keywest i2c)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x34
Client at address 0x56 can not be probed - unload all client drivers first!

Thanks for Feedback.

Zeno

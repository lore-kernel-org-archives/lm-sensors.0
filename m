From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ticket #1291
Message-Id: <20030731145536.253ae723.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030731110954.43f2f54e.khali@linux-fr.org>
In-Reply-To: <20030731110954.43f2f54e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 31 Jul 2003 14:41:08 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> Since I don't really understand what happens there, and you probably
> don't need isadump, let's simply skip it.
> 
> Edit the Makefile, look for that line:
> 
> SRCDIRS += lib prog/sensors prog/dump prog/detect ${PROG_EXTRA:%=prog/%}
> etc
> 
> and remove the prog/dump directory:
> 
> SRCDIRS += lib prog/sensors prog/detect ${PROG_EXTRA:%=prog/%} etc
> 
> If it works for you, at least, you'll be able to use lm_sensors.
Ok great. This one worked just fine. 

-> Installation successful!

Thanks a lot for your time an help. Now lets see what I detect.

Zeno

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 25 Feb 2006 19:58:06 +0000
Subject: [lm-sensors] I switched from AMD XP TB to AMD Mobile Barton
Message-Id: <4400B6CE.1010204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b0601230528q3f9e2f26j@mail.gmail.com>
In-Reply-To: <ea9ff50b0601230528q3f9e2f26j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Filip Tsachev wrote:
> As I ran prime95 torture the "watch sensors" made me notice that CPU
> temp is going from -70 to -65, could you please elaborate on reverting
> the readings? It would be really nice then I could make some offset
> like -20*C and it should become very accurate...


Well you can use the compute lines in /etc/sensors.conf to do that.

> Maybe it is possible to be BIOS fault?? since it's recognized as:
> cat /proc/cpuinfo
> model name      : Unknown CPU Typ
> 
> p.s. I also could find only about A64 some type of diode offset but no
> info for XP-Ms..

Well also bad luck for me. I just found some screenshots of some program mentioning the offset of diode
on bartons CPU (no datasheet was found on the AMD website). I'm sorry I can help more maybe you can
try to create the compute line for temp and put it into the sensors.conf (run sensors -s to apply the changes)

Regards
Rudolf


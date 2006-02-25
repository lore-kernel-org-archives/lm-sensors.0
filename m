From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Sat, 25 Feb 2006 19:30:07 +0000
Subject: [lm-sensors] I switched from AMD XP TB to AMD Mobile Barton
Message-Id: <ea9ff50b0602251130x6701bbc7o@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b0601230528q3f9e2f26j@mail.gmail.com>
In-Reply-To: <ea9ff50b0601230528q3f9e2f26j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As I ran prime95 torture the "watch sensors" made me notice that CPU
temp is going from -70 to -65, could you please elaborate on reverting
the readings? It would be really nice then I could make some offset
like -20*C and it should become very accurate...


Maybe it is possible to be BIOS fault?? since it's recognized as:
cat /proc/cpuinfo
model name      : Unknown CPU Typ

p.s. I also could find only about A64 some type of diode offset but no
info for XP-Ms..

2006/2/24, Rudolf Marek <r.marek at sh.cvut.cz>:
> > The CPU temp should be around 45-55*C.. please guys help me out here,
> > what could be done?
>
> I think that the mobile barton has somewhere a diode offset register. I failed to find
> a datasheet for it so bad luck. I would suggest to google for "thermal offset" or diode
> offset and with conjuction of mobile barton
>
> I hope it helps,
>
> Regards
> Rudolf
>

--
Cheers,
Filip


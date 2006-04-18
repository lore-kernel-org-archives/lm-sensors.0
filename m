From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 18 Apr 2006 20:30:31 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <44454C67.3070603@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dieter Jurzitza wrote:
> Dear Rudolf,
> dear listmembers,
> after building the kernel with debugging active, I flood my /var/log/messages 
> file (something like 100MByte per day).
> What I get is attached. What is apparent to me is the fact that there are 
> error messages every other time (I just attached several seconds) and non 
> regular accesses (should happen every ten seconds) but no hang like before. 
> So I have to wait a little more. If I am unlucky the delays introduced by the 
> tons of printfs prevent sensors from crashing my sensor chip. But maybe some 
> of you guys can understand why the errors are being reported.
> Thank you in advance,
> take care

Yep we can.

There are are errors reading addresses 0x4A and 0x4B
And 0x2C

options w83781d force_w83782d=0,0x2d force_subclients=0,0x2d,0x48,0x49
force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0

So you left the second line there??? and only loading w83627hf with
force_subclients=0,0x2c,0x4a,0x4b ?

I'm asking because there are more addresses access
(cat logpart | awk -FADD '{print $2}' |awk '{print $1}' | sort -u)

Regards
Rudolf


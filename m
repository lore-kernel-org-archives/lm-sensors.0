From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Please analyse output
Message-Id: <20021115095930.4ce246fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F99D36.445B%zdavatz@ywesee.com>
In-Reply-To: <B9F99D36.445B%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I got three fans:
> 1CPU
> 2 Adapter
> 3 Case
Doesn't mean they are able to report their speeds. The plug should look
like that:
http://www.8ballshardware.com/articles/cardcooler/CARDC002.jpg
And be plugged on the motherboard:
http://www.subzeropc.com/images/3pinfanplug.jpg
If its differs from this, then it is normal you don't have the speed
report.

> I attached you the discription of my Server -it is in German sorry.
> Maybe that is of some more use to you.
No problem, I actually read German. Pretty good system indeed, I'd like
the same for myself ;)
This confirms the vid/vcore1 at 1.45V. Apart from that, nothing we can
use I fear.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

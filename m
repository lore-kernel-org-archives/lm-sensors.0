From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Sensors on IBM eServer 335/345?
Message-Id: <0BPPYa1U.1106049076.5506160.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2A5055C0-6929-11D9-98D6-003065F94C4C@cs.umass.edu>
In-Reply-To: <2A5055C0-6929-11D9-98D6-003065F94C4C@cs.umass.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Armen,

> However, sensors-detect still isn't finding any sensor chips on this
> system.  Is there a giant table somewhere that lists motherboard/chip
> combinations so I can find the appropriate drivers for this system?  Or
> any general guidelines to what IBM or Serverworks prefer to use with
> their systems/electronics?  Could the sensor chips be proprietary?

We don't have such a table. We support chips, not board or systems. You
may search the mailing-list archives or the support tickets:
http://secure.netroedge.com/~lm78/search.html
But I don't remember seing this family of servers discussed.

You may ask IBM directly, they are supposed to know what hardware is used
in their server boards. The hardware could be proprietary. Or they might
not be hardware monitoring stuff on these boards at all. What makes you
believe there is?

> Or has anyone used sensors on these machines and knows offhand? :)

Not me. Of course, if you are willing to send me such a server for free,
I would take a look ;)

> Are there any gotchas with regards to installing the latest
> i2c/lmsensors (2.9.0) on an older kernel (2.4.21)?

No, it should work just fine.

> I know this machine
> has two Xeon processors, and Xeons have embedded temperature sensors,
> but have not had much luck trying to access them after inserting the
> xeontemp lmsensors module - just wondering if my old kernel could have
> anything to do with it.

I don't think so.

If the Xeon have thermal sensors, sensors-detect should have seen them,
and the xeontemp driver as well. But I think I remember that not all
Xeon CPUs have the thermal sensors.

You can send us the full output of sensors-detect (after unloading all
i2c chip drivers) and we'll tell you if something can be done.

--
Jean Delvare

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Feb 2008 22:22:20 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O
Message-Id: <1203718940.6976.19.camel@pasglop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Fri, 2008-02-22 at 11:18 +0100, Christian Krafft wrote:
> Hi Ben,
> 
> regarding your problem with poking into PCI ranges:
> As arnd mentioned, we could check, wether there is a mapping for that address
> and if so, allow the access. That could be done in check_legacy_ioport,
> although the name looks a bit misleading.
> What do you think ?

It would be pretty gross to end up checking the whole device-tree
for things...

Maybe we could check that there's something in the resource tree though,
under ioport_resources, that matches the requested port.

But again, its a matter of preventing root from being stupid, which I'm
not sure is that worth pursuing...

Ben.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

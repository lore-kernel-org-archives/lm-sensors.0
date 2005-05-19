From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: nForce2
Message-Id: <20030625170142.72195ad2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Sea1-F157XvPIPKH5jt0000cb5f@hotmail.com>
In-Reply-To: <Sea1-F157XvPIPKH5jt0000cb5f@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hmm, seems like a lot of playing around.
> Could you tell me how I would go about detecting the sensors, just to 
> monitor them with an app like gkrellm? It is really that hard? I have
> a bit of experience with linux so I know how not to break a system. :)
> BTW, I'm running Redhat 9 (kernel 2.4.20-8) on a Shuttle SN41G2 XPC
> and an AthlonXP 2600+ 333FSB.

Gkrellm, just like any other monitoring app, makes use of libsensors,
which is part of our lm_sensors package, itself relying on our i2c
packages. These are dependencies you can't ignore, and versions of each
from your current Red Hat installation are not compatible with the new
(our) ones. This is why I said you would have to reinstall everything
from sources - if you really want to do it.

So here's the deal. Either you wait for us to release version 2.8.0 of
our packages (within a month if everything goes OK) and you then wait
for Red Hat to package it, or you are impatient and want it to work
right now. In the second case, you'll need to remove existing packages
and then install from sources. We'll help you doing so if that is what
you want, but only you know what you want to do.

> PS. If possible, please reply to munday@globaldial.com . Thanks.

Free to you to set a "Reply-To: munday@globaldial.com" header, the same
way I set a "Reply-To: sensors@stimpy.netroedge.com" header on my side.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: Matt Roberds <mattroberds@cox.net>
Date: Tue, 26 Feb 2008 19:13:51 +0000
Subject: Re: [lm-sensors] First shot at Asus M2N-SLI Deluxe config file
Message-Id: <Pine.LNX.4.64.0802261312460.20165@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Feb 2008, Matt Roberds wrote:
> Disclaimer: I haven't tried it yet.

I tried it.  As is, you get (in part)

---
adt7475-i2c-5-2e
Adapter: SMBus nForce2 adapter at 1c40
1:         +0.00 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
2:         +3.24 V  (min =  +0.00 V, max =  +4.28 V) 
---

so I think the "in" constant is needed to turn these into standard
names.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

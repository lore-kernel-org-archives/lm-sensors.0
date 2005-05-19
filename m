From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Fwd: Fwd: [PATCH 2.6] bmcsensors
Message-Id: <20050331202909.6f23aff1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705033012523d671b5f@mail.gmail.com>
In-Reply-To: <2538186705033012523d671b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> We should write all this stuff down somewhere :-) (cc Greg, post
> in-line even over 40k, patch against latest mm etc) for newbies like
> me, unless I'm missing some existing documentation somewhere (I read
> the kernel documentation, Documentation/SubmittingPatches, and the
> lm_sensors porting_clients documentation, etc).

These rules are pretty much list- and area-dependent. I wouldn't send a
40k patch over LKML, but I wouldn't mind on the sensors list. Likewise,
submitting patches against the latest -mm sounds like a good default
rule, and is definitely the best choice for i2c, but for some other
areas different trees may be prefered. I'm not sure where we could write
down these rules for the hardware monitoring area. Thinks work rather
well already anyway.

-- 
Jean Delvare

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 19 Jun 2005 22:50:55 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <42B5DA98.6050906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> able ~ # i2cdump 0 0x48

Have you also Kryten ?

> I will have to recompile for this, and can't do it right now, when I get
> there I'll reply about this section...

Hmm it seems like lm75 compatible chip
Please prepare lm75 driver too.

To have all data do our puzzle, I would like to ask you also for:

i2cdump 0 0x2f

Thanks
regards

Rudolf

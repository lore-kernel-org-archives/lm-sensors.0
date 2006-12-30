From: juergh@gmail.com (Juerg Haefliger)
Date: Sat, 30 Dec 2006 12:17:07 +0000
Subject: [lm-sensors] vt1211 internal sensor
Message-Id: <191fb4ca0612300417s311d6760i13be2343eb1ecfb7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0612260635y1a161255qdeb540ce2e51abc9@mail.gmail.com>
In-Reply-To: <191fb4ca0612260635y1a161255qdeb540ce2e51abc9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

> I believe the CPU.
> Now: CPU Temp:  +21.1??C  (high =   +75??C, hyst =   +70??C)
> With 80% idle. load at 1.x., room temperature below 20 degrees.
> I do not believe vt1211.
> Other people have similar experience.
> What can we do now?

You better believe it. If you think about it, 40C is not that high.
The vt1211 itself doesn't have a heatsink and it needs to dissipate
some power. Put a finger on the chip and you'll notice it gets quite
warm.

...juerg


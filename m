From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Sep 2005 12:33:04 +0000
Subject: [lm-sensors] Query: debug lm78 not seen on ISA bus with 2.6.14-rc1
Message-Id: <gq9tv5CW.1126693459.5545870.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <tf8fi1t6oub8mes89vm567g6ipgjrm56pk@4ax.com>
In-Reply-To: <tf8fi1t6oub8mes89vm567g6ipgjrm56pk@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Grant,

> Still have problems with lm78 on 2.6.14-rc1.

I know why, but had no time to work on it lately. Please wait.

> If I do:
> # rmmod lm78
> # modprobe lm78 force_lm78=9191,0x290
>
> I get the same now:

Expected, the generic possibility to force ISA addresses was dropped from
2.6.14-rc1. The rationale was that this was making the i2c-core
needlessly complex. Force parameters will be added to individual ISA
drivers on a case-by-case basis, as forcing an address has a different
meaning depending on the device (legacy ISA, PCI subdevice or Super-I/O
logical device).

I'll try to find an acceptable workaround to automatically detect your
specific LM78 while still not putting other machines at risk. If I fail
we'll add a force parameter back into the lm78 driver so that you can
use it.

--
Jean Delvare

From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 23 May 2005 15:14:14 +0000
Subject: [lm-sensors] RE: lm_sensors
Message-Id: <vABIcmYM.1116853558.8001580.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dave,

> Kernel 2.4.20
>
> lm_sensor-2.6.5

Iik. These are old (over 2.5 year old!). If there's a bug in there,
chances are good that they have been fixed since. You should consider
trying a more recent version of i2c & lm_sensors.

> Was not exactly sure what you meant by what driver/hardware I am having
> problems with?

Motherboard manufacturer and model, and hardware monitoring chip name.
See the first line of the "sensors" output for the latter. Actually
the full output of "sensors" would be even more helpful. But, as I
said right above, your best chance is to try a more recent version of
our code.

--
Jean Delvare

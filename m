From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Wrong temperature readings
Message-Id: <20050414194116.43190f3a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <425D3645.1030500@algitech.com>
In-Reply-To: <425D3645.1030500@algitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

> > These messages don't come from our drivers. They are either from
> > ACPI or from CPU-specific MCE. Search the web for "Running in
> > modulated clock mode" and you'll find several references to your
> > problem.
> 
> I know, thats why I tried using sensors(1) to get the
> CPU/MB-temperature.
> 
> And there's the problem (if you look at the output from sensors(1)).
> All three sensors tell me about ~127 degres Celsius (260 Farenheit),
> and I doubt that thats the case.

I don't think that there is any thermal sensor connected to the W83627HF
chip. You must have another hardware monitoring chip for the
temperatures. Intel has an history of using LM85/ADM1027-compatible
chips.

The output of sensors-detect you provided shows that it didn't find any
PCI SMBus master. The lspci output reveals a 6300ESB, which is too
recent for lm_sensors 2.8.6. That explains it.

I don't know which kernel you are using, but if it is a recent 2.6
kernel (>= 2.6.7) you might try modprobing i2c-i801 and run
sensors-detect again (which should then find that
LM85/ADM1027-compatible chip - unless it is itself too new).

If you have an older 2.6 kernel, you'll need to upgrade.

-- 
Jean Delvare

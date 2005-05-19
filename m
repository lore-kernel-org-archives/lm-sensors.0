From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Gigabyte 8KNXP
Message-Id: <20040103221051.170b5364.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.53.0401031408180.10688@aurora.eexi.gr>
In-Reply-To: <Pine.LNX.4.53.0401031408180.10688@aurora.eexi.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The voltage readings as you can see are partially ok. -12 and -5 are
> obviously wrong. I did'nt spend more time for voltages, because i
> don't actually care much.

More often than not on recent systems, negative voltages are not used in
the system, and not wired to the sensor chip. I guess that you wouldn't
see them in your BIOS setup screen either. So you can probably ignore
them safely.

Maybe that's something we could add to our FAQ, since it's a quite
common issue.

> +5V:       +4.27 V  (min =  +4.72 V, max =  +5.24 V)   ALARM
> Stdby:     +1.50 V  (min =  +4.72 V, max =  +5.24 V)   ALARM

This is more strange and I can't explain it. Didn't you forget to run
"sensors -s"? Do you know which exact IT chip you do have?

> That is all i managed to find out. Could you please put that info in
> reply to my ticket as reference for other owners of the same
> motherboard ?

Done. Thanks for the information.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

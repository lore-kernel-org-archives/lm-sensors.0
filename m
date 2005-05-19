From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: tellerstats shell scripts from lm_sensors
Message-Id: <20040910084937.M62933@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4140888C.4060806@edgedesign.us>
In-Reply-To: <4140888C.4060806@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Floyd L. Davidson wrote:
> I've been playing with the scripts from tellerstats (version
> 1.9.2, according to the README me file) distributed with
> lm_sensors.  In particular, I have a Linux based system running
> on a Tyan S2462 motherboard with dual AMD Athlon CPUs.
> (...)
> differences.  An example of the graphs generated can be seen
> at
>
>     http://web.newsguy.com/floyd_davidson/stats/index.html
>

As a side note, it looks like you are using high fan clock divider values.
With such high speed fans you should not need to do so. You could try lowering
the fanN_div values to obtain nicer fan speed graphs (i.e. with smaller steps.)

-- 
Jean Delvare
http://khali.linux-fr.org/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <20030831090558.1d3e40d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have just installed i2c and lm_sensors from CVS because I thought
> that it might solve thr fan2 problem. I get only fan1 readout and not
> fan2, fan2 is 0 and should be around 2300. BIOS shows fan1 and fan2
> reading.
> 
> Fan2 readout is trough:
> it87-isa-0290
> Adapter: ISA adapter
> 
> Motherboard is:
> CHAINTECH 7VJL Apogee DeLuxe 
> Chipset: VIA KT400
> 
> Would you be so kind and check it out if it might be a bug or maybe it
> is a mobo issue.

It's a FAQ. You need to increase fan2_div (typically from 2 to 4) in
/etc/sensors.conf (it87-* section) and run "sensors -s" again, possibly
twice. Then "sensors" should report the correct reading. If not, try
increasing even more (8...).

> P.S. lm90 sensor is working great, readings are accurate:-)

Aha, you're using my driver. Great :) I had no feedback for it yet.
Could you please provide a sample sensors output, so that I can see how
it does look? Also, I'd be great if you could verify that limit
checkings are OK (simply set the limits in a way you know the readings
will be outside of them, and see is sensors reports alarms correctly.)
Thanks! If you find anything that would need fixing/tweaking in my
driver, please let me know and I'll take a look.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

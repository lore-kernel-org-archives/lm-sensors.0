From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jun 2007 18:42:16 +0000
Subject: Re: [lm-sensors] Change in reported CPU temperatures
Message-Id: <20070625204216.55987a1c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613223645.40f82f42.rkimber@ntlworld.com>
In-Reply-To: <20070613223645.40f82f42.rkimber@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 23 Jun 2007 15:05:48 +0100, R Kimber wrote:
> On Sat, 23 Jun 2007 14:46:57 +0200 Jean Delvare wrote:
> > Don't you have another hardware monitoring chip on the board? On an
> > Asus M2N-E, I'd really guess so. Probably an ITE or Winbond Super-I/O
> > with integrated sensors.
> 
> IT8716 reports temp1 as 42C, though I'm not sure what it relates to.

What thermal sensor type does "sensors" report? If a diode, that would
be the CPU temperature. If a thermistor, more likely the temperature in
the CPU socket.

> temp2, which I'm pretty sure is the MB, has remained around 34C
> throughout.
> 
> THRM seems permanently stuck on 40C.  It never ever changes.

Then you could try unloading (and blacklisting) the "thermal" module,
and see if it makes a difference.

> > Also, what temperature does the BIOS report? That would be an
> > interesting comparison point.
> 
> I thought of that, but concluded that there wasn't much point in
> looking, since the machine would be effectively idle and it does cool
> down very quickly after any load stops. shutting down and rebooting
> takes time.

False assumption. The CPU isn't necessarily idle while in the BIOS
setup screen. More often than not, it's in a busy wait loop, which is
equivalent to a moderate load as far as the CPU temperature is
concerned. For example, my CPU is running at 32 degree C in the BIOS,
but only 25 degrees C when idle under Linux. If I add CPU load under
Linux, then the temperature climbs to 32 degrees C - same as in the
BIOS.

> Unless there's a way of reading the BIOS while the machine
> is running??

No.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

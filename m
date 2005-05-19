From: horst.kretschmer@wincor-nixdorf.com (Kretschmer, Horst)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: AW: AW: LM-Sensors
Message-Id: <95EC70BD6869CC41A0089DC03DAE30BC011C442C@pdbh9a6e.wincor-nixdorf.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C61EE92.392A5D31@paradyne.com>
In-Reply-To: <3C61EE92.392A5D31@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

I have tested the "new" version and the result is better, but we can live
with the "old" version too.
I have attached sensors.conf and a display output for the "new" version.

Thanks and best regards

Horst Kretschmer 

-----Urspr?ngliche Nachricht-----
Von: Jean Delvare [mailto:khali@linux-fr.org]
Gesendet: Mittwoch, 16. Juni 2004 21:29
An: Kretschmer, Horst
Cc: Bervas, Elodie; Oelkers, Hans-Joachim; Duellings, Peter
Betreff: Re: AW: LM-Sensors


> I have tested -13V with lower values in sensors.conf with the
> following results:
> 
> sensors.conf    displayed    /proc/sys/....../in1
> -13
> -12.99          -13.22       2.42 2.55 2.52
> -12.98          -13.22       2.42 2.55 2.52
> ..
> -12.88          -13.22       2.42 2.55 2.52
> 
> -12.87          -12.88       2.44 2.55 2.52

Hmmm, OK. I get one part of the mystery. The native resolution of the
A-D converter is 0.0116V. It's slightly more than 0.01V, which means
that, with a magnitude of 2, some values cannot be represented. Among
others, 2.43V cannot be represented. This explains why the converted
value jumps from -12.88 to -13.22 directly (while you would at least
expect -13.05 inbetween).

Also, I just realized that there are four successive roundings when
setting a limit. libsensors has to round to the driver's magnitude, then
the driver rounds to an integer (register value), then you read the
value (with sensors), so conversions are done the other way around. For
most drivers, this isn't a problem because the ratio between register
values and exported values is "nice" (typical A-D converters have a
16mV/bit resolution) so the noise is limited. But the PC87366 has a
weird resolution and this probably adds noise to the conversions.

I think that using a magnitude of 3 for voltages should reduce that
noise and the driver should obey "sensors -s" better. Patch attached.
Could you please apply and test? If it improves the situation for you,
I'll apply to our CVS repository. Then we'll see if more is needed.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors_new.zip
Type: application/octet-stream
Size: 1167 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040617/4ba2833a/sensors_new.obj

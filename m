From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: It87 readings on Asus A7V8X-X
Message-Id: <20030914002320.64833173.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> CC to khali@linux-fr.org (lm-sensors team) because I think it might
> be of interest to him

Thanks :) (CC:ing the mailing list would have been even better).

> I found something more satisfying
> You need to load the it87 module with the option temp_type=0x1c 
> (explained in sensors.conf and the it87 readme file in the lm_sensors 
> package)
> Otherwise the readings are all wrong (-80?C etc. like you already
> noticed)

Yes, that's something rather common for the it87, as detailed in our
doc.

> Now I get something like:
> 
> Temp1/MB:    +52?C  (min =  +20?C, max =  +60?C)
> Temp2/CPU:   +39?C  (min =  +20?C, max =  +60?C)
> Temp3:       +86?C  (min =  +20?C, max =  +60?C)
> 
> Temp1 is actually cpu temp
> Temp2 = mb temp (value verified in bios)
> Temp3 = no idea

That too may vary from motherboard to motherboard. Edit
/etc/sensors/conf to fit your needs.

Is temp3 constant or not?

> Temp1 (cpu) is not accurate so I tried to calculate the deviation
> with simple 'rules of 3"
> Case open I got 48?C (sensor) and 56?C (bios), gives 7/6  ~ 1.166667
> Case closed I got 52 & 62 ~ 1.1923
> 
> So the actual value must be somewhere in between

You won't get accurate values that way. You should consider a possible
offset (that is, T[real] = K * T[measured] + offset). You'll consider
that T[real] is T[bios], while T[measured] is T[sensors].

From the two samples you give us, you'd get K = 1.5 and offset = -16.
More samples would be needed to confirm that. Remember that the noise is
very important when measuring temperature is these conditions (because
the CPU isn't idling the same way under linux and in the BIOS) so the
results may not be accurate anyway.

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

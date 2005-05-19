From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: ADM1030 Driver (+auto fan speed interface proposal)
Message-Id: <1081947812.407d36a4a9001@imp5-q.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081942629.407d22659307f@imp.gcu.info>
In-Reply-To: <1081942629.407d22659307f@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Jean Delvare <khali@linux-fr.org>:

> > > Let's compare with the ADM030 which has:
> > > 1* a temperature over which the fan starts spinning;
> > > 2* a range of temperature after Tmin for which the fan has variable
> > > PWM (this is another way to define Tmax);
> > > 4* a PWM value for 1*;
> > 
> > Actually, the (4*) item, when in automatic mode, define the minimum
> > speed at which the fan will rotate. Even if Temp < (1*)
> 
> This doesn't match the graph page 12 of the ADM1030-A datasheet. If I
> read it correctly, PWM (4*) applies if (1*) - 5 < T < (1*).

OK, just read back, it's clear. Sorry.

> 
> > I would just add a file to activate the automatic mode. (It is not
> > activated by default.)
> 
> fan1_auto_enable?
> 
> > and to select on which temp channel the automatic mode
> > reacts. (temp1, temp2, temp3 or max value of the three.)
> 
> I don't know if IT87 or Winbond chips can select that. I guess that
> "fan1_auto_temp_channel" would be a correct name?
> 
> Note that I don't have strong opinions on the names except that they
> must be standardized and self-expressive. The more important (and
> difficult) problem is to ensure that all known chips (and it possible
> future ones) will fit into the chose interface.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 


-- 
-------------------------------------------------
Alexandre d'ALTON
                              alex@alexdalton.org

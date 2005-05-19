From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: SE7500CW2 MB tested
Message-Id: <20021209125435.4f52ce2f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <032a01c29d38$e63a1210$6703000a@y3k>
In-Reply-To: <032a01c29d38$e63a1210$6703000a@y3k>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > I tested LM Sensors 2.6.5 on the Intel SE7500CW2 (ClearWater)
> > > mainboard (BIOS 1.16; Winbond*83627HF Management chipset) under
> > > RedHat 7.2 Linux Kernel 2.4.18. All work correctly, but it show
> > > CPU Temperature 127,5 C, Mainboard Temperature 59 C ...?
> > 
> > Does the BIOS give correct values for them?
> 
> Yes, BIOS give correct values.
> But may be in LM Sensors using table of coding not for P4 Zeon?
> 
> > Didn't you forget to run "sensors -s"?
> 
> I'v run "sensors -s", command "sensors" printing previous results.

OK, so the problem is real. Could you please download and test the
freshly released i2c/lm_sensors 2.7.0? Though I don't remember we
specifically fixed something for your system, maybe some other fix also
fixes that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

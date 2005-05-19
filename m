From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: Fw: , Re: SE7500CW2 MB tested
Message-Id: <20021209125131.5c0d27b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Begin forwarded message:

Date: Mon, 9 Dec 2002 14:05:22 +0300
From: "Michael V. Kachanov" <mikek@kraftway.ru>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: SE7500CW2 MB tested


> > I tested LM Sensors 2.6.5 on the Intel SE7500CW2 (ClearWater)
> > mainboard (BIOS 1.16; Winbond*83627HF Management chipset) under
> > RedHat 7.2 Linux Kernel 2.4.18. All work correctly, but it show CPU
> > Temperature 127,5 C, Mainboard Temperature 59 C ...?
> 
> Does the BIOS give correct values for them?

Yes, BIOS give correct values.
But may be in LM Sensors using table of coding not for P4 Zeon?

> Didn't you forget to run "sensors -s"?

I'v run "sensors -s", command "sensors" printing previous results.



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

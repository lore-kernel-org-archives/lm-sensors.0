From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 23 May 2005 13:11:34 +0000
Subject: [lm-sensors] Memory leak in sensors_get_label()
Message-Id: <y9c4V0c3.1116846189.7875430.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
In-Reply-To: <200505191529.j4JFTwG2024009@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi John,

> > Yes of course. Leaks are bad anyway, so let's kill that one. What tool
> > are you using BTW? sensord?
>
> No, we have a home-brew module that exports sensor information via
> SNMP.

Is there somewhere other users could download this module? We had several
users complaining about the lack of SNMP integration in lm_sensors,
maybe what you wrote could be of some help to them.

> I've given this a try, and it works without leaks.  It does change the
> output -- we have a section like this in sensors.conf:
>
>    label temp1       "CPU"
>    set   temp1_over  55
>    set   temp1_hyst  53
>
> Previously we would get "temp1_hyst" returned as a label; now we just get
> "temp1_low".  This isn't a problem for us; is it what you would have
> expected though?

Not really, I have to admit I am surprised, especially since I did not
modify that very part of the code. Could you please verify that the
patch itself, and not a version change (2.9.1 vs. CVS maybe?) causes the
change in the output? I know we did fix a number of low limit vs.
hysteresis name issues some times ago, this would more likely be related.

Also, we would need to know what kernel version you are using, and which
chip is used for hardware monitoring on this system.

--
Jean Delvare

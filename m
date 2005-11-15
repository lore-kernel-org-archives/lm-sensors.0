From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Nov 2005 20:17:37 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051115201801.59639bbb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

> From the above, if the driver returns the result ((REG << 2 + ADDREG) * 250)
> to the sensors user-space application, then you are OK with this?  The
> SENSORS.CONF file would then apply one of the two lines below to give user
> the temperature in degrees Centigrade.

Yes, I'm fine with that. I don't think we can do anything better.

> > BTW, does this suggest that you decided that the diode temperature would
> > be temp1, and thermistor-based ones are temp2+? I have no objection a
> > priori, just curious.
> 
> Nope.  I don't care which is which.  Really.  If there is a general trend
> for the CPU-0 temperature to be on a specific sensor then let me know and
> I'll make the driver match.

No, the general trend is to use the same order the device itself does
because it usually allows for some code optimizations, and makes it
easier when comparing the code and the datasheet. In the case of the
VT8231, none of this really applies anyway.

> If you can send me the results for the code review of the driver then I'll
> wrap these changes up into it and re-submit it.  Hopefully then it is
> complete.

Just done that :)

-- 
Jean Delvare

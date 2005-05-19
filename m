From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: SOLVED: I2C and lm-sensors : gentoo-sources 2.4.25 and your
Message-Id: <20040503215808.63e4b42d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405031037.51601.Manfred.Knick@T-Online.de>
In-Reply-To: <200405031037.51601.Manfred.Knick@T-Online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Manfred,

> P.S.:
> I'm sure you know that some people really depend upon 2.4 kernel
> series and can not easily switch to 2.6 where compatibility is gained
> again ?
> 
> E.g. for my G400 
> (which i still like for engineering - no fan, dual-head, ...),
> Matrox neither released a HAL module for 2.6
> nor is willing to publicate the HAL source openly
> so that users could do the maintenance themselves ...
> 
> So I really appreciate the intention mentioned by Jean Delvare at the
> bottom of his helpfol tutorial  [ http://khali.linux-fr.org/devel/i2c/
> ] :"We only make these patches available to the users to fill the gap
> between i2c-2.8.0 being released and compatibility being brought
> back."( I hope this is not meant to be understood as threatening with
> extinction ;-)

The original plan was to get the new i2c stuff into Linux 2.4 main line,
but Marcello let us understand that this was not going to happen. So
I'll be direct: there is no more plan to bring compatibility back at the
moment.

So the correct thing to do now would be to revert the changes we made so
that it is compatible with the 2.4 kernel again. Unfortunately, I have
neither the skills nor the time to do it. If anyone wants to help,
please let us know.

Sorry.

-- 
Jean Delvare
http://khali.linux-fr.org/

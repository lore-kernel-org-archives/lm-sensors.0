From: ashridah@icculus.org (Andrew Pilley)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: lm_sensors 2.8, linux 2.4.22, and a tyan tiger mpx (s2466n-4m)
Message-Id: <1063060753.4483.2.camel@mycrondo.mycronite>
List-Id: <lm-sensors.vger.kernel.org>
References: <1062646002.1248.7.camel@mycrondo.mycronite>
In-Reply-To: <1062646002.1248.7.camel@mycrondo.mycronite>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2003-09-08 at 03:36, Jean Delvare wrote:
> 
> The patch is unlikely to be the cause, because there have been very few
> changes between the 2.4.21 patch and 2.4.22 patch. What's more, the
> driver you talk about is part of lm_sensors, not i2c itself.

true. i only made the assumption because i *didn't* change the
lm_sensors side of the driver at all, it was still the 2.8.0 release.
i more or less assumed the problem was inside i2c-amd756, i guess.

> 
> I guess that you were using lm_sensors 2.8.0 with the 2.4.21 kernel, and
> that you are now using lm_sensors CVS with a 2.4.22? In this case, this
> simply means that a bug was introduced in the w83781d driver after 2.8.0
> was released, and tracking the changes using CVS should reveal it (I
> can't verify this right now, since I'm offline, but I will as soon as
> possible).

as i said, i haven't changed lm_sensors. I'll try updating to the cvs
head, and give that a shot, but the problem definently occured with
2.8.0. and 2.4.22

> 
> OTOH, if you are still using lm_sensors 2.8.0, trying CVS could help.

I'll give it a shot later on.

Andrew

-- 
I hereby pose this question for analysis. 
Are Microsoft users smarter than hamsters?
*Bluescreen* Reboot *Bluescreen* Reboot *Bluescreen* Reboot
Hamsters 1, Users 0.


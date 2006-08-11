From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 11 Aug 2006 19:30:57 +0000
Subject: [lm-sensors] Sensors are not working :(
Message-Id: <20060811213057.ce5f8c79.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060809112359.285100@gmx.net>
In-Reply-To: <20060809112359.285100@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Looks to me like a working bus, with nothing connected to it. What
> > makes you think that there is an LM82 chip connected? I know that some
> > AMD reference design has one, but other manufacturers don't have to
> > follow it.
> 
> Hi, my Friend has an DT168 Mini PC, but in fact an older Hardware revision 
> ... he got an LM82 Sensor!
> And his temperatures are working!
> 
> But in my DT168 (is a newer hardware revision) is not working ... Even in 
> the Bios the Temps are 0 Degree!
> But, WHY the firm says that an bios update would solve this? But there seems 
> no sensor?

We've already seen such cases on Asus motherboards. This was a
multiplexed SMBus and the BIOS was leaving it on the wrong branch. It
could be a similar problem, and if so, a BIOS update might indeed fix
it.

> > In fact it's OK that there is no second Access.bus. The CS5535 has only
> > one.
> 
> Is there possible to be another one?

Nothing on the SMBus, and supposedly nothing at all if sensors-detect
didn't find anything. You better check with the hardware manufacturer.
If the BIOS itself fails to display the temperature, it's unlikely we
will succeed without a hint from the manufacturer.

-- 
Jean Delvare


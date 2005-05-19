From: EmreTas@gmail.com (Emre Tas)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Sensors doesn't find any sensors, just eeproms.
Message-Id: <b25af0dc04100212106b5072c6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <b25af0dc04100121563c6b6567@mail.gmail.com>
In-Reply-To: <b25af0dc04100121563c6b6567@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So you mean there is no way to see rpm's and voltages...Thanks for yr
help abt that subject. Is it a cause of mainboard or another thing?
Again thank you very much for your info..


On Sat, 2 Oct 2004 09:07:13 +0200, Jean Delvare <khali@linux-fr.org> wrote:
> > I read everything and also try everything.I use kernel 2.6.8.1 on
> > slackware 10.0.I have an Sis M650 chipset.And mainboard of Asus
> > A2H/L.Yes this is a notebook.And I can figure only temperature by
> > using GKrellM.And also eeproms by sensors.What is wrong I don't
> > know.Also I am using the latest lm_sensors.Thanks anyway for your
> > help...
> 
> The temperature you get in GKrellM comes from the ACPI thermal zone.
> It's very common for laptops to have the temperature from ACPI, eeproms
> on the SMBus and no other hardware monitoring device. That's exactly
> what I have on my own (Sony) laptop. There's nothing surprising there.
> 
> --
> Jean Delvare
> http://khali.linux-fr.org/
> 



-- 
Nothing is impossible,just takes some times.

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <20031130152436.4fff1de9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130134504.142f7cde.khali@linux-fr.org>
In-Reply-To: <20031130134504.142f7cde.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > M/B and CPU temp are swapped. CPU is 39 and MB 28
> > 
> > I doubt it. It would be physically difficult to do this, unless the
> > monitoring chip is hardly tied to the CPU. This was never seen.
> > temp1(here displayed as "M/B Temp") is the monitoring chipset
> > internal temperature. 39 degrees is exactly what I have for a
> > similar chip here.
>
> No, the BIOS shows the temperatures *exactly* swapped

Strange. I'd be tempted to affirm that your BIOS is wrong. Please run
some CPU-intensive task (kernel compilation, cpuburn, whatever) and
see which temperature is raising. This is CPU temp.

BTW, which motherboard is that? The more I learn about Asus, the more I
think they are the worst brand when it comes to hardware monitoring. Not
releasing data sheets is a first thing, using the chipsets in a
completely wrong way is another. My next motherboard won't be an Asus.

> Also, fan1 is wrong. I use a thermaltake silent boost, it never
> reaches 3000 RPM

I'm clueless. What does the BIOS say about it?

> I'm not using a configuration file (2.6 kernel if that matters)

I seriously doubt it. You wouldn't have labels such as "M/B Temp". Take
a look, you probably have some (possibly old) /etc/sensors.conf file (or
wherever that is on your system). If you don't believe me, try "sensors
-c /dev/null" and you'll see what it really looks like without a
configuration file.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

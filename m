From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: [as99127f] - a note about measuring CPU temperature on Asus
Message-Id: <20030221100331.6d47a8bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302112308.19507@phoenix.camk.edu.pl>
In-Reply-To: <200302112308.19507@phoenix.camk.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Again, thanks a lot for the precious information you gave us. I'm going
to add one more quotation to the config file.

Maybe Phil or Mark will want to tweak the driver to handle negative
values correctly, or maybe not, I leave it to them.

> On Thursday 20 February 2003 09:46, Jean Delvare wrote:
> > > Yes, temp3 @*2.0 was good. It gaves me ~+2?C for a water-snow
> > > mixture, and ~+35?C for my fingers. I did not measure the
> > > temperature of a boiling water, but I plan to do so :-)
> > Right, sounds good
> 
> I put the probe into boiling water, and I got 97,4?C - quite good
> value. Here are temperatures plotted against time:
> 
> http://www.camk.edu.pl/~gawrysz/boil.png (14kB, 1302?681)
> 
> Solid lines are something like "average in near history".
> 
> > > It seems that temperatures slightly below 0?C produce measurements
> > > about 255?C. I guess, that something what should be signed is
> > > unsigned. I think it may be interesting to check it with
> > > water-salt-ice solution or ethyl alcohol cooled well below 0?C. I
> > > think I'll try to do it someday :-)
> > Well, let us know, but actually I don't think it is an important
> > issue to have correct values below 0?C, since any system will hardly
> > be working there.
> 
> Of course It's hard to cool CPU below 0?C, but the probe can be used
> for many other purposes :-) For melting salted water I got on average 
> -18.8?C (measurements were in the range from -22?C to -16.6?C). It's 
> good, when compared to -21.2?C - a critical tempreature for such 
> solution. My formula was 
> temp3 @*2.0 (in sensors.conf)
> if (temp3>"4.4) temp3-%6 (in a script, that logged the data)
> Here you can see a graph:
> 
> http://www.camk.edu.pl/~gawrysz/salt-ice.png (18kB, 1302?681)
> 
> The value of 224.4 is the readout with probe unplugged (checked for 
> CUV4X, A7V and A7V133).
> 
> > > I guess, that the formula "temp2 (@*30/43)+25, (@-25)*43/30" is
> > > correct for those Asus motherboards, which get CPU temperature
> > > from internal thermal diode (Pentium Coppermine, and above), and
> > > "temp2@*2.0, @/2.0" is correct for Athlon/Duron boards, which use
> > > a thermistor in the socket.
> > Very valuable information, thanks a lot. I am going to add this in
> > our configuration file, with your permission. It's better than
> > listing the known boards names, since the list will be incomplete by
> > nature. I guess that people always know wether they have an Intel or
> > AMD system.
> 
> Things may be a bit more complicated, since newer AMD CPU's (AFAIK 
> Athlon XP models 6 and 8) have internal thermal probe (a diode). I 
> don't know which boards takes care about it, but on some of newer ones
> 
> it may be possible to obtain thermal data from both the Athlon CPU 
> diode and the thermistor in socket.
> 
> -- 
> Greetings,
>         Artur
> 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

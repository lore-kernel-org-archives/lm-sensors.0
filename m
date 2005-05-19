From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: [as99127f] - a note about measuring CPU temperature on Asus
Message-Id: <20030220094624.28c1e5cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302112308.19507@phoenix.camk.edu.pl>
In-Reply-To: <200302112308.19507@phoenix.camk.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Yes, temp3 @*2.0 was good. It gaves me ~+2?C for a water-snow mixture,
> and ~+35?C for my fingers. I did not measure the temperature of a 
> boiling water, but I plan to do so :-) 

Right, sounds good

> It seems that temperatures slightly below 0?C produce measurements
> about 255?C. I guess, that something what should be signed is
> unsigned. I think it may be interesting to check it with
> water-salt-ice solution or ethyl alcohol cooled well below 0?C. I
> think I'll try to do it someday :-)

Well, let us know, but actually I don't think it is an important issue
to have correct values below 0?C, since any system will hardly be
working there.

> I guess, that the formula "temp2 (@*30/43)+25, (@-25)*43/30" is
> correct for those Asus motherboards, which get CPU temperature from
> internal thermal diode (Pentium Coppermine, and above), and "temp2
> @*2.0, @/2.0" is correct for Athlon/Duron boards, which use a
> thermistor in the socket.

Very valuable information, thanks a lot. I am going to add this in our
configuration file, with your permission. It's better than listing the
known boards names, since the list will be incomplete by nature. I guess
that people always know wether they have an Intel or AMD system.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: sensors.conf hint
Message-Id: <20030220095123.336611a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030219214848.GA1084@debian>
In-Reply-To: <20030219214848.GA1084@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> How do you know what is the 'correct' temperature?
> (And where does that formula originally come from?
> Is it simply an empirical formula someone came up with?)

No, they depend on resistor combinations used and are theorical values.

Quoting Artur Gawryszczak:
"I guess, that the formula "temp2 (@*30/43)+25, (@-25)*43/30" is correct

for those Asus motherboards, which get CPU temperature from internal 
thermal diode (Pentium Coppermine, and above), and "temp2 @*2.0, @/2.0" 
is correct for Athlon/Duron boards, which use a thermistor in the 
socket."

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

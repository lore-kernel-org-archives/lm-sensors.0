From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: no FAN3 available
Message-Id: <20030913230200.3f87e173.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309011224.08300.martin@martin-fernau.de>
In-Reply-To: <200309011224.08300.martin@martin-fernau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> thanks for your answer. I've checked the manual of my mainboard about
> the winbond chip. On the graphic I can only see one W83697HF Chip. No
> second chip which can monitor the third FAN.

I recently contacted MSI about another motherboard, asking them if it
had a secondary monitoring chip. I knew it had. They told it had not. I
told them I knew it had. They told I were wrong...

Don't trust docs. Don't trust support. These are hints at best, but only
solely the truth.

> But if I go into my BIOS I can see the system fan-speed too.

So the secondary chip has to exist.

> I've just downloaded the newest sensors-detect script and unloaded all
> i2c devices. After this, I started the sensors-detect script and go
> through the installation process. I've append the output of the script
> to this mail. I'll be very glad if you have the time and could help me
> to get the third FAN working.

See below.

> Maybe I try to
> connect the system-fan to the FAN2 input on my mainboard.

If you don't use the FAN2 input, yes, why not.

> Thanks for your effort.

You're welcome.

> Client found at address 0x18
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `Onsemi MC1066'... Failed!
> Probing for `National Semiconductor LM82'... Failed!
> Probing for `National Semiconductor LM83'... Failed!

There is something there. Something we don't know yet, but it's there.
Please provide the output of "i2cdump 0 0x18" (make sure i2c-viapro is
loaded). (I got the strange feeling that I *already* asked you for that
output... Please forgive me if this is the case).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

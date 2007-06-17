From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sun, 17 Jun 2007 15:13:05 +0000
Subject: Re: [lm-sensors] Quick Question about latest IBM thinkpads!
Message-Id: <20070617151305.GB17379@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <524002.68161.qm@web82504.mail.mud.yahoo.com>
In-Reply-To: <524002.68161.qm@web82504.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 16 Jun 2007, leon moss wrote:
> I was just wondering if the lm-sensors will still
> break the latest IBM thinkpads I am thinking about
> getting a T61. I remember all of the other issues that
> have been reported from other thinkpad users at
> earlier models but I just wanted to see if you may
> have known about the new T61's.

Don't run sensors-detect on thinkpads, all you will find *IF* you are very
lucky, is the clock generator (*never* mess with it) and the SPD eeproms in
the RAM modules (dmidecode will tell you all about your RAM in a thinkpad,
anyway).

All of a recent thinkpad's sensors are not reachable by the main CPU.  Use
the ibm-acpi/thinkpad-acpi and tp_smapi drivers to talk to them.  And if you
did not do it yet, go to http://thinkwiki.org to learn about your thinkpad
and its drivers.  There is not much on the T61 in there yet, so feel free to
help improve it.

Thinkpad-acpi will export the sensors through the hwmon layer in 2.6.23,
btw.  I'd imagine lm-sensors userspace will be able to talk to it, then.

Just don't do sensors-detect on a thinkpad. It is useless, although AFAIK it
won't touch the broken vital-product-data eeprom that bricked thinkpads
anymore.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

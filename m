From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040111215628.4532c895.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Writing a 1 to the bit so that it is reset is a strange idea, isn't
> > it?;)
> 
> Well, how would you indicate the bit to clear otherwise?

Sure, I agree. Just found it strange at first, but that's the correct
way.

> > I don't see any difficulty here. They are in0, in1 and in2. We never
> > give names to the channels, only number. Labels are set with
> > sensors.conf.
> 
> Ok, so everything is like before, besides the values beeing unscaled.

Correct. Please consider updating the 2.4 driver in a similar way once
you're over with the 2.6 driver, so that the same sensors.conf works
with both versions.

> BTW: I'm not on the ML.

Want to be?

> Ok, but then I should complete the output of sensors for fscher and
> also include alarms and watchdog.

You wanted to do so anyway, DIDN'T YOU? ;)

> > You like reading and writing to /proc files directly, don't you? ;)
> 
> Maybe, I was just to lazy to look for a different solution. From
> coding the module, I knew that it would work that easy ;-).

Adding a few lines to sensors.conf isn't that difficult, really. I'd
even find it easier than setting up a startup script that echoes values
to /proc files. But that's a matter of taste I guess.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

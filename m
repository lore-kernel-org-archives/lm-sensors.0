From: r.marek@assembler.cz (Rudolf Marek)
Date: Wed, 10 Jan 2007 22:34:50 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <45A56A0A.3060907@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I agree, it's not handled properly; let's make it better. I see 3
> possibilities:
> 

Yes I proposed similar, but nobody noticed that :)

> 1* We display the sensor type in "sensors". This is what we do for the
> IT87xxF devices. When the sensor type is "disabled", the user should
> realize that the reading is meaningless.
> 
> 2* We change sensors to not even display tempN if that sensor is
> disabled. This is probably even more user-friendly.

You mean during init phase?

> 3* We change the w83793 driver to not present the temperature value
> when the sensor is disabled. A bit more difficult, but doable. There's
> something of this kind done in the f71805f hardware monitoring driver.

Yes but we need to keep the control file for that.

> A combination of 2 and 3 sounds best to me. Gong, what do you think?

I like it. Do not create tempX_input files for disabled channels, but create 
channel mode files. When enabled the tempX_input will appear.

Rudolf


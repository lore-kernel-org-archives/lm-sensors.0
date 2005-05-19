From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: flex scanner jammed problem
Message-Id: <20030924201133.10bef166.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > What is synaptic?
> 
> a frontend for apt. very nice. try it and you'll never give it away!

I admit I could have guess that (syn-apt-ic after all). But since I
don't use apt anyway...

> > > I could set up my sensors.
> > > But since I did that the KDE process window does not work any
> > > more, ksysguardd and ksensors gave me "flex scanner jammed".
> > 
> > Which means that sensors itself doesn't work. Am I right?
> 
> Somehow... But sensors works...

So the answer is not "somehow", it is "no, you're wrong".

Then, I guess that ksysguardd and ksensors use their own configuration
files?

> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.50 V  (min =  +1.32 V, max =  +1.47 V)       ALARM
> (...)
> vid:      +1.400 V

Your vid reading could be wrong, try changing vrm in the config file.

> Adapter: saa7134[0]
> Algorithm: saa7134

What's that thing?

> > This is a known problem, which has two possible solutions:
> > 
> > 1* Fix your /etc/sensors.conf file. Copy the default
> > etc/sensors.conf.eg file that match the version you're using, and it
> > should be OK.
> 
> I tried... and runned sensors -s. Didn't help.

What if you plain delete the config file?

> > 2* If it doesn't work, update to 2.8.0 or CVS, we fixed a bug in the
> > parser some weeks ago.
> 
> I'm using 2.8.0

Try CVS then <grin> (just kidding, although it may actually give
results).

> > "Writing to fan values" makes no sense ;) You already should be able
> > to write to the min settings. As for the speed control, it is known
> > as PWM. It *is* supported by our w83781d and w83627hf drivers (one
> > of which you must be using), although it is known not to work
> > properly for everyone. See the prog/pwm in our package, where you'll
> > find the fancontrol and pwmprogram. These are the ones you need in
> > order to have PWM working. Give it a try and let us know how it
> > works for you.
> 
> Ok, in the meantime, I'm running varyfan very succesfully... PWM works
> nice.

I did not know about that program, thanks for the information. I am
going to add a link on our useful addresses page. I wonder if it offers
something the programs included in our package don't.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: DarkEmperor@gmx.net (Emperor)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: flex scanner jammed problem
Message-Id: <1064516265.3814.12.camel@nils>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Don, 2003-09-25 um 19.44 schrieb Jean Delvare:
> > > I admit I could have guess that (syn-apt-ic after all). But since I
> > > don't use apt anyway...
> > 
> > hey you should ;) great thing! easy to manage... simply search for
> > package lm_sensors and click on install, and soon your jammed your
> > flex scanner ;)
> 
> I use Slackware. Ease to manage too ;) OK, OK, I'll give a try to Debian
> someday.

no I'm running redhat, you can use apt on any rpm platform.

> 
> > > Your vid reading could be wrong, try changing vrm in the config
> > > file.
> > 
> > I did, now the values are right:
> > 
> > w83627hf-isa-0290
> > Adapter: ISA adapter
> > Algorithm: ISA algorithm
> > VCore 1:   +1.52 V  (min =  +1.44 V, max =  +1.60 V)
> 
> Yup, that one is OK.
> 
> > VCore 2:   +1.69 V  (min =  +1.44 V, max =  +1.60 V)
> 
> Is this value changing? If you have a single-plan CPU, this value
> doesn't make sense and you should add an "ignore in1" statement to you
> config file.
> 
> > fan1:     2045 RPM  (min = 1500 RPM, div = 4)
> > fan2:     1599 RPM  (min = 1500 RPM, div = 4)
> > fan3:     1339 RPM  (min = 1500 RPM, div = 4)
> 
> Your fans are running really low. A least, I guess your computer is
> really quiet :)
> 

yes it is. fan1 is a zalman and the other are papsts.

> > temp3:     +71.0C  (limit =  +60C, hysteresis =  +50C) sensor > > thermistor   ALARM
> 
> That's quite high, maybe you should invest in higher-speed fans.
> 

I thin 70 ~71 for cpu core is normal for a p4. I read this in their
spec. I tried to have this value below 70 C, but it simply won't go,
also with running my fans at higher speed. the cpu temp is around 45 C.

> > > > Adapter: saa7134[0]
> > > > Algorithm: saa7134
> > > 
> > > What's that thing?
> > 
> > it's my Terratec Cinergy 400 TV tuner card. I kicked it from the
> > lm_sensors file. didn't change anything.
> 
> The sensors program doesn't know a thing about it, so I wonder why it is
> showing there. Will take a look someday.
> 
> > > What if you plain delete the config file?
> > 
> > Then ksensors and ksysguard work! So they use the same config file...
> 
> Good thing to know. Then, my analysis is that you have two different
> versions of libsensors on your disk. One old for ksensors/ksysguard, and
> one new for sensors. Running ldd on these binaries should confirm that.
> In that case, you should use a configuration file that work for both
> (which means,: that work for the old library, since the new library is
> already OK). To do so, either strip your current file so that it only
> contains the w83627hf-* section (you just don't care about the others),
> or get etc/sensors.conf.eg from lm_sensors-2.7.0 or older, until it's
> OK.
> 

aha aha... I could also look for the files and try to delete the old
version, too, couldn't I?

> > > > Ok, in the meantime, I'm running varyfan very succesfully... PWM
> > > > works nice.
> > > 
> > > I did not know about that program, thanks for the information. I am
> > > going to add a link on our useful addresses page. I wonder if it
> > > offers something the programs included in our package don't.
> > 
> > I didn't try them out, you can specify temperatures, fan speed,
> > slowdown speed... it was right what I needed.
> 
> Would you have some time to give them a try and tell us how they behave
> compared with varyfan? I'd appreciate that.

I'll give a try.

> 
> Thanks.

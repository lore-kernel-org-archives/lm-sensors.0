From: brianpap22@yahoo.com (Brian Papantonio)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: 'sensors' never installed
Message-Id: <20030617154404.14084.qmail@web40804.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030615132841.54681.qmail@web40809.mail.yahoo.com>
In-Reply-To: <20030615132841.54681.qmail@web40809.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

because...

[root@localhost as99127f-i2c-0-2d]# cat < temp1 temp2
temp3
60.0 50.0 22.0
60.0 50.0 112.2

it "eats" the output for the first value! don't ask me
why, I am a linux noob. So I just wrote 'temp1' twice
to be used as a dummy value. it means nothing.

Anyway...

I agree that temp1 is the motherboard temp in C. It
agrees nicely with what the hardware monitor in my
BIOS setup program displays. It also agree with the
fact that temp1 computation doesn't exist in the
sensors.conf file which has proven to be useless
anyway.

For the processor, the BIOS program reports 58C/136F
with case and HeatSink/Fan set to low. The minimum
i've seen in the BIOS is 46C/114.5F with side door
removed and proc/case fans set to highest. temp3 MIGHT
have been close as F, EXCEPT for the fact that I just
noticed it NEVER moves. I don't have any idea where it
comes from. Temp2 is active, and SEEMS to be the
processor, however, the original output of "26.0" or
"22.0" is obviously miscalculated.

I think using that information, at the very least I
should be able to interpolate the final values, but
depending on the computation used to obtain "22/26",
it may not be very accurate since when dealing with
temperature, the value/starting point of 0 you would
use when comparing two sets of values is meaningless,
especially since I don't know if "22/26" is C, F, or
neither.

I am going to use this value in a perl script I
downloaded that displays the temp and fan stats on an
LCD module mounted to the front of the computer (fun
picture: http://12.203.238.243/lcd.jpg ). Since it is
a perl script, I can edit the appropriate lines to to
a "post-convert" on the temp2 value, as the program
does not output the value of temp2 directly. However,
the temp2 value must be the result of some calculation
that is completely unknown to me. Do you think you
might be able to figure out what the raw value should
be, so we can take it from there? Or is "22.0" the raw
value? (See 'useless info' section for specifications
on my computer, which should give you an idea of what
the value might be)

For your enjoyment <g> I have included a quasi-random
sample of outputs from temp1/temp2/temp3 (quasi
because whenever there was not change yet I didn't
copy it again, and these are not even close to even
intervals):

WARNING: yes this is overkill!! feel free to skim/skip
it. The executive summary is that when I pumped up the
processor's HS/F, temp2 went down, followed by temp1
immediately going UP, at which time I opened the case
door and turned up the case fans to high, and then
both temperatures dropped from there, so you can just
skim the following:

############## BEGIN USELESS INFO ###############

NOTE: in the previous e-mail I incorrectly stated my
mobo as A7V-266-E, when it is actually A7V-133-C. My
Windoze computer is the A7V-266-E. Same sensor chip
for both, so it doesn't change anything.

Duron 1.1ghz, Asus A7V-133-C, Thermaltake Volcano 9,
Lian-Li PC-69 aluminum.
Server: contains one 7200rpm HD, one AGP vid card
(only use console, no GUI), one NIC, and an LCD that
runs off the serial port.
Last but not least, a 275w PC Power & Cooling PSU.
That is it! Very empty indeed!

THE POINT IS THIS CASE RUNS COOOOOOOOOOL.

..except for the fact that my other 1.4Ghz Athlon
with 1280mb PC2100, Geforce4 128mb, WD Special, a
couple more HDs and a mess of other stuff is stitting
right next to it, runs HOT, at IDLE: 64C/147F proc and
27C/80F mobo with the case open. The room temperature
is around 79F.
see http://12.203.238.243/computers.jpg for a fun
picture :)


==At idle for days, case fans on low, proc HS/F at
low (~1700rpm)=
[root@localhost as99127f-i2c-0-2d]# cat < temp1 temp1
temp2 temp3
60.0 127.0 33.0
60.0 50.0 27.5
60.0 50.0 112.2

==Proc fan turned to high (~5800rpm)==

]# cat ...
60.0 127.0 34.0
60.0 50.0 27.2
60.0 50.0 112.2
]# cat ...
60.0 127.0 34.0
60.0 50.0 27.0
60.0 50.0 112.2
]# cat ...
60.0 127.0 34.0
60.0 50.0 26.5
60.0 50.0 112.2
]# cat ...
60.0 127.0 35.0
60.0 50.0 26.2
60.0 50.0 112.2
]# cat ...
60.0 127.0 35.0
60.0 50.0 26.0
60.0 50.0 112.2
]# cat ...
60.0 127.0 35.0
60.0 50.0 25.7
60.0 50.0 112.2
]# cat ...
60.0 127.0 35.0
60.0 50.0 25.5
60.0 50.0 112.2
]# cat ...
60.0 127.0 36.0
60.0 50.0 24.5
60.0 50.0 112.2

==Turned case fans to high, removed side door.=
]# cat ...
60.0 127.0 36.0
60.0 50.0 24.0
60.0 50.0 112.2
]# cat ...
60.0 127.0 35.0
60.0 50.0 24.0
60.0 50.0 112.2
]# cat ...
60.0 127.0 35.0
60.0 50.0 23.5
60.0 50.0 112.2
]# cat ...
60.0 127.0 35.0
60.0 50.0 23.2
60.0 50.0 112.2
]# cat ...
60.0 127.0 34.0
60.0 50.0 23.0
60.0 50.0 112.2
]# cat ...
60.0 127.0 34.0
60.0 50.0 22.5
60.0 50.0 112.2
]# cat ...
60.0 127.0 33.0
60.0 50.0 22.5
60.0 50.0 112.2
]# cat ...
60.0 127.0 33.0
60.0 50.0 22.0
60.0 50.0 112.2
[root@localhost as99127f-i2c-0-2d]# cat < temp1 temp1
temp2 temp3
60.0 127.0 33.0
60.0 50.0 22.0
60.0 50.0 112.2
==Steady temp=
############## END USELESS INFO #################

Thank you for coming this far.

My method of "installing" lm_sensors-2.7.0 was what
was in the QUICKSTART file in:

http://www.lm-sensors.nu/archive/lm_sensors-2.7.0.tar.gz

"Quickstart for i2c option 1 (modules) and lm_sensors
option 1 (modules).
This is the recommended EASIEST METHOD."

No doubt I screwed it up.

Hopefully, you will be able to tell me some possible
formulas to try with that "raw" temp2 value so it is
represented in a degree format I can use.

Also, since sensors.conf is useless, I suppose the
answer to this question is "You can't" also: At fan
speed set to lowest, fan2 (the only fan showing
anything) is 0. At max it shows:

[root@localhost as99127f-i2c-0-2d]# cat < fan2
3000 5487

Anything below ~2600rpm shows 0 (when it does show a
value, it is exactly what the mobo would report in the
BIOS's hardware monitor). If this cannot be fixed, no
biggie. The processor temperature is my main concern,
as I generally do NOT have any computer monitor hooked
up to the video card (I may even remove that), so I
have to rely on this program to report the temperature
to me.


Again, thank you for reading this entire e-mail (or
most of it). Any more info you request will be
availible to you. I look forward to hearing from you.

Thanks,
Brian




--- Jean Delvare <khali@linux-fr.org> wrote:
> 
> > I installed i2c-2.7.0 and lm_sensors-2.7.0, and
> > "values" are reported in
> > /proc/sys/dev/sensors/as99127f-i2c-0-2d/
> "properly",
> > but they are way off:
> > 
> > ]# cat < temp1 temp1 temp2 temp3
> > 60.0 50.0 33.0
> > 60.0 50.0 27.0
> > 60.0 50.0 112.2
> 
> What a strange command. What were you trying to do?
> (I mean, "cat temp1
> temp2 temp3" does just the same, so what's the big
> idea?)
> 
> > those are in deg C, right? temp1 seems to be ok
> > assuming it is the mobo. I dunno what the hell
> temp2/3
> > are supposed to be.
> 
> They do not have to be in deg C. They can happen to
> be, and actually I
> believe temp1 is, in your case. But temp2 and temp3
> are probably not.
> What you get in /proc/sys/dev/sensors are raw
> readings. You have to use
> the formulae in /etc/sensors.conf (or, more
> commonly, let libsensors do)
> in order to get them in deg C.
> 
> > I try editing /etc/sensors.conf, but no changes to
> > compute temp2/temp2 have any effect. i try to do
> > "sensors -s" but it says "command not found"--it
> never
> > got installed (I cant find it anywhere on my
> system).
> 
> Logical. The /etc/sensors.conf has no effect on
> /proc/sys/dev/sensors
> values. You have to use an application that itself
> uses libsensors to
> see the effects of any change done on the file.
> 
> > Something tells me that getting 'sensors'
> installed
> > will be a bitch, so is there a way to "manually"
> > update the compute line in libsensors somewhere?
> 
> You simply cant.
> 
> > it must be stored somewhere, because I restart the
> > computer, and the values for temp1/2/3 never
> change,
> > so the sensors.conf file must not be being
> reloaded
> > (it is set to startup, which works).
> 
> Raw values don't even care about the config file.
> 
> You have to get the sensors file. You did not tell
> us how you installed
> lm_sensors, but I guess it comes from a package
> designed for your
> distribution. You should look for other packages,
> there *must* be one
> that provide sensors (because the drivers aren't
> useful to anything if
> you can't issue a "sensors -s" at startup).
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/




__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com

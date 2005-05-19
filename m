From: Rudolf.Bernatzky@plg.de (Bernatzky Rudolf)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: AW: lm-sensors support for ASUS chip ASB100 Bach
Message-Id: <795E03B0F1E26C449762C0EDF5F56591492855@Exchange.16.172.in-addr.arpa>
List-Id: <lm-sensors.vger.kernel.org>
References: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
In-Reply-To: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:
Finally I could install the lm-sensor packet 
It took such long because first I had hardware different from what I was told.
I actually have Intel P4B533 Board with I801 SMB and ASB100 Sensor.
Second the ASUS chip couldn't be recognized on the PCI bus.
With the help of my friend Ingo Haas who applied the hack described in your ticket #1155 we could finish the installation.
After doing: (in this sequence)
	insmod p4b_smbus.o   
	modprobe i2c-i801   
	modprobe i2c-dev   
	modprobe i2c-proc
	modprobe i2c-core      
	modprobe w83781d 
the ASUS chip is correctly recognized as
AS99127F (w/o any force parameter) and the sensors response is as follows:

< as99127f-i2c-0-2d
< Adapter: SMBus I801 adapter at e800
< Algorithm: Non-I2C SMBus adapter
< VCore 1:   +1.56 V  (min =  +1.28 V, max =  +1.40 V)              
< VCore 2:   +1.55 V  (min =  +1.28 V, max =  +1.40 V)              
< +3.3V:     +3.26 V  (min =  +3.13 V, max =  +3.45 V)              
< +5V:       +5.02 V  (min =  +4.72 V, max =  +5.24 V)              
< +12V:     +11.29 V  (min = +10.79 V, max = +13.19 V)              
< fan1:     2280 RPM  (min = 1500 RPM, div = 4)                     
< fan2:     3245 RPM  (min = 3000 RPM, div = 2)                     
< fan3:     6716 RPM  (min = 6000 RPM, div = 1)                     
< temp1:       +29?C  (limit =  +60?C)                              
< temp2:     +32.0?C  (limit =  +60?C, hysteresis =  +50?C)        
< vid:      +1.350 V
< alarms:   
< beep_enable:
<          Sound alarm enabled

I finally did some cosmetics to the "sensors.conf" file - blanking unused sensors
and correcting the temp2 values. 
The LM-Sensor Software seems to work fine now. 
I did not modify the W83781D driver, only the "sensors.conf" file which I attached for your information. I also appended a lot of spec information to this file about chip registers and their settings. If somebody needs more details, feel free to contact me.
I thank you for your help. Regards

Rudolf Bernatzky
PLG AG - Abt. SOFTRON
Lise-Meitner Str. 3-5
86156 Augsburg
Tel.:   0821-4086-142
Fax:    0821-4086-111
E-Mail: rudolf.bernatzky@plg.de


-----Urspr?ngliche Nachricht-----
Von: Mark M. Hoffman [mailto:mhoffman@lightlink.com] 
Gesendet: Sonntag, 13. April 2003 21:01
An: sensors@Stimpy.netroedge.com
Cc: Bernatzky Rudolf
Betreff: Re: lm-sensors support for ASUS chip ASB100 Bach

Hello:

* Jean Delvare <khali@linux-fr.org> [2003-04-10 13:53:41 +0200]:

> The Asus ASB100 is seen as a modified AS99127, which itself is handled
> by our W83781D driver. So, the file to modify is definitely "w83781d.c".
> On the other hand, since the drivers are actually incorporated into the
> Linux 2.5 kernel tree, working on them these days may be tricky. But if
> we can make things work better, even on "temporary code", it won't be
> lost.

Correct.

* "Bernatzky Rudolf" <Rudolf.Bernatzky@plg.de> [...]:

> > Alternatively I could generate a list of chip features with functions
> > and address offsets and command code. With the latter alternative I am
> > unsure with regard to the legal aspects. What do you think?

I think (but I'm not certain) that most of the problems with 
Asus support are for actual AS99127.  As written, ASB100 works
well enough for me.  I've heard some Athlon owners found another
register that gives better CPU temps, but I haven't seen a patch
for it.

Rudolf, don't be afraid of the code!  Since you have the docs,
you're way ahead of the rest of us.  You can send patches to
sensors version 2.7.0 or from latest 2.5 kernel.  Either way,
I can test them and then take over from there.

> I'm no law specialist, for sure. From a technical point of view, it
> seems to me that it would be far easier if we could get access to the
> whole information. But I don't know if we (the LM Sensors dev team) are
> supposed to accept signing NDAs or not.

<offtopic>
Why would anyone be willing to assume liability just for the
privilege of supporting someone else's product, for free?
There's no way I would ever sign an NDA unless it's paid work -
and even then it depends on the terms.
</offtopic>

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensorsconf.zip
Type: application/x-zip-compressed
Size: 4215 bytes
Desc: sensorsconf.zip
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030513/7a08c692/sensorsconf.bin

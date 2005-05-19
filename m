From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors SiS730
Message-Id: <3BF5B676.746426CF@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
In-Reply-To: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I saw the mail, Phil has been copying 'sensors'.

What you mean is that you are real close to having the it87 support
working on your SiS 730 motherboard by adjusting sensors.conf entries.
You are accessing the it87 chip on the ISA bus.

What's totally different - and what hasn't started yet - is
support for the i2c bus master on the SiS 730 chip. That's what I
was clarifying.

A while ago, someone snarfed stuff out of the ASUS PROBE for as99127f
support.
Asus is generally unresponsive to any requests.

mds



Bob Ramstad wrote:
> 
> Hey, Mark.  Thanks for the email.
> 
> I think you might have missed my summary of info posted to the list
> based on stuff Phil gave me offline + my experimentation.
> 
> The existing code for the it87 seems to read some of the appropriate
> data -- I see changing fan speeds, changing temperatures, changing
> voltages, etc.  My best guess is that with an additional sensors.conf
> setting and a little it87 tweaking that this could be fully supported.
> 
> So, yeah, there's nothing in the BIOS that prevents getting this data,
> and the 5595 ID internal to the 730 seems like a total red herring.
> All that said, I think we're real close to having the SiS 730
> supported.
> 
> Total newbie question -- has anyone considered trying to disassemble
> the ASUS PROBE Windows program to snarf parameters out of it for
> sensors.conf?  How about contacting ASUS or one of the other m/b mfrs
> directly rather than trying to deal with SiS?  There might be a m/b
> mfr with a good US presence that would be able to help.  Dunno, just
> thinking out loud...
> 
> -- Bob
> 
>    Date: Tue, 13 Nov 2001 16:39:40 -0800
>    From: phil@netroedge.com
>    Content-Type: text/plain; charset=iso-8859-1
>    Content-Disposition: inline
>    User-Agent: Mutt/1.2.4i
>    X-MIME-Autoconverted: from 8bit to quoted-printable by alum.mit.edu id TAA09294
>    X-MIME-Autoconverted: from quoted-printable to 8bit by banta-im.com id TAA20251
>    X-UIDL: SDm!!QO+!!#hH!!-R7"!
> 
>    My temps are all over the map.  They seem to be related to the
>    temperature, but they go from negatives to large positives often.  I
>    haven't bothered to check out the datasheet and the code yet to see if
>    there is a bug, or if it is a hw implementation specific issue.
> 
>    Phil
> 
>    On Tue, Nov 13, 2001 at 04:07:05PM -0800, Bob Ramstad wrote:
>    > Phil, thanks for your help.
>    >
>    > I had no problems getting the "sensors" program to work on this m/b
>    > with your instructions and the instructions in the tarballs.
>    >
>    > It does appear that sensors.conf may not be entirely correct, but
>    > that's OK for my needs, as I really just want to track change in
>    > temperature over time.
>    >
>    > For reference, if interested, I added the following lines to the end
>    > of my /etc/rc.local:
>    >
>    > # sensors kernel modules
>    > /sbin/insmod i2c-core
>    > /sbin/insmod i2c-proc
>    > /sbin/insmod i2c-isa
>    > /sbin/insmod it87
>    >
>    > The program "sensors" runs fine and gives output like the following:
>    >
>    > it87-isa-0290
>    > Adapter: ISA adapter
>    > Algorithm: ISA algorithm
>    > VCore 1:   +1.74 V  (min =  +1.53 V, max =  +1.87 V)
>    > VCore 2:   +3.04 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
>    > +3.3V:     +3.26 V  (min =  +2.96 V, max =  +3.60 V)
>    > +5V:       +4.99 V  (min =  +4.50 V, max =  +5.48 V)
>    > +12V:     +12.00 V  (min = +11.36 V, max = +13.80 V)
>    > -12V:     -12.10 V  (min = -10.80 V, max = -13.10 V)
>    > -5V:       -5.15 V  (min =  -4.54 V, max =  -5.43 V)
>    > Stdby:     +4.89 V  (min =  +4.50 V, max =  +5.48 V)
>    > in8:       +0.97 V
>    > fan1:     7848 RPM  (min = 3000 RPM, div = 2)
>    > fan2:     5769 RPM  (min = 3000 RPM, div = 2)
>    > Temp1/MB:    +26?C  (min =  +20?C, max =  +60?C)
>    > Temp2/CPU:  -117?C  (min =  +20?C, max =  +60?C)
>    >
>    > I hope this information is helpful -- perhaps this could be edited and
>    > included on the site or in the tarball?
>    >
>    > If a better sensors.conf materializes, I'd be interested in trying it
>    > out.
>    >
>    > Thanks again!
>    >
>    > -- Bob
>    >
> 
>    --
>    Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>       phil@netroedge.com -- http://www.netroedge.com/~phil
>     PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

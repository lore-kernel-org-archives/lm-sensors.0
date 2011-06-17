From: "everythingsfree@lineone.net" <everythingsfree@lineone.net>
Date: Fri, 17 Jun 2011 17:30:53 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <10706563.40191308331853701.JavaMail.defaultUser@defaultHost>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Guenter & Jean, thanks for the continued help.

I got slightly bogged 
down yesterday attempting to upgrade my install - I tried 'apt-get 
update' which downloaded a few things but didn't fix the problem so I 
then tried 'apt-get upgrade' (I'm not sure on the difference between 
the two...) which downloaded even more and then got into trouble, 
ending with a segmentation fault!  I rebooted and continued but got 
more issues and had to stop as it was getting late.

I've since resumed 
and managed to get where I am now with what I hope is a fully upgraded 
install but I still get the same compile errors.

So, I've grabbed 
Jean's file and followed Guenter's instructions to build and install 
those, all went well.  On running 'sensors' I still get 'N/A' for the 
core temps but at least I only get two:

coretemp-isa-0000
Adapter: ISA 
adapter
Core 0:           N/A  (high = +80.0Â°C, crit = +100.0Â°C)
Core 
1:           N/A  (high = +80.0Â°C, crit = +100.0Â°C)

it8720-isa-0290

Adapter: ISA adapter
in0:          +1.10 V  (min =  +0.00 V, max =  +4.
08 V)
in1:          +1.52 V  (min =  +0.00 V, max =  +4.08 V)

in2:          +3.31 V  (min =  +0.00 V, max =  +4.08 V)
in3:          
+2.98 V  (min =  +0.00 V, max =  +4.08 V)
in4:          +3.07 V  (min 
=  +0.00 V, max =  +4.08 V)
in5:          +4.08 V  (min =  +0.00 V, max 
=  +4.08 V)  ALARM
in6:          +4.08 V  (min =  +0.00 V, max =  +4.08 
V)  ALARM
in7:          +2.18 V  (min =  +0.00 V, max =  +4.08 V)

Vbat:         +3.06 V
fan1:        3994 RPM  (min =    0 RPM)

fan2:           0 RPM  (min =    0 RPM)
temp1:        -55.0Â°C  (low  = 
+127.0Â°C, high = +127.0Â°C)  sensor = thermistor
temp2:        +63.0Â°
C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = thermistor

temp3:        +29.0Â°C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = 
thermal diode
cpu0_vid:    +1.850 V


Any further thoughts?

Btw, how 
do you apply a patch file?

Thanks,
Dave


>----Original Message----

>From: guenter.roeck@ericsson.com
>Date: 16/06/2011 23:43 
>To: "Jean 
Delvare"<khali@linux-fr.org>
>Cc: "everythingsfree@lineone.net"
<everythingsfree@lineone.net>, "lm-sensors@lm-sensors.org"<lm-
sensors@lm-sensors.org>
>Subj: Re: [lm-sensors] Gigabyte GA-D525 core 
temps N/A?
>
>On Thu, 2011-06-16 at 17:00 -0400, Jean Delvare wrote:
>> 
On Thu, 16 Jun 2011 13:27:54 -0700, Guenter Roeck wrote:
>> > On Thu, 
Jun 16, 2011 at 04:23:44PM -0400, Guenter Roeck wrote:
>> > > On Thu, 
Jun 16, 2011 at 04:06:10PM -0400, everythingsfree@lineone.net wrote:
>> 
> > > Thanks Guenter & Jean for the replies.
>> > > > 
>> > > > I found 
this web page with some 
>> > > > info and was following that (but just 
used the Makefile as downloaded):
>> > > > 
>> > > > 
>> > > > https://wiki.ubuntu.com/CoreTemp>> > > > That checked and 
updated a few things 
>> > > > plus downloaded other (it covered 
everything Guenter had suggested) but 
>> > > > I still get errors:
>> 
> > > 
>> > > [ ... ]
>> > > > I 
>> > > > would have assumed that 
'MSR_IA32_TEMPERATURE_TARGET' would be defined 
>> > > > in a header 
file and that that would be in the 'linux-headers-2.6.32-24-
>> > > > 
server' package that was downloaded, perhaps not?
>> > > > 
>> > > > 
Any suggestions?  
>> > > > I'll keep looking on-line...
>> > > 
>> > > 
The build worked for me with linux-headers-2.6.32-25-server.
>> > > Can 
you update your system to the latest kernel version and try again ?
>> 
> > It should be 2.6.32-32 as far as I can see.
>> > > 
>> > Sorry, I 
got that wrong; it was 2.6.35-25, not 2.6.32-25.
>> > 
>> > Wel'll have 
to add the missing defines manually. I'll send you an update later 
tonight.
>> 
>> I've attached my compatibility patch for your 
reference. But it's
>> probably easier for Dave to just use my driver.

>> 
>Yes, agreed.
>
>Thanks,
>Guenter
>
>
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

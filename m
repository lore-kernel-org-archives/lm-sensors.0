From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Multiple Smart Batteries
Message-Id: <41F28076.5090303@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050117192539.50355.qmail@web30505.mail.mud.yahoo.com>
In-Reply-To: <20050117192539.50355.qmail@web30505.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

To access multiple addresses really isn't that hard... we call it "subclients"...
see w83781d.c for an example.
However you still would have to copy over all the code from smartbatt.c.
That's probably more trouble than it's worth for you.

So even if you don't make any major changes, we would still like your ltc1760 driver,
please submit it to us when it's ready.
Also any changes/fixes in smartbatt, wouldn't be surprised if you
found some, it hasn't had a lot of testing.

mds



Mohan Mistry wrote:
> Mark,
> 
> The main reason for keeping as ltc1760 & smarbatt
> modules is because I couldn't figure out how I can
> talk to multiple ic2 address  from one i2c module
> 0xa  = ltc1760
> 0xb   = smart-battery
> 0xc   = There is one register which shows conditioning
>    requiired for battery.
> 
> I though about creating a "client" structure for each
> of them but got into ugly hacks.
> Let me think for a while before I let loose the code.
> 
> Yes I like the idea of standards and hopefully once
> things ironed, I can rework my embedded system to use
> the standard release.
> 
> 
> mohan 
> --- Mark Studebaker <mds4@verizon.net> wrote:
> 
> 
>>ok
>>my answers were of course w.r.t. our standards and
>>compatibility w/ our userspace apps;
>>embedded you can do what you want, and your solution
>>sounds the easiest.
>>please submit what you have to us when you are done
>>for inclusion in our project,
>>we can check it into 2.4 CVS.
>>
>>
>>
>>Mohan Mistry wrote:
>>
>>>Mark
>>>
>>>Thanks for your reply.
>>>
>>>Currently my project is embedded and very static
>>
>>and I
>>
>>>don't expect to use sensors.conf , sensorsd or
>>>sensors.
>>>I am using 2.4.27 and won't be moving to 2.6 for a
>>>while.
>>>
>>>I will likely have a  application daemon in user
>>
>>space
>>
>>>which is used to monitor  embedded system status.
>>>[there is a few things we need to monitor and
>>
>>report]
>>
>>>SO I will use  LTC1760 module to select battery
>>
>>via
>>
>>>writing to a ../ltc1760-i2c-0-0a/batt{1,2}_status
>>>and then basically use smartbatt-i2c-0-ob/ to get
>>
>>the
>>
>>>values for  currently selected battery.
>>>
>>>the files:
>>>batt1_status <4
>>
>>ints:present,charge,poweby,smb_select>
>>
>>>batt2_status  <  --------   ditto
>>
>>------------------->
>>
>>>ac_power   <2 ints: acpower, power_no_good>
>>>
>>>writing 1 = to batt[1,2]_status = Selects battery
>>>It checks if battery is present before  switching
>>>the smb bus.
>>>
>>>I haven't spent time looking at calibration.
>>>
>>>I haven't spent time on 2.6 and what it means for
>>>changes. Also how to support sensors.conf for
>>>batteries.
>>>
>>>mm
>>>--- Mark Studebaker <mds4@verizon.net> wrote:
>>>
>>>
>>>
>>>>1) the first option, since userspace apps expect
>>>>entries in a single directory
>>>>
>>>>2) the 1760 is essentially a bus multiplexer,
>>>>presenting two batteries at 0x0b.
>>>>  Our bus multiplexer support is incomplete.
>>>>Therefore it would be difficult at this time
>>>>  to write bus multiplexer code and use smartbatt
>>>>unchanged.
>>>>
>>>>  Therefore the easiest is to not do either of
>>
>>your
>>
>>>>options in 2), but to simply
>>>>  copy what you need from smartbatt.c to
>>
>>ltc1760.c
>>
>>>>and not load smartbatt at all.
>>>>  This is essentially what you describe in 1).
>>>>  The driver would claim the batteries at 0x0b as
>>
>>a
>>
>>>>"subclient".
>>>>  If you are interested,
>>>>  you can see our imcomplete muxing ("virtual")
>>>>code in busses/i2c-virtual.c and
>>>>  chips/pca954x.c. It requires i2c-core changes
>>
>>not
>>
>>>>yet implemented.
>>>>
>>>>I'll add your name to our new drivers page. Send
>>>>your code along when you have something to
>>>>share, and let us know if you need more help.
>>>>
>>>>mds
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>Mohan Mistry wrote:
>>>>
>>>>
>>>>>I am able to load and use the smartbatt.c  module
>>>>
>>>>to
>>>>
>>>>
>>>>>monitor ONE battery. So far so good.
>>>>>
>>>>>I also have a Dual Smart Battery System Manager
>>>>>(LTC1760) chip which takes care of multiple
>>>>
>>>>batteris 
>>>>
>>>>
>>>>>by switching SMBus's. I wrote the module and it
>>>>
>>>>seems
>>>>
>>>>
>>>>>to work pretty well. I can select the battery and
>>>>
>>>>then
>>>>
>>>>
>>>>>basically read the values using
>>>>>/proc/sys/dev/sensosrs/smartbatt-i2c-0-0b/* files
>>>>>
>>>>>
>>>>>Question 1)
>>>>>
>>>>>How should I configure so that I can I see
>>>>
>>>>multiple
>>>>
>>>>
>>>>>batteries? Should I create files:
>>>>>
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1_i
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1_v
>>>>>..
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2_i
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2_v
>>>>>
>>>>>OR
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1/i
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1/v
>>>>>..
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2/i
>>>>>/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2/v
>>>>>
>>>>>
>>>>>Question 2)
>>>>>I could make my ltc1760.o depend on functions of
>>>>>smartbatt.o.  or should I really be looking at
>>>>>/proc/sys/dev/sensors/smartbatt-i2c-0-0b/* files.
>>>>>
>>>>>Any suggestions?
>>>>>
>>>>>mm
>>>>>
>>>>>
>>>>>		
>>>>>__________________________________ 
>>>>>Do you Yahoo!? 
>>>>>All your favorites on one personal page ? Try My
>>>>
>>>>Yahoo!
>>>>
>>>>
>>>>>http://my.yahoo.com 
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>__________________________________________________
>>>Do You Yahoo!?
>>>Tired of spam?  Yahoo! Mail has the best spam
>>
>>protection around 
>>
>>>http://mail.yahoo.com 
>>>
>>
>>
> 
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Take Yahoo! Mail with you! Get it on your mobile phone. 
> http://mobile.yahoo.com/maildemo 
> 

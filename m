From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Vt1211 port to 2.6.x
Message-Id: <400DF42B.9020604@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes I did write the driver.
I lost Francois' mail originally and was recently out of town but
I should be available now to answer your questions.
It's not easy to tell below what is really a question :) but
I will add some comments where I can.

BARRE Francois wrote:
> Hello Gryle and Mark
> 
> 	First let's introduce each other,
> Mark is the initial author of the vt1211 from lm_sensors (aren't you ?)
> Gryle ported the driver to 2.6.x, just as me, both of us on our own sides.
> Let's commit things.
> 
> * Quoting Gryle on his current port problems :
> 
> * rmmod vt1211 doesn't unload the module and the rmmod process hangs
> * I have 2 fans connected but fan1 shows 0 RPMS (maybe because it's a low
> speed fan?)
> * PWM is missing

I never got "manual" PWM working. The datasheet isn't clear on whether
you can control the fan speed by writing the PWM registers 0x60-61.
But it has no effect for me, and at least one user confirmed it didn't work for him either.
If anybody gets "manual" PWM working that would be big news.

The chip is designed for automatic fan speed control, but the
driver doesn't support that.


> * Should min/max/hyst values be initialized by the module?

No, our new policy is that initialization is done by userspace only (sensors -s).
All initializations have been removed in our package
and we will be submitting patches for 2.6.

> * Haven't compared the values output by sensors with the 2.4 kernel module
> 
> * My opinion about that :
> 
> Rmmod : I don't have the problem myself, I did have to insmod/rmmod several
> times in order to tune some stuff, never had a problem. I will diff our code
> anyway.
> 
> Fans : I don't use fan connectors on my mb, so I actually can't test such
> stuff. I will try indeed.
> 
> PWM : not used.
> 
> Min/max/hyst : I do guess this is much more a sensors (I mean the prog in
> lm_sensors) issue, or any program that will be able to deal with the alarms
> the device throws. These temps should be set at setup of such program.
> 
> Comparision with 2.4 values : If differences were to be, they would be close
> to 1? or 2?C, because the tests I have made by my side gave approx same
> results (idle pc in cold room, busy pc in cold room, idle & busy in warm
> room). At least the basic IO stuff is exactly the same from 2.4.x to 2.6.x
> so this should not change (except the extra 1000 ratio introduced in the
> sysfs IIRC).
> 
> * What should be planned :
> 
> Your code is fast more advanced than mine (you did implement all the sysfs
> stuff indeed). 
> So my proposition is for us to start from your code. I would like to look
> close at your code for the rmmod issue. Maybe this week-end...
> 
> I would also try to split the update_client for avoiding all data to be
> retrieved from the i2c device when at least one attribute is to be queried
> by the user. But that causes some problems with the jiffies stuff. I'll try
> if I have time (and I have no time ;-).

It's for data caching, it's common code in all our drivers.
I wouldn't bother splitting it up, since VT1211 is an "ISA" bus device,
which is extremely fast to access compared to i2c. So reading everything
doesn't take long at all.

> 
> PS for gryle : if you have an epia nehmehia running on a 2.6.x kernel, did
> you solve the longhaul issue ?
> 
> Thanks for advance,
> 
> Fran?ois.
> 

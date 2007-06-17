From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 17 Jun 2007 19:50:23 +0000
Subject: Re: [lm-sensors] Is it possible to raise the abituguru voltage test
Message-Id: <467592D0.70303@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613121553.17775.qmail@science.horizon.com>
In-Reply-To: <20070613121553.17775.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

linux@horizon.com wrote:
>> Something like that should work yes, good idea. Attached is a version
>> with this implemented. I've attached a makefile for easy out of tree
>> compilation too, just drop the makefile and abituguru.c in a dir, type
>> make and you should get an abituguru.ko to insmod.
> 
> Ah, oops.  I should have sent you what I implemented and tested.  Now
> I'll go test yours.
> 
> One thing I noticed in code review: if the reading is very low, do
> you want to bother doing the temperature test?  It seems like it would
> never alarm, so is just a waste of time.
> 

That case already gets caught by the first check:
	if ((val < 10u) || (val > 250u)) {

You remove this check, because with having both voltage checks variants it 
isn't needed, I kept it because if a reading is THAT close to the absolutely 
min / max reading possible, something is wrong.

>> Please let me know how this works for you. Notice that I only use the
>> volt high test for readings > 240, as this is delicated code and I do
>> not want to change the code path for already working setups.
> 
> Yes, yours works too, even with the changeover level moved to 20 to
> get a better test.  Um... what does "delicated" mean?  Delicate?
> 

Yes, delicate sorry. The abituguru is a microcontroller with many firmware 
versions, so what may work fine on one "chip" does not necessarily work on 
another, for example on some versions the min/max limit must be more then 1 
unit apart, which is why I use 5 and 10 resp 245 and 250.


> My (tested and working) variant is enclosed.  Note the "temp too low
> to test" condition you don't have.  Another version is coming next e-mail.
> 

Thanks but no thanks, I'll stick with my minimal changes version. It took me 
many days of debugging and back and forward mails with testers to get code that 
works everywhere (except appearantly your mobo).

I've also seen your do both tests in one go version, its clever, but its also 
definitively programming the "chip" outside its specs, the 2 flags should 
normally never be set at the same time. So thanks but no thanks.

Regards,

Hans

p.s.

Thanks for the dmi output too.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

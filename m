From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: driver design question
Message-Id: <3F25A344.3030900@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


BTW- I'm glad you're looking for optimizations and clean-ups.  I 
appreciate your efforts.  I think this is a topic which is really has 
valid points either way.  As you suggest, I think I am more leaning 
towards playing it safe. :')

I'll make a few comments and clarifications inline, and perhaps Mark and 
some others can weigh in.

Jean Delvare wrote:

>Is there any way values can be written to the driver's register without
>telling us?
>

I think any other communication with the chip which isn't through our 
driver (Bios? or some other code?) might change the values, although it 
is unlikely.  It's also possible that a driver may be misdetected or 
forced.  It would be odd if the driver gave misleading 'correct' limit 
readings in these cases.  I don't think it is worth the risl

In a nutshell, I think lower level drivers which talk to hardware 
shouldn't do any internal caching or optimizing which isn't nessesary.  
I.e., when values are asked for, it should talk directly with the 
hardware to ask for them and not make any assumptions.

Now, for user-space apps, it could be more justifiable to cache or 
assume values.  At least, I'd rather see those sorts of hacks done in 
user-space than kernel driver space.  For this paricular issue (if we 
are trying to optimize speed or limit transaction numbers over the I2C 
bus), it doesn't buy anything so it is a moot point.

>
>No (at least none I am aware of). But I don't like the idea of our
>driver doing something that could be avoided with no drawback. Please
>realize that for each update, which can occur typically as often as once
>every 1.5 second, 1/3 of the work is for the current values, which is
>legitimate, and 2/3 of the work is for limits, which 100% of the time
>AFAIK did not change. Multiplying the amount of work by three is more
>than just overhead, isn't it?
>
>Thus my question, and I ask it again, maybe more clearly than the first
>time. How could the chip's register be changed without using our driver?
>  
>
Well, I guess it is a matter of ideals.  I've thought of kernel hardware 
drivers as being an inbetween for the user-space apps and the actual 
hardware with absolutely as little tainting of the data as possible.  
Even if the values in the hardware's registers are unlikely to change or 
change infrequently, we still should pass values straight through and 
not make any assumptions on the data in code.

As long as overhead and processor loading isn't an issue, I'd suggest we 
not cache or code in any value/limit assumptions into the code.  I2C 
transactions are slow, but they cause little (if any) CPU loading or 
resource hogging.  Even as far as percentage usage of the I2C bus, it is 
small.  I can't see any possible significant performance gains by 
caching things like limits.  Also, there are at least some potential 
drawbacks (at least marginally more than simply 'no drawbacks'), so I 
see some additional risk with no gain.

BTW- The worst offender of reading values over and over with little 
chance of change is the eeprom driver.  For each device, if I remember 
correctly, each byte read takes two I2C transactions for 256 bytes!  So, 
if you have 4 dimms (with an eeprom on each), you are doing over 2 
thousand transactions.  Still, though, this take little time and almost 
no CPU overhead, so it doesn't seem to hurt anything. 

Anyways, that's my $0.02. :')


Phil

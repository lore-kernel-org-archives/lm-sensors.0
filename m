From: lamar@synque.com (Lamar)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: MPX2/LM90 switching discussion
Message-Id: <40F867F3.1090404@synque.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F6F2A2.50503@synque.com>
In-Reply-To: <40F6F2A2.50503@synque.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,
    Thanks for the comments, I start looking at the code this weekend, 
and since a journey of a thousand miles starts with the first step, it's 
probably best that I get a user-space program running to prove the 
concept and then go from there.
    The 5 access methods I referred to are those listed in your Overview 
for Application Developers document: /dev/i2c-x, I2C bus access via 
i2c-dev.h, proc/sysfs access, libsensors, and sensors.
    I found one of your suggestions very intriguing, writing a 
independent LM90 driver, something like LM90MPX2 or some such, that a 
user could insmod instead of or in addition to the LM90 driver. Only 
MPX2 users would want to use it, and it would segregate this nasty 
switching business away from the pristine code. I've also thought a bit 
about how to solve the synchronization issue as simply as possible, and 
I'm toying with successive accesses reading from alternate CPUs. 
Basically, a incoming request would read from the current CPU and 
trigger a switch. I know that the two-second caching presents a problem, 
so the minimum access period would have to be three seconds. Once again, 
this is an issue only LM90MPX2 users would need to be concerned about. 
So perhaps we can find a compromise between the solution resting in 
kernel-space, yet not bloating existing code (or at least co-habitating 
with it!)
    I truly understand how badly the folks over at Iwill hosed this up. 
I don't know /why/ they did what they did, but I do know that their BIOS 
handles it, and Alex's code handles it, so it ought to be possible in 
Linux. I hate knowing that the data is there, but I can't see it! My 
solution may not be elegant or award-winning - /I don't make the 
monkeys, I just train them/. So I'm off to start tinkering, I'll keep 
you posted.

Lamar


Jean Delvare wrote:

>Hi Lamar,
>
>  
>
>>   I understand your desire to move the solution out into user-space,
>>but I would think the end goal would be for the utilities that use
>>lm_sensors to work with little or no modifications, such as gkrellm, and
>>the like.
>>    
>>
>
>Such tools can still learn about your new user-space tools and interface
>with it if it's cleverly designed.
>
>  
>
>>That would require the introduction of a virtual LM90 for
>>these programs to detect. Since there are 5 access methods of varying
>>levels,
>>    
>>
>
>5 levels? What are you talking about?
>
>  
>
>>it would seem to me that in order to ensure the widest support,
>>the solution should be implemented in the kernel.
>>    
>>
>
>Could be in libsensors as well, but I would like to avoid any
>chip-specific code in libsensors in the future, so I have to agree that
>it should be done either in the kernel or as a standalone, dedicated
>user-space tool.
>
>  
>
>>I will admit my
>>personal preference is to have gkrellm and sensors to work, and for this
>>user-level is sufficient, assuming gkrellm uses libsensors.
>>    
>>
>
>Bad assumption. Gkrellm doesn't use libsensors. As a consequence, they
>don't deserve nor receive any kind of support from us. On the other
>hand, they never asked for support, nor complained about anything (net
>even when we made several changes to the sysfs interface).
>
>  
>
>>   Of course, there is the challenge of synchronizing LM90 sensor
>>switching with the driver updating. How could this be enforced from
>>user-land?
>>    
>>
>
>This merely relies on the user. Updates are done by the lm90 driver when
>data is read from procfs/sysfs files. The user can simply ensure that
>this will not happen at the same time he/she will switch the sensor.
>
>Note that things are a bit more complex than that however. The LM90 is
>monitoring the remote temperature value continuously, not only when we
>request that value over the SMBus. I don't know how reliable and fast
>the sensor switching is, but I can imagine that in worse cases one
>reading could fail and trigger an error. Since errors are remembered by
>the chip until one reads them, this is likely to trigger false alarms.
>
>  
>
>>It seems some support is required in kernel-space to at least
>>signal when updating is in progress, perhaps there already is.
>>    
>>
>
>No, there isn't, and I hardly see how this would be done. The chip could
>export a file with the "update in progress" status, but it wouldn't
>help (You can start switching when reading 0 form the file, but how
>could you sure it won't turn to 1 before you end switching?
>
>A different approach would be a way to stop the lm90 chip from
>monitoring, switch, and re-enable it afterwards. There is no dedicated
>file name for that in our current sysfs interface but it could be added,
>since it sounds like a reasonable functionality to have. That solves the
>race problem.
>
>  
>
>>Actually, I'm not sure this approach would work, I think that the
>>switching would have to take place within kernel-space to truly avoid a
>>switch during update!
>>    
>>
>
>With the method described right above, it should work OK, assuming that
>the user does the correct thing. However, I think I understand that this
>isn't the way you would like things to be done...
>
>  
>
>>   At any rate, my goal would be for a second, virtual LM90 to appear
>>via the libsensors APIs. I have only started to investigate this so any
>>comments would be appreciated.
>>    
>>
>
>This is certainly possible. You'll run into a number of issues however:
>
>1* At least in Linux 2.6, you are not supposed to use an I/O address
>range if you didn't reserve it. Once you reserved it, nobody can use it
>anymore. This means that you would have to write a driver for your
>Super-I/O chip, not just hack some random I/O operations to do just what
>you want. I suspect that a reserved I/O space is not usable from
>user-space, so this is likely to break existing hacks similar to the
>user-space tool I was suggesting you could write. I agree that in most
>cases, having a driver would be better but in many cases this is
>overkill, and at any rate this means more work that you'd have
>suspected. Think of it as of a can of worms.
>
>2* If you write such an independant driver, the lm90 driver will need to
>be able to send commands to it. But only if it's there, of course,
>since most users don't have an MPX2. I have no idea how this is done.
>
>3* If OTOH you add the code directly to the lm90 driver, it's likely to
>bloat that driver and make me unhappy ;)
>
>4* In any case, I doubt you'll be able to make it look as two LM90
>chips, since they would share everything but the remote temperature
>reading, and in particular, their I2C address, So more likely it'll
>have to be a single lm90 with one more reading (and some, but not all,
>alarm bits will need duplication as well). It looks to me like it will
>be everything but trivial and clean.
>
>I would like you to consider that Iwill's idea of using a single LM90
>chip to monitor two CPU temperatures is one of the worse idea one could
>think of. This is an awful design error. This means that at any rate you
>cannot monitor both temperatures at the same time. You can try switching
>fast between both but then you'll run into the problems described above
>(you have to synchronize the LM90 with the switching operation) and this
>makes the driver design a pain, as described above as well. National
>Semiconductor has a dedicated sensor for dual-CPU systems: the LM83.
>They could also have used any complete monitoring solution such as
>Winbond or ITE's chips, which can monitor up to 3 temperatures
>(typically two CPUs and one local/motherboard). Or they could have been
>using two LM89s since that chip exists with two different addresses
>(while the LM90 doesn't). In short there were plenty of smart things to
>do and they did the worse thing one could imagine.
>
>I never favor bloating the common software to compensate for specific
>hardware design errors. Thus my proposal to go with a dedicated
>user-space tool.
>
>So, whatever you try to do in the kernel space, it'll have to look very,
>very nice if you want me (or any other kernel developer) to accept it. I
>have to admit, and you must have felt it, that for now I have a slight
>negative a priori ;)
>
>  
>
>>Also, I am greatly impressed by the
>>existing body of work, and so my comments are made as humbly and
>>respectfully as possible.
>>    
>>
>
>Thanks :')
>
>Jean Delvare
>  
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040716/1be957ff/attachment.html

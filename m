From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <427FF313.7070202@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yani Ioannou wrote:
> Hi Aj,
> 
> Sorry for the late reply, I've been busy trying to get the
> sysfs-dyncallback patch accepted into the kernel so I can re-write
> bmcsensors and get it in at some point in the future.
> 
> On 4/26/05, Aj Lavin <aj@ectologic.com> wrote:
> 
>>Hi,
>>
>>Any hints for somebody attempting to configure fan speed control with a
>>BMC? :-)
>>
>>I am using bmcsensors with Intel SHG2 motherboard, Sahalee BMC.
>>According to the motherboard docs it also uses an ADM1026.
>>bmcsensors works great for reading temperatures and fan speeds. But when
>>I run pwmconfig I get:
>>/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
>>
>>Looking at bmcsensors.c I see:
>>#if 0
>>static void bmcsensors_fan_div(struct i2c_client *client, int operation,
>>                               int ctl_name, int *nrels_mag, long *results);
>>static void bmcsensors_pwm(struct i2c_client *client, int operation,
>>                           int ctl_name, int *nrels_mag, long *results);
>>#endif
>>
>>Not knowing anything about device drivers I guess that fan control
>>support is not yet programmed into bmcsensors. If you need help testing
>>this feature I would be more than happy to try it on my server. ;-)
> 
> 
> Yes, those look like they are leftover from the original 2.4
> bmcsensors driver (Mark wrote), unfortunately I haven't got an IPMI
> BMC that supports this, although it would be nice to get this working.
> I wonder why it wasn't implemented in the original driver.. I'm
> forwarding this to Mark to see if he has any input.
> 
> 
>>In the mean time, is there other Linux software I can use to adjust the
>>fan speeds? Even manual fan speed control would be helpful.
> 
> 
> You might be able to use ipmitool, or one of the other userspace impi
> interfaces, unfortunately I have no such experience with pwm sensors.
> 
> Yani

2.4 bmcsensors doesn't have write support at all.
In fact I didn't realize that 2.6 _did_ have write support.
Nice Yani!
That is obviously a requirement for setting anything.

the functions #if'ed out look like cruft left over from when I copied
whatever driver I started from, they should be deleted.

I've never seen  an IPMI SDR that looked  like PWM control or fan divisor.
IPMI systems tend to want to control their  own fan speeds, in my experience, so taking manual control
of PWM doesn't really fit  the IPMI paradigm too well.
For example, with my IPMI system I was testing  the fan reading so I stuck a pencil in the
CPU fan. It tried to  restart the fan 3 times in about 10 seconds  and then the system
did an instantaneous shutdown. Nice I guess but made testing harder :)

I'm not familiar with how a general-purpose  output (like PWM) would be implemented
in IPMI. bmcsensors is  all about sensor _inputs_ and their limits.

So I don't think PWM control via bmcsensors makes a lot of sense.

mds


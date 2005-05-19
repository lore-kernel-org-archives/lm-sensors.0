From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: i2c_slave_send & recv?
Message-Id: <3EE7C840.8030506@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E923014.50504@mbari.org>
In-Reply-To: <3E923014.50504@mbari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(going back through some old mail)
First suggestion we've heard about using a network interface.
Probaly not a good fit in my opinion.
The recent conversion to the 2.5 kernel "driver model"
is a better fit.
Perhaps in that model it would be more straightforward to
add slave functionality and event notification...
then again maybe not.

ARP is Address Resolution Protocol which is a way to
assign an address to a hotplugged I2C device in the SMBus 2.0 spec.

As I said in April, if you plan to work on the slave functionality
let us know.

mds



Brent Roman wrote:
> Mark,
> 
> Has anyone thought about connecting I2C to the kernel as
> a _network_ interface rather than a character mode driver?
> (Or, in addition to as a character mode driver?)
> 
> If I2C could be viewed as a network interface, I think all the semantics
> would work out much better.  You'd listen on a raw sockets
> to await messages, etc.  Different processes could listen on
> different "ports" simutaneously as long as their I2C addresses were
> unique -- otherwise you'd get a BIND error about an address already
> being in use.  I fear that if you were to extend the current char driver
> interface to achieve anything like the same flexibility, you would
> effectively reimplement the lower end of linux's networking stack.
> 
> Does this make sense to you?
> 
> When I first read the I2C spec, I thought of it as a _very_ Local Area 
> Network.
> Later, I found that some vendors even refer to it as a "Small Area Net".
> 
> By the way:
> 
> What exactly do you mean in your TODO by "Notify ARP Master"?
> What does ARP stand for in this context?
> 
> - brent
> 
> 
>> those are all good questions.
>> The only other thing I found is a paragraph I wrote in
>> the TODO file in the i2c tree (search for 'slave')
>> which hints at these and some other issues.
>>
>> When I was implementing SMBus 2.0 enhancements and
>> the smbus-arp demonstration driver I looked briefly
>> into what it would take to implement "notify ARP master"
>> and concluded that it would take some work.
>>
>> If you choose to develop slave functionality
>> please let us know. We can help discuss things
>> but sorry we don't have any good answers for you at the moment.
>>
>> mds
>>
>>
>>
>> Brent Roman wrote:
>> Hi,
>>
>> We are developing a complex embedded instument.
>> It will consist of a tiny XScale board running linux attached
>> via I2C to a variety of custom sensors and actuators
>> that we intend to custom design.
>>
>> To efficiently utilize limited I2C bus bandwidth, I had intended
>> to have the Linux system act as an I2C slave, responding
>> to events detected by the intelligent sensors more or less in real-time.
>> The alternative would be to poll each sensor continuously
>>
>> I'm concerned about the following in i2c.h:
>>
>> /* Some adapter types (i.e. PCF 8584 based ones) may support slave 
>> behaviuor.
>> * This is not tested/implemented yet and will change in the future.
>> */
>> extern int i2c_slave_send(struct i2c_client *,char*,int);
>> extern int i2c_slave_recv(struct i2c_client *,char*,int);
>>
>> Even if I implement these functions for the XScale's built-in I2C 
>> hardware
>> how would an application detect incoming messages?
>>
>> I don't see any sort of event notification mechanism.
>> Would i2c_slave_recv simply block until it received a message from
>> the addressed client?  If so, would I need to start multiple threads to
>> monitor multiple clients simutaneously?
>>
>> Given this interface, the best I can think of right now is to define
>> a sort of wildcard address so one thread could i2c_slave_revc from
>> it and unblock when a message is received from any master.
>>
>> But, as you probably can tell, I'm pretty confused right now.
>> I'm hoping one of the I2C package developers can set me straight...
> 
> 
> 

From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 09 Jul 2006 17:11:33 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44B138C5.6060705@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> Ok, now another problem. Some of the times the module loads fine during
> bootup but sensors reports that
> 
> $ sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
> If I rmmod abituguru and modprobe it again, it works. I will rebuild the
> module and see if it helps.
> 
> The fallout of this is that gkrellm forgets about my sensors permanently. I
> have to re-enable them and re-assign the labels etc....:(
> 

Yes, this is because the module loads, but the driver part of it doesn't
(new driver model, where drivers can be registered without actually
handling any devices, so they can be bound to hotplug devices lateR).


The driver part probably fails to load because it happens to run into
those errors you report during the initialisation fase. Strange though
as during init it retries all things 3 times, which goes to show that
indeed your uGuru is unwilling to talk for a while, as seen before with
early uGurus, what motherboard do you have. Lemme gues one out of this
list? : AI7, KV8-MAX3, AN7


Regards,

Hans




> Thanks,
> -Sunil
> 
> On 7/9/06, Sunil Kumar < devsku at gmail.com> wrote:
>>
>> they always occurr in a bunch but they are scattered all over time,
>> sometimes disappearing for many hours and then returning.
>>
>>
>> On 7/9/06, Hans de Goede < j.w.r.degoede at hhs.nl> wrote:
>> >
>> >
>> >
>> > Sunil Kumar wrote:
>> > > Hi Hans,
>> > >
>> > > I am seeing these messages in the dmesg:
>> > >
>> > > abituguru: timeout exceeded waiting for ready state
>> > > abituguru: timeout exceeded waiting for ready state
>> > > abituguru: timeout exceeded waiting for read state (bank: 34, sensor:
>> > 15)
>> > > abituguru: CMD reg does not hold 0xAC after ready command
>> > > abituguru: timeout exceeded waiting for read state (bank: 38, sensor:
>> > 2)
>> > > abituguru: timeout exceeded waiting for ready state
>> > >
>> >
>> > Hmm, were these messages close together in time, or now and then a
>> > message?
>> >
>> > > I am not sure if they are related to a freeze I saw today. My machine
>> > > wasn't
>> > > being used and when I came back, it was frozen.
>> >
>> > I seriously doubt the freeze and these messages are related. The uGuru
>> > only uses 2 io ports todo all communication with the outside. So
>> reading
>> >
>> > the ports doesn't always get you the same register there is a sortoff
>> > network protocol which you speak over the ports. These messages mean
>> > that the uGuru failed to response within a reasonable time. Unfortunate
>> > on some uGuru's this is quite normal. It seems the older the
>> > Motherboard, the more often this happens (iow the buggier the uGuru
>> > firmware).
>> >
>> > Regards,
>> >
>> > Hans
>> >
>>
>>
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


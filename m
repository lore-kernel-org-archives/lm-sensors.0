From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 19 Nov 2009 12:35:40 +0000
Subject: Re: [lm-sensors] ipmisensors module ported to 2.6.29
Message-Id: <68676e00911190435k4504c1a9uc759cf345f42a774@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
In-Reply-To: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 19, 2009 at 1:09 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 19 Nov 2009 12:22:39 +0100, Luca Tettamanti wrote:
>> On Thu, Nov 19, 2009 at 11:46 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> > For IPMI, I don't know if "ipmitool sensor" can be run as non-root,
>> > this needs to be confirmed. I presume it depends on the permissions of
>> > the /dev/impi* nodes.
>>
>> Yes, the user needs rw permission on the device node.
>>
>> >> If you are willing to spend effort on this, I would be happy to help were I
>> >> can!
>> >
>> > The bottom line is that anyone who pushes IPMI sensors support forward
>> > has my blessing. Honestly, I don't care that much whether it is in the
>> > kernel or in libsensors, as long as it finally happens. It has been
>> > pending for sooooo long :(
>>
>> +1 ;-)
>> I have the hardware (a few Dell servers) so at least I can do testing
>> (and hopefully some coding).
>
> Would you be willing to work together with Paul to put ipmisensors code
> into shape to be finally merged into the kernel? After it is confirmed
> that ipmisensors won't cause trouble to ipmisensors, of course.

I _might_ be able to hijack a development machine during the weekend,
otherwise for testing I'd have to backport to 2.6.26 (Debian) since I
really can't do a lot of reboots to test a kernel module.

> Then we can discuss whether a libsensors-based implementation would
> make sense, but if you need rw access to /dev/ipmi0 then I guess a
> user-space implementation becomes unrealistic.

But easier to test for me :P
BTW, I did a quick recompile of ipmitool opening the device node ro:
it still works (or at least it seems to).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

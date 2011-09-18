From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 18 Sep 2011 11:17:14 +0000
Subject: Re: [lm-sensors] [RFC 1/2] add new hwmon-core interface v3
Message-Id: <4E75D33A.4040305@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316119550.25490.14.camel@tellur>
In-Reply-To: <1316119550.25490.14.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 09/16/2011 03:05 PM, Lucas Stach wrote:
> Hello Hans,
>

<snip snip>

>> An other issue you need to tackle is non continuous indexes. Some drivers have
>> the ability to handle large amounts of channels, for example the sch5636 has
>> upto 5 voltage inputs, 16 temperatures and 8 fans. Almost no motherboard
>> will use these all, and the BIOS should program the chip to disable unused
>> channels, we read this information back and only add sysfs attributes for
>> enabled channels, which can lead to having fan1 and fan6 but nothing in between.
>> Note that when you've per sensor rather then per channel caps, you can essentially
>> handle this for free, since an unused index can simply be a channel without any
>> caps.
>
> Do we really have to reflect the hole in sensor numbering? Isn't it
> enough to only expose the supported number of channels in the interface
> and do the remapping index->channel within the driver? This would be
> simple with the current interface, as you can reflect this mapping in
> the inst_data, which is passed around. Is there any application or
> use-case relying on the numbering hole being existent?

Having holes makes things a lot more KISS on the sensor driver side, besides
that drivers with holes in their numbering already exist, we cannot simply
change the numbering as that would be breaking the user kernelspace API,
so either we need to support holes in the numbering, or we will never be
able to convert those drivers to the new core...

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

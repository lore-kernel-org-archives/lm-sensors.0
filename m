From: Harald Judt <h.judt@gmx.at>
Date: Fri, 06 Jan 2012 11:36:15 +0000
Subject: Re: [lm-sensors] NCT6776 global registers 0x1c=0 and 0x24=0x5c
Message-Id: <4F06DCAF.8010105@gmx.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110410160433.GA22075@localhost>
In-Reply-To: <20110410160433.GA22075@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 05.01.2012 15:45, schrieb Jean Delvare:
> On Thu, 5 Jan 2012 15:39:01 +0100, Jean Delvare wrote:
>> On Wed, 21 Dec 2011 23:43:47 +0100, Harald Judt wrote:
>>> Am 21.12.2011 21:55, schrieb Ira W. Snyder:
>>>> I wonder if you could set these register values only on this specific
>>>> motherboard by checking the DMI table to determine the motherboard
>>>> vendor and model number.
>>>
>>> This is what I currently do using dmidecode in /etc/init.d/lm_sensors,
>>> because I too fear to forget about this and accidently wreck a new
>>> mainboard I'm going to buy in the future:
>>>
>>> # We need to do some initialization before loading the module,
>>> # otherwise only 2 of the 5 fans will be shown
>>> init_module_w83627ehf() {
>>>       modprobe -q -r w83627ehf
>>>       # make sure to do this only for the right mainboard
>>>       if /usr/sbin/dmidecode | grep -i 'Base Board Information' -A2 -B1 |
>>> grep -q 'P67 Extreme4' \
>>>           &&  /usr/sbin/dmidecode | grep -i 'BIOS Information' -A3 | grep
>>> -q 'Version: L1.61'&&  \
>>
>> dmidecode -s is your friend ;) Namely -s baseboard-product-name and -s
>> bios-version.

To be honest, I didn't care enough to optimize a one-time call at 
startup, even if it looks terribly ugly.

> Oh, and I almost forgot: the same info is typically available
> from /sys/class/dmi/id/* for even cheaper.

Thanks, that's really helpful! It helps me to get rid of the dmidecode 
dependence and I've learned something new ;-)

Regards,
Harald

-- 
`Experience is the best teacher.'

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

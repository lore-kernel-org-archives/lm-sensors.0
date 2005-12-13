From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Tue, 13 Dec 2005 22:06:33 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051213220633.GA23644@dnil.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

On Sat, Dec 10, 2005 at 10:14:30AM +0100, Rudolf Marek wrote:
> 
> Lets try:
> 
> Generate the SMI from other source than the fans limits (if it hangs too)
> Then we will know if the complete handler is wrong or only parts.

So I've done some more debugging, but things are looking pretty
strange. First of all, I'm setting all the fan limits to 0xff as far
as I can tell which should mean that I will accept an inifinite amount
of time between each pulse or in other words 0 fan speed. So I don't
follow what you mean by setting the limits to 0? Isn't that what I'm
doing now in the script? At least according to 'sensors' that is the
effect of writing 0xff to all the fan speed limit registers.

> Also are you using HIGHMEM support in kernel? I guess this might be
> right reason why it fails (Due to 4MB PAE)

I am using HIGHMEM support and I tried to disable it, didn't notice a
difference in behaviour... 

> So what to do:
> 1) why is SMI generated when writing limits?
> 2) if SMI fan event is specific to hang or any other SMI will hang too.
> 3) what about highmem?

I've also noticed that register at 0x40 is programmed to 0x03 after a
reboot which emans that the interrupt output is active (supposedly the
one connected to the GPIO that Gigabyte mentions in their mail). But
EN_SMI# output is disabled. So I guess that the chip isn't setup to
generate an SMI event on it's own but rather through that GPIO pin
somehow.

I enabled that EN_SMI# output and now I can reproduce the freeze
easily by setting a voltage limit to low:

oden:~# i2cset -y 0 0x2c 0x2b 0xff # in0_max
No size specified (using byte-data access)
Value 0xff written, readback matched
oden:~# i2cset -y 0 0x2c 0x40 0x7 # enable EN_SMI#
No size specified (using byte-data access)
Value 0x07 written, readback matched
oden:~# i2cset -y 0 0x2c 0x2b 0x10 # in0_max
No size specified (using byte-data access)
[machine freezes]

I guess this proves the point that it's not the fan event that causes
the hang but rather any SMI event? Is the SMI code installed by the
BIOS?

Regards
-- 
Daniel Nilsson


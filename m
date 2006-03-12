From: linux@rick.claranet.de (Hartmut Rick)
Date: Sun, 12 Mar 2006 22:52:25 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware monitoring
Message-Id: <Pine.LNX.4.63.0603122313130.3043@Laila>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603042101570.3972@Laila>
In-Reply-To: <Pine.LNX.4.63.0603042101570.3972@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi Jean and Raphael,

On Sat, 11 Mar 2006, Jean Delvare wrote:

(SMSC47M192 user space patch)
> I just replied to it with my comments. It's overall good.

Thanks a lot, I'll send new patches for the driver and userspace soon.

>> temp2 is my CPU temp I am 99% sure.  The low and high figures appear to
>> be meaningless and change depending on what the cpu is doing.  For example
>>
>> temp2:     +57.0 C  (low  =   +55 C, high =   +65 C)
>>
>> under light load.
>
> This is really strange. Please load the i2c-dev module, then try
> "i2cdump 0 0x2d b" from times to times and see if registers 0x37 and
> 0x38 change that way too. I guess they will.
>
> Maybe something (BIOS?) is accessing the chip too, but if so I'd expect
> other problems to show sooner or later. And I don't get the point
> of changing these limits on the fly anyway.
>
> Hartmut, I guess you never observed anything like this on your own
> system?

No, for me everything works like expected. If I set any limits, nobody 
touches them, and they stay like I set them. If I reboot, the BIOS resets 
limits for temp1 and temp2 to -128 .. +127 degC, but it doesn't seem to 
bother setting limits for temp3 - those stay like I set them even
through a reboot. A little bit  strange, because temp3 is what the BIOS 
shows as "System temperature". It doesn't show any alarms though.
I have a Gigabyte K8U board with ULi M1689 chipset. All voltages are 
connected, except the +1.8V, which is in upper saturation. To be precise, 
the voltages almost never change, so I cannot really be sure they're 
connected, but they all show roughly their nominal value.

The only anomaly I observe is that CPU temperature is about 18 degC higher 
in Linux than in BIOS. I suspect that there is an offset added by the CPU,
but I haven't found out how to read that yet, so I'm just subtracting
18 degC for now. The CPU is an AMD Sempron 2800+.

>
> Raphael, do you have any option in your BIOS which could be related to
> that "feature"?
>
>> The rest of the measurements are a mystery to me and the 6 ALARMS seem
>> slightly... alarming :)
>
> I guess that the chip does loose comparisons for alarms. The voltage
> inputs seem to be unused and wired to the ground on your board, so they
> report 0, with low limit 0 you end up with 0 <= 0, which is true so the
> alarm triggers. Not very smart from SMSC if I'm right.

The datasheet says that if you want to use any alarm features, you must 
connect unused voltage inputs to some nonzero voltage. If you don't need 
alarms, unused voltage inputs may be grounded. So at least they did 
notice the problem.
The comparisons at the upper limit are different, by the way. If the 
input is in high saturation and the limit is 0xFF, there is no alarm 
(just my observation, I haven't read that in the datasheet).


Best wishes,
  Hartmut


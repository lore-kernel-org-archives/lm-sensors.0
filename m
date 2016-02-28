From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 28 Feb 2016 17:54:19 +0000
Subject: Re: [lm-sensors] Datasheet for Fintek F71868a
Message-Id: <56D3344B.7060703@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
In-Reply-To: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/28/2016 08:04 AM, Fulcrum wrote:
> Hi
>
> On 02/28/2016 11:38 PM, Guenter Roeck wrote:
>> So what is the chip ID of your chip ? There is no "F71868" chip as far
>> as I know.
>> Sure, one could nitpick that the constant is not named SIO_F81866A_ID but
>> SIO_F81866_ID, but usually we are not that picky. The chip ID for F71868A
>> is supposed to be 0x1106.
>
> As I told you earlier, I am quite a beginner when it comes to linux hardware stuff. I was not arguing the naming convention. It 'seemed' to me that F71868 was a different chip from F71868a (I don't know if that's true or not) because two differnt names were used in the driver. I just wanted to bring this fact to your knowledge.
>
>  > So what is the chip ID of your chip ?
>
> Again, being a beginner, I don't know how can I find the chip ID. (Could you tell me?)
>
The kernel log should tell you when you load the driver without force_id.

> I meant no offense. I wish to be involved in linux driver development. On my MSI PC, lm_sensors says that F71868a is not currently supported (although I am running 4.4.1-2). That's why I mailed lm-sensors list.
>
No worries; no offense taken, and none meant. Please keep the mailing list in Cc:;
others may be interested in the exchange as well.

If sensors-detect provides the chip name, its ID is recognized. I had a look
into sensors-detect; it identifies the chip with ID 0x1106, so the driver
should recognize it as well. Yes, sensors-detect says that the chip is not
supported, but that is a problem with sensors-detect which we'll need to fix,
not with the kernel driver.

This makes it quite odd that you say you can only load the driver if you specify
force_id=0x1106, but not without it. The driver _should_ recognize the chip.
Are you sure the driver doesn't load without force_id ?
If so, do you see a message in the kernel log ? What does it say ?
There should be something like
	f71882fg: Unsupported Fintek device: <hex ID>
in the log.

> Lastly, if this driver does support F71868a, shouldn't it be auto-loaded by kernel?
>
No, this is not an auto-loading driver. The kernel does not support auto-loading
Super-IO chip drivers. In case you wonder: It shouldn't, because Super-IO chip
detection is not well defined. Running sensors-detect is critical enough; even
that asks you and says "This is _usually_ safe" (emphasis added). We don't really
want to do this automatically with every boot.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

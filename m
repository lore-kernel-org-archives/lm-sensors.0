From: Fulcrum <fulcrummike@hotmail.com>
Date: Sun, 28 Feb 2016 18:36:55 +0000
Subject: Re: [lm-sensors] Datasheet for Fintek F71868a
Message-Id: <BLU437-SMTP22FF01E138D1C7CB398096B3B90@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
In-Reply-To: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 02/29/2016 01:54 AM, Guenter Roeck wrote:

> The kernel log should tell you when you load the driver without force_id.

I tried loading the driver without force_id, and it did work. I learnt
about force_id for this chip in some forum post, and never thought of 
loading the driver without force_id. Here are the kernel logs (dmesg):

[25369.887005] f71882fg: Found f71868a chip at 0x290, revision 48
[25369.887150] f71882fg f71882fg.656: Fan: 1 is in duty-cycle mode
[25369.887177] f71882fg f71882fg.656: Fan: 2 is in duty-cycle mode
[25369.887202] f71882fg f71882fg.656: Fan: 3 is in duty-cycle mode

There was no chip id in dmesg logs though.

> If sensors-detect provides the chip name, its ID is recognized.
Here is the f71868a related output from sensors-detect:

Driver `to-be-written':
* ISA bus, address 0x295
Chip `Fintek F71868A Super IO Sensors' (confidence: 9)

Note: there is no driver for Fintek F71868A Super IO Sensors yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

No chip id here either.

> Are you sure the driver doesn't load without force_id ?
> If so, do you see a message in the kernel log ? What does it say ?
> There should be something like
>      f71882fg: Unsupported Fintek device: <hex ID>
> in the log.
>

Does work without force_id.

> No, this is not an auto-loading driver. The kernel does not support auto-loading
> Super-IO chip drivers. In case you wonder: It shouldn't, because Super-IO chip
> detection is not well defined. Running sensors-detect is critical enough; even
> that asks you and says "This is _usually_ safe" (emphasis added). We don't really
> want to do this automatically with every boot.

I didn't know about auto-loading problem with Super-IO chip drivers.
This fact and the faulty output from sensors-detect were the reasons
behind this long convesation. LOL

Thanks a lot for helping me and this information.

Regards,
Fulcrum


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

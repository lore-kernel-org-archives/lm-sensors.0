From: Eric Sandeen <sandeen@sandeen.net>
Date: Mon, 14 Mar 2011 13:38:17 +0000
Subject: Re: [lm-sensors] Fintek F71869FG
Message-Id: <83FDDA3F-65D5-4C53-992F-DC6299287C48@sandeen.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D3B1D27.7010600@klerik.cz>
In-Reply-To: <4D3B1D27.7010600@klerik.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mar 14, 2011, at 4:18 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Eric,
> 
> On Sat, 26 Feb 2011 08:51:47 -0600, Eric Sandeen wrote:
>> I recently got a new motherboard with the F71869FG chip.
>> 
>> Found `Fintek F71869FG Super IO Sensors'                    Success!
>>    (address 0x290, driver `to-be-written')
>> ...
>> Note: there is no driver for Fintek F71869FG Super IO Sensors yet.
>> Check http://www.lm-sensors.org/wiki/Devices for updates.
>> 
>> The wiki says "Waiting for someone with such hardware. Datasheet available."
>> 
>> I'd be happy to test, if the datasheet is available and if the chip doesn't look too hard to support.
>> 
>> I thought about diving into it myself, but someone like Hans will likely be much more efficient ;)
> 
> FYI, Hans just posted a set of patches to the f71882fg driver, one of
> which is adding support for the Fintek F71869FG. You can find a test
> driver at:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2011-March/031751.html

> Great, thanks, will try it!

-Eric

> HTH,
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

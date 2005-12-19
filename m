From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 19 Dec 2005 11:52:24 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <43A69EF8.3000302@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Jim,
>
>  
>
>>I too am partial to this way, less work for me ;-)
>>Patch attached, done against 14.3 + your SENSOR_ATTR patch.
>>    
>>
>
>Are you certain this was the last version of your patch? I'm asking
>because of the name: pc87360-use-sensor-attr-arrays~. Trailing tilde
>usually means backup copy...
>
>  
>
yes, thanks for catching this fat-finger double-tap.
new patch attached.  tested against 14.3, then respun
for rc5-mm3  (kzzalloc)
(my build wont boot - switchroot prob, so I cant test newest yet)

>It took me several seconds to figure out that was me ;) You probably
>know the device as least as good as I do by now, and you have one
>physical device to test on, while I don't. 
>
I thought of all those reasons, (esp the last one)
 but wasnt quite ready to acknowledge them yet.

>I'm awaiting for your
>MAINTAINERS patch :) 
>
now included.

>But of course you are right, I'm still available
>for advice if needed.
>
>Thanks,
>  
>
thank you

-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87360-use-sensor-attr-arrays.patch
Type: text/x-patch
Size: 24185 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051219/5a723585/pc87360-use-sensor-attr-arrays.bin

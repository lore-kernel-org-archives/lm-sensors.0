From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Mar 2009 14:26:50 +0000
Subject: Re: [lm-sensors] ECS GeForce 6100 PM-M2 - labels/calculations
Message-Id: <20090319152650.3f98a596@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49BE37E8.90301@googlemail.com>
In-Reply-To: <49BE37E8.90301@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Thu, 19 Mar 2009 19:39:50 +0530, Charles wrote:
> Thanks for the info, Jean  :-)
> 
> You did intend to mail me rather than the list ... ?

No, I mailed you _and_ the list, as I usually do. You, on the other
hand, omitted the list, which I am adding back...

> Is there an easy way for someone who does not know where cpu0_vid comes from
> to find out if it is static or dynamic?

Unfortunately there is no other reliable way than reading the driver
code (or the datasheet). Some driver might say what type they belong to
in their documentation file, but I don't think they all do.

>  Ideally -- and perhaps in reality
> -- cpu0_vid is stable so the simple fact that it never changes cannot be
> used to determine if it is dynamic or not.  True?

With the advent of CPU frequency scaling, the VID value _does_ often
change: lower frequencies typically need a lower core voltage.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Simon J. Rowe" <srowe@mose.org.uk>
Date: Tue, 19 Mar 2013 21:46:43 +0000
Subject: Re: [lm-sensors] RFC (v2): Intel QST sensor driver
Message-Id: <5148DCC3.6040406@mose.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <51478535.8080107@mose.org.uk> <20130319002724.GA1843@roeck-us.net>
In-Reply-To: <20130319002724.GA1843@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, tomas.winkler@intel.com, linux-kernel@vger.kernel.org

On 19/03/13 00:27, Guenter Roeck wrote:
> Couple of problems I noticed when browsing through the code.
>
> - Some functions return errors with return code 0.
>
> 	if (ret <= 0)
> 		goto out;
> 	...
> out:
> 	return ret;
>
>    For values of 0, the calling code will likely miss the error.
Thanks for your helpful comments.

In some of the low-level code I decided to use return 0 to indicate 
nothing was transmitted. Probably these situations should be regarded as 
an error and -EAGAIN used. I'll check them and fix this.
>
> - In some cases, returned errors are replaced with another error
>
> 	if (ret < 0)
> 		return -EIO;
>
>    You should return the original error.
>
> - Try using something better than -EIO is possible. For example, you can use
>    -EINVAL for invalid parameters.
I'd noticed -EIO was used quite a bit in some existing modules (e.g. 
abitguru3.ko) and thought this was a general convention. I'll switch to 
using the original return codes.
>
> - Don't use strict_str functions. Use kstr functions instead (checkpatch should
>    tell you that, actually).
Ah, I'd run checkpatch on my dev box (which runs 2.6.39), the newer 
source trees do indeed flag this up, I'll fix it.
>
> - Try using dev_ messages as much as possible (instead of pr_)
>
> - Try allocating memory with devm_ functions. This way you can drop the matching
>    calls to kfree().
The client objects don't contain a struct device. Multiple clients have 
a pointer to the underlying supporting device but from what I understand 
of devm_kzalloc() that would defer freeing memory until the device is 
shut down (which only happens on module unload). That could leave an 
increasing amount of memory tied up.
>
> - I notice you use kmalloc() a lot. That is ok if you know that you'll
>    initialize all fields, but it is kind of risky. Better use kzalloc().
>    (if you start using devm_kzalloc, the issue becomes mostly irrelevant,
>    as there is no devm_kmalloc).
>
I'd avoided using kzalloc() when I knew I'd need to initialize members, 
but none of the code is on a hot path and it avoids oversights when new 
members get added.
>> I've added documents that explain the QST protocol and also the design
>> of the driver.
>>
> For my part I like the architecture of your driver. Wonder how difficult
> it would be to implement the functionality supported by the in-kernel driver
> (eg watchdog) with your infrastructure.
The MEI watchdog? that would be quite straightforward to create a module 
for. I had planned to write one but didn't have access to any hardware 
with this function.
>
> Overall it would be great if you and Tomas could get together and come up
> with a unified implementation.
>
>
I'd be happy to help getting a driver that fits everybody's needs. The 
difficult is there are slight differences in approach. From what I can 
see from the QST SDK the kernel driver was written to provide a minimal 
implementation with the majority of the logic in a cross-platform 
userspace library. My driver was aimed at providing a base to make it 
easy to write other kernel modules like the QST one.

There's no reason why an adaptation layer that provides the same 
ioctl()/dev interface as the current Intel driver couldn't be created.

Simon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

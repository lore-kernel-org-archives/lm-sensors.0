From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 18 Jan 2014 19:57:46 +0000
Subject: Re: [lm-sensors] [PATCH RFC] libsensors: Get rid of arbitrary limit on per-type sensor count
Message-Id: <52DADCBA.7030905@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140116142826.36b3cc9c@endymion.delvare>
In-Reply-To: <20140116142826.36b3cc9c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/16/2014 05:28 AM, Jean Delvare wrote:
> When gathering the attributes of each hwmon chip, libsensors uses a
> temporary structure in memory to order and group all the attributes
> into features. This temporary structure used to be a single array with
> room for every possible attribute/subfeature. While simple, this
> approach required to predefine a maximum number of per-type sensor
> that could be handled.
>
> In order to get rid of this arbitrary limit, which we hit and had to
> raise three times already, I changed the temporary structure to an
> array of dynamically allocated per-type subattribute arrays. This lets
> us not allocate any memory for types which aren't implemented by a
> given chip, and more importantly, this lets us reallocate room for
> more attributes of a given type as needed.
>
> I decided to allocate chunks of 8 attributes at a time, as this seemed
> a good compromise between two frequent reallocations and
> over-provisioning. It could be tweaked if needed.
>
> Icing on the cake, I benchmarked this change on two different systems
> and it results in performance gains. The total heap usage as reported
> by valgrind is down by 50% on average, with peak memory consumption
> (as reported by valgrind's massif) also down by 43% on average. The
> total instructions count (as reported by valgrind's callgrind) is down
> by 11% on average, with measured execution time also down by a few
> percents. Valgrind rocks, BTW.
>
> I have some ideas to optimize the memory allocations further, but I do
> not expect such a huge gain from them. They may not even improve peak
> memory consumption as massif shows the peak is somewhere else now at
> least in some cases.
> ---
> Note: this is NOT lm-sensors 3.3.5 material. I'd rather release 3.3.5
> quickly and merge this later. That would make the following lm-sensors
> version 3.4.0 as this is a significant change.
>
> Testing and comments would still be appreciated.
>
Hi Jean,

Looks good to me. Basic testing is ok. I installed it on my main server;
I'll let you know if I hit any problems.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

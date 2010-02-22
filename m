From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 22 Feb 2010 12:24:05 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <4B827765.6070305@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 02/22/2010 10:52 AM, Jean Delvare wrote:

<snip>

>> There is still one important piece missing here though, besides
>> automatically putting a config file in place, we also need to
>> make sure the necessary modules get loaded. IOW we need a metadata
>> keyword to specify which modules the config needs loaded (and with
>> which options if any), and then we need some init script to
>> load these modules (probably the same initscript as the
>> one doing the config file copying, or we could add the necessary
>> entries to /etc/sysconfig/lm_sensors from that script.
>
> Beware that some device ->  driver matching has changed over time, so
> you might have to take the kernel version into account. If you think
> this is overkill, then at least the driver needed for older kernel
> versions should be mentioned in a free comment. Or maybe we can
> introduce a specific syntax for fallback drivers (if the first driver
> doesn't exist then the second is tried... should cover most cases but
> maybe not all.)
>

I think that this new autoconfig stuff will only (mostly) get used in newer
distro's with newer kernels. So I think we can just assume a recent kernel,
and put fallback drivers in a comment.

Still this warrants some thought, as in the future device driver names
may change once more.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

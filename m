From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 23 Mar 2012 14:21:28 +0000
Subject: Re: [lm-sensors] labels for it87 compared to mbmon
Message-Id: <20120323152128.0d8ec2ca@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <jwv1uojmn1f.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
In-Reply-To: <jwv1uojmn1f.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

On Fri, 23 Mar 2012 10:07:55 -0400, Stefan Monnier wrote:
> `xmbmon' gives me 3 temperatures, called MB/CPU/chip.
> `sensors' gives me three temperatures from the `it87' module and those
> temperatures seem to match perfectly the ones I get from xmbmon, but
> their label is just temp1/temp2/temp3.

Hmm, xmbmon, the tool which is no longer developed since, hm, 2008 if
not worse? If you're using that on recent hardware, it's not going to
be very helpful.

> Any reason why lm-sensors uses generic labels?
> 
> 
>         Stefan "I don't know if MB and chip labels are correct, but the
>                 CPU label seems right since it's the one most
>                 susceptible to change under CPU load"

The proper labels are motherboard model dependent. There's no way
xmbmon can guess them. So either they have a database of known
motherboards and your board is in it, or they put random labels that
worked for one board once upon a time, and you're lucky if it also
works on yours.

We (lm-sensors / hwmon kernel drivers) play it safe and don't claim
mappings we're not sure of. We don't know what temperature sensors are
connected to IT87xxF chips in general, and we say exactly that by
naming them just "temp1", "temp2", etc.

Once you have figured out the proper labels, just add them to your
board-specific configuration file in the proper chip section.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

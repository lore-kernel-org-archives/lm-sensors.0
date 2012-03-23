From: Stefan Monnier <monnier@iro.umontreal.ca>
Date: Fri, 23 Mar 2012 17:55:10 +0000
Subject: Re: [lm-sensors] labels for it87 compared to mbmon
Message-Id: <jwv1uojkxvy.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jwv1uojmn1f.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
In-Reply-To: <jwv1uojmn1f.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> `xmbmon' gives me 3 temperatures, called MB/CPU/chip.
>> `sensors' gives me three temperatures from the `it87' module and those
>> temperatures seem to match perfectly the ones I get from xmbmon, but
>> their label is just temp1/temp2/temp3.
> Hmm, xmbmon, the tool which is no longer developed since, hm, 2008 if
> not worse?

That very one, yes.

> If you're using that on recent hardware, it's not going to
> be very helpful.

Don't worry, this hardware is older than the xmbmon binary (itself dated
Mar 16 2008).

> The proper labels are motherboard model dependent. There's no way
> xmbmon can guess them. So either they have a database of known
> motherboards and your board is in it, or they put random labels that
> worked for one board once upon a time, and you're lucky if it also
> works on yours.

I see, so I guess I just got lucky.  That makes sense, thank you,


        Stefan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 09 Jan 2009 15:14:36 +0000
Subject: Re: [lm-sensors] k8temp on K8 rev.F and rev.G: Testers wanted
Message-Id: <496769DC.5050608@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090109160702.466b8a6f@hyperion.delvare>
In-Reply-To: <20090109160702.466b8a6f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi I have revG2 CPU. I will test it.

Rudolf

Jean Delvare wrote:
> Hi all,
>
> I am done reviewing and testing Andreas' k8temp patches. After some
> reorganization I came up with the following stack:
>
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-01-warn-about-errata.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-02-fix-wrong-sensor-selection-for-revf-revg.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-03-fix-temperature-reporting-for-most-revg.patch
>
> These are in linux-next at the moment, and I'd like to push them to
> Linus quickly. But I do not own any rev.F nor rev.G CPU myself, so I
> couldn't really test the patches, other than ensure that they do not
> cause a regression on earlier K8 CPUs.
>
> So this is a call to owners of rev.F and rev.G K8 CPUs, to try these
> patches and report how they are doing. There's also a standalone
> version of the updated driver at:
>   http://jdelvare.pck.nerim.net/sensors/k8temp/
> if it is easier for you.
>
> Thanks,
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

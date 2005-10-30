From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sun, 30 Oct 2005 17:15:59 +0000
Subject: [lm-sensors] 87431 update
Message-Id: <253818670510300815x3d02092dp68647a7630040e3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <435BD852.9040703@mds.gotdns.com>
In-Reply-To: <435BD852.9040703@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Nice work :)

On 10/29/05, Mark Studebaker <mds@mds.gotdns.com> wrote:
> Hmm it's basically working but the fan and temp values aren't read.
> Perhaps there was a sysfs name change in 2.6.13?
> Do you have sensors 2.9.2? (sensors -v)
>

2.6.13 was the whole hwmon moveover. Bmcsensors-26 won't work with
>=2.6.13 at the moment simply because there is no way to register it
as a hwmon class when the IPMI subsystem hasn't got any driver
model/sysfs support. I have a patch that adds the support to IPMI (see
ipmi mailing list/lkml) but I need to update it and send it to Corey
again and I just haven't had the time (university getting in the way).

I'll update the patch (there isn't much to do) and send it in to Corey
next weekend, and then there is a bit of work which I've mostly done
(ipmisensors) to re-write bmcsensors so that it uses hwmon, the new
sysfs callbacks and gets rid of any i2c-ipmi references.

Thanks,
Yani

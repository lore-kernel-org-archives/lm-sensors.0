From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 24 Jul 2007 20:53:46 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707241353p61718f19y89fba1d3d5e0342d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi c.,

The Nehemiah CPU follows the VRM 8.5 spec. But even if you set the VRM
to 8.5 it will not show the right value. I don't think VIA cared to
connected the VID inputs of the vt1211 on the EPIA boards. On my
M10000 they seem to be grounded.

Could you please post the vt1211 section of your /etc/sensors.conf
file and full output when running sensors? My guess is you need to
adjust the compute line to show the correct core voltage.

...juerg



On 7/24/07, cilly <cilly@cilly.mine.nu> wrote:
> Hi all,
>
> I have a problem with vt1211-isa-6000 and VIA EPIA PE 10000 (1GHz),
> the vid is reported as: vid: +1.850 V  (VRM Version 9.1) and VCore:
> +1.22 V. Those values aren't correct, VCore is 1.4 V. I tried to set
> the vid manually, which does not work. Any hints? Thx.
>
> Regards,
>
> c.
>
> PS: sorry, forgot to add the subject
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

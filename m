From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 May 2011 18:58:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix compile error if
Message-Id: <BANLkTikKJNexHcD1AyObrbhDufjFJpNLMw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306177601-8812-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306177601-8812-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Patch looks ok in the sense that it clearly fixes a compile problem,
but can you explain why offlining a core should online the HT
siblings? It makes no sense, since that CPU_DOWN_PREPARE will be sent
to each core, so now they online and offline each other mindlessly.

Also, why does that loop do a "break"? What's wrong with having
multiple HT siblings? What's special about one?

IOW, looking at it, that whole put_core_offline() logic just looks
damn confused to me. Could you explain it, please? Both to me, and
perhaps with a patch explaining the logic with a comment. Because
right now it just looks insane.

                         Linus

On Mon, May 23, 2011 at 12:06 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> cpu_sibling_mask() is not defined unless CONFIG_SMP is defined, so it mus=
t not
> be used directly in the code without ifdef protection.
> To solve the problem and avoid ifdefs in the code, define for_each_siblin=
g()
> and use it instead.
>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Durgadoss R <durgadoss.r@intel.com>
> ---
> =A0drivers/hwmon/coretemp.c | =A0 =A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 5c7cd60..a00245e 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -51,10 +51,12 @@
> =A0#define TO_PHYS_ID(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_data(cpu).p=
hys_proc_id
> =A0#define TO_CORE_ID(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_data(cpu).c=
pu_core_id
> =A0#define TO_ATTR_NO(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(TO_CORE_ID(cpu=
) + BASE_SYSFS_ATTR_NO)
> +#define for_each_sibling(i, cpu) =A0 =A0 =A0 for_each_cpu(i, cpu_sibling=
_mask(cpu))
> =A0#else
> =A0#define TO_PHYS_ID(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(cpu)
> =A0#define TO_CORE_ID(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(cpu)
> =A0#define TO_ATTR_NO(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(cpu)
> +#define for_each_sibling(i, cpu) =A0 =A0 =A0 for (i =3D 0; false; )
> =A0#endif
>
> =A0/*
> @@ -762,7 +764,7 @@ static void __cpuinit put_core_offline(unsigned int c=
pu)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0coretemp_remove_core(pdata, &pdev->dev, in=
dx);
>
> =A0 =A0 =A0 =A0/* Online the HT version of this core, if any */
> - =A0 =A0 =A0 for_each_cpu(i, cpu_sibling_mask(cpu)) {
> + =A0 =A0 =A0 for_each_sibling(i, cpu) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i !=3D cpu) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_core_online(i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> --
> 1.7.3.1
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 17 Jan 2010 21:58:02 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <68676e01001171358g4bc5d34by78db0f3eb9083ac7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 15, 2010 at 6:30 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Luca,
>
> On Fri, 15 Jan 2010 18:11:53 +0100, Luca Tettamanti wrote:
>> On Fri, Jan 15, 2010 at 5:52 PM, Karl Newman <siliconfiend@gmail.com> wrote:
>> > Thanks for looking into this. I've attached my DSDT (dumped via cp
>> > /proc/acpi/dsdt A8N-VM_CSM.DSDT).
>>
>> Ugh. The AKT0110 node is totally empty, nonetheless the hwmon methods
>> are available.
>> The driver is failing because the method used to identify the mobo
>> (MBIF) is missing (and the printk isn't verbose enough).
>> I suppose I could relax the check and probe the interface even if it's
>> not possible to id the board.
>> I'll prepare a patch.
>
> Isn't this similar to the problem (and patch!) reported by Juan RP 3
> days ago?
>
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027606.html

Yes, same problem. I haven't been able to decode MBIF data, so ATM it's unused.
I'll send a patch in reply to this mail. Jean can you please push it
to Linus for .34?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Jan 2010 17:30:08 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <20100115183008.059f7549@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

On Fri, 15 Jan 2010 18:11:53 +0100, Luca Tettamanti wrote:
> On Fri, Jan 15, 2010 at 5:52 PM, Karl Newman <siliconfiend@gmail.com> wrote:
> > The reason I thought there would be some
> > dmesg or syslog entries is that I saw something like that in the mailing
> > list about the ATK0110 (it looked like it was enumerating devices it found).
> > The email didn't say where that text came from, though...
> 
> They comes from the driver, but only when HWMON_DEBUG_CHIP is enabled.
> 
> > Thanks for looking into this. I've attached my DSDT (dumped via cp
> > /proc/acpi/dsdt A8N-VM_CSM.DSDT).
> 
> Ugh. The AKT0110 node is totally empty, nonetheless the hwmon methods
> are available.
> The driver is failing because the method used to identify the mobo
> (MBIF) is missing (and the printk isn't verbose enough).
> I suppose I could relax the check and probe the interface even if it's
> not possible to id the board.
> I'll prepare a patch.

Isn't this similar to the problem (and patch!) reported by Juan RP 3
days ago?

http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027606.html

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

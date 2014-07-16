From: =?UTF-8?Q?Nuno_Magalh=C3=A3es?= <nunomagalhaes@eu.ipp.pt>
Date: Wed, 16 Jul 2014 20:31:18 +0000
Subject: Re: [lm-sensors] incomplete sensors on Asus M2NPV-VM
Message-Id: <CADqA9uZFS7GMW17gq6U_KKN6HE4HobrUBM2_PCXERc5iveKDYA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADqA9uYqmuTQttc-=pSAvhwYuAnR3P+t-68fEQ2tOeuVwG9VFA@mail.gmail.com>
In-Reply-To: <CADqA9uYqmuTQttc-=pSAvhwYuAnR3P+t-68fEQ2tOeuVwG9VFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 16, 2014 at 2:00 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> This means that there's a smbus controller that is used by ACPI so
> it's not safe to use it directly (it87).

So i either stick to ATK0110 and have no information on FAN2; or i use
it87 and risk system instability?
Is there a middle ground?

nForce2_smbus is the southbrige, i'd rather not have instability with
that, since the SATA controller depends on it. Which,come to think of
it, makes me wonder if that isn't causing disks to get dropped at
boot[1].


Thanks,
Nuno

[1] http://marc.info/?l=linux-ide&m0535582932375&w=2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

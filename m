From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 14 Jun 2010 17:25:29 +0000
Subject: Re: [lm-sensors] ITE IT8721F chipset support?
Message-Id: <AANLkTikVXes9j2GSKPur8F0w35oMi9XOq9vFxAYEBu3q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C136536.6010909@powercraft.nl>
In-Reply-To: <4C136536.6010909@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 12, 2010 at 12:45 PM, Jelle de Jong
<jelledejong@powercraft.nl> wrote:
> The real solution would be that the asus_atk0110 module would be able
> to set the PWM values of the iTE chipset.

asus_atk0110 only exists to ensure that there are no concurrent
accesses to the hwmon chip from the firmware and the native driver; as
such it cannot provide more functionalities than what is exposed by
ACPI code.
I mostly understand how the profile based fan control works, but
currently my only asus board is MIA (I'm waiting for a replacement).

> I understeand that the
> ATK0110 is a proprietary solution of ASUS. Could anybody contact ASUS
> and request for specification of the ATK0110

Done that and I wasn't able to go beyond the 1st level tech support
(as expected).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

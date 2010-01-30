From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 30 Jan 2010 14:05:53 +0000
Subject: Re: [lm-sensors] sensors in kernel 2.6.31
Message-Id: <4B643CC1.2000003@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Ah, dan moet je even een mailtje (in het engels) sturen naar:
lm-sensors@lm-sensors.org, met daarin dat de asus_atk0110 driver
niet werkt op jouw moederbord + het model van je moederbord.

Dan reageert de auteur van de asus_atk0110 driver vanzelf. Goed
mogelijk trouwens dat dit al gefixed is in een latere versie,
maar dat zegt hij dan wel.

NB het mengen van acp_enforce_resources=lax met de asus_atk0110 driver
is een erg slecht idee!

MvG,

Hans


On 01/30/2010 05:41 PM, Otto wrote:
> Hoi,
>
> On Sat, 30 Jan 2010, Hans de Goede wrote:
>> Dat ligt aan je moederboard, als de acpi code van je BIOS de resources
>> claimed die de hwmon chips gebruiken, dan biedt die zelfde acpi code
>> hopelijk ook een acpi interface om de chips uit te lezen. Een probleem
>> is dat deze acpi interfaces moederbord fabrikant specifiek zijn.
>> Momenteel hebben we ondersteuning voor de ACPI interface op Asus
>> borden, maar dat is het dan ook.
>
> 'k Snap het. Kan je me een hint geven waar ik verder kan zoeken /
> configureren? Ik heb namelijk een Asus:
>
> root@tommie:~# strings /dev/mem |grep P5
> P5K-V
> root@tommie:~# strings /dev/mem |grep ASUS
> ASUSTeK Computer INC.
>
> Ik heb deze gelezen:
> http://www.pubbs.net/kernel/200908/45460/
>
> en zie dat mijn machine (tommie) die ook geladen heeft:
>
> root@tommie:~# lsmod |grep asus -i
> asus_atk0110 9472 0
>
> maar, blijkbaar toch niet zonder die extra grub/boot optie kan :(.
>
> Otto
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

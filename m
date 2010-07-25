From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 25 Jul 2010 20:09:57 +0000
Subject: Re: [lm-sensors] asus_atk0110 on a p6td deluxe
Message-Id: <AANLkTikKeh50JijBBBbBcgdMJiFdx-R5aChPp_UPVWgR@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
In-Reply-To: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Jul 25, 2010 at 6:40 PM, Marco <jjletho67-ml@yahoo.it> wrote:
> Hi,
> i'm using the asus_atk0110 driver on a asus p6td deluxe mb, Fedora 12, ke=
rnel
> 2.6.32.16-141.fc12.x86_64, sensors 3.1.2
>
> The problem is with the list of sesors i obtain, which i think is incompl=
ete
[cut]
> I expect several more parameter like QPI/DRAM volatge, DRAM bus voltage e=
tc.
>
> Using google i found a lot of users with a similar hardware which can obt=
ain
> more sensors, for example:
>
> http://vip.asus.com/forum/view.aspx?id 090518224331815&board_id=3D1&model=
=3DRampage+II+Gene&page=3D1&SLanguage=3Den-us
> http://swiss.ubuntuforums.org/showthread.php?p=9072795
>
> What can i do to see all the infos ?

The links show the output for the Asus Rampage 2 board, not the P6T.
atk0110 gets the list of the sensors directly from ACPI, and in your
board those readings are not present.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

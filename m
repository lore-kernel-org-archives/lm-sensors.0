From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 12 Jan 2011 14:03:31 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <AANLkTikzBcK1Q=eZxd2dzu944pwo01-8DT3y13Dxyp3S@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 11, 2011 at 3:23 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Tue, Jan 11, 2011 at 3:07 PM, Joris Creyghton <jorisctn@gmail.com> wrote:
>> Both display 4 fan's, they agree about the CPU fan, but the new interface
>> assigns one value to a NB fan (North Bridge =? Memory Control Hub (MCH)).
>> There is no such fan on the Sabertooth board. There are 2 chassis fans and a
>> power fan though.
>
> The names are supplied by the BIOS, so this is another bug.
> HWF2 is named "CHASSIS3" in the old interface and "Power" in the new.
> HWF4 is "POWER" in the old interface but "NB" in the new one.
> They probably swapped the labels... you can try and raise the issue with Asus.

Oh, BTW: is there an updated BIOS for the board? This issue should be
visible also under Windows... I guess someone should have noticed.
It might make sense to let the user override the labels, Jean what do you think?

Joris, can you also send me the output of dmidecode?

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

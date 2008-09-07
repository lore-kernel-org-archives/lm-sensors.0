From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 07 Sep 2008 18:32:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <191fb4ca0809071132h52b929e2oe4987d1fa47bbe2e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Forest,


On Fri, Sep 5, 2008 at 11:45 AM, Forest Bond <forest@alittletooquiet.net> wrote:
> Hi,
>
> On Thu, Jul 10, 2008 at 08:08:16AM +0200, Wilken Gottwalt wrote:
>> Am Montag 07 Juli 2008 19:29:00 schrieb Juerg Haefliger:
>> > > Am Montag 07 Juli 2008 08:11:02 schrieb Juerg Haefliger:
>> > >> >> Wilken, what motherboard is this? Are there any BIOS settings
>> > >> >> (thermal management) that you can play around with? Try different
>> > >> >> thermal management settings and rerun cpuid and check if the thermal
>> > >> >> monitors show up as 'true'.
>> > >> >> I have a cpuid dump from Sergio (C7 on a LN10000 board) and the only
>> > >> >> difference between his dump and yours is that his shows 'true' for
>> > >> >> both thermal monitors. Maybe your BIOS disables these features on
>> > >> >> your CPU.
>> > >> >
>> > >> > It's the Artigo-Box from Via with a PX10000 board
>> > >> > (http://www.via.com.tw/en/products/embedded/artigo/).
>> > >> > No, there are no bios settings dealing with thermal or power
>> > >> > management. There is nothing I can play with. The bios is very
>> > >> > rudimentary.
>
> [...]
>
>> > I'll try to get some answers from VIA but I'm out of ideas. Looks like
>> > your CPU doesn't have those thermal sensors.
>>
>> This is weird, it's a plain C7.
>
> Anybody get anywhere with this?  I'm trying to get some useful data out of the
> Pico-ITX boards as well.

Yes I did receive some information from VIA but I haven't had a chance
yet to fully digest it. From the quick glance that I took, it looks
like there are different C7 models and the thermal sensors are
disabled depending on the model. VIA provided some sample BIOS code
but I need to take a closer look to fully understand it. More later.

...juerg



> Thanks,
> Forest
> --

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 29 Sep 2008 14:58:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <191fb4ca0809290758n36944e9cmed092807e1dd6eba@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Forest,

Well the bottom line is that the value returned in the EAX register
(0xC000002) is zero for all of these cases where people report 0 C CPU
temp. I haven't had the time yet to figure out what is different about
these CPUs and why they don't seem to adhere to the spec that I have.
One possibility is that my spec is old and things changed in the
meantime and another one is that the BIOS disables the thermal diodes
in the CPU. I have some sample BIOS code from VIA which does that but
I haven't had the time yet to figure out if that applies in this case.

...juerg


On Sat, Sep 27, 2008 at 1:57 PM, Forest Bond <forest@alittletooquiet.net> wrote:
> Hi Juerg,
>
> On Sun, Sep 07, 2008 at 11:32:17AM -0700, Juerg Haefliger wrote:
>> On Fri, Sep 5, 2008 at 11:45 AM, Forest Bond <forest@alittletooquiet.net> wrote:
>>> On Thu, Jul 10, 2008 at 08:08:16AM +0200, Wilken Gottwalt wrote:
>>>> Am Montag 07 Juli 2008 19:29:00 schrieb Juerg Haefliger:
>>>>>> Am Montag 07 Juli 2008 08:11:02 schrieb Juerg Haefliger:
>>>>>>>> It's the Artigo-Box from Via with a PX10000 board
>>>>>>>> (http://www.via.com.tw/en/products/embedded/artigo/).
>>>>>>>> No, there are no bios settings dealing with thermal or power
>>>>>>>> management. There is nothing I can play with. The bios is very
>>>>>>>> rudimentary.
>
> [...]
>
>>>>> I'll try to get some answers from VIA but I'm out of ideas. Looks like
>>>>> your CPU doesn't have those thermal sensors.
>>>>
>>>> This is weird, it's a plain C7.
>>>
>>> Anybody get anywhere with this?  I'm trying to get some useful data out of the
>>> Pico-ITX boards as well.
>>
>> Yes I did receive some information from VIA but I haven't had a chance
>> yet to fully digest it. From the quick glance that I took, it looks
>> like there are different C7 models and the thermal sensors are
>> disabled depending on the model. VIA provided some sample BIOS code
>> but I need to take a closer look to fully understand it. More later.
>
> Just following up.  Anything new to report here?  Can I do anything to help get
> this moving?
>
> Thanks,
> Forest
> --
> Forest Bond
> http://www.alittletooquiet.net
> http://www.pytagsfs.org
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFI3p5ARO4fQQdv5AwRAqquAJ4/oa5K/MORHW/7UJCXjMHVlIg78ACgnzjr
> GLguLdY0Yb80I+ZFGL/BeRI> =o0oK
> -----END PGP SIGNATURE-----
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

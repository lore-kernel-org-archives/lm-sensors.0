From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 09 Jul 2008 17:00:47 +0000
Subject: Re: [lm-sensors] sensors on dell inspiron 1420
Message-Id: <191fb4ca0807091000u3c4b5b3ew14667fde7ad1d32c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080607135219.GD18192@grulicueva.homelinux.net>
In-Reply-To: <20080607135219.GD18192@grulicueva.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcos,

Sorry for the late reply.


> On Wed, Jun 11, 2008 at 03:39:43PM -0700, Juerg Haefliger wrote:
>> Hi Marcos,
>> OK I'm fishing now. Can you try:
>> isadump 0x910 0x911
>
> mdione@mustang:~$ sudo isadump 0x910 0x911
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x910 and data register 0x911.
> Continue? [Y/n]
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 1f 00 00 07 00 00 00 04 00 01 00 01 32 37 38 34
> 90: 02 00 00 00 80 00 00 08 00 00 00 00 00 00 00 43
> a0: 00 01 00 64 00 00 28 31 ec 13 de 0b 0a 47 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>    looks promising...

Can you run 'isadump 0x910 0x911' when the system is idle and also
when it's loaded (with cpuburn for example)?

...juerg



>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

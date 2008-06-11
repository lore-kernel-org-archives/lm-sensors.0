From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 11 Jun 2008 22:39:43 +0000
Subject: Re: [lm-sensors] sensors on dell inspiron 1420
Message-Id: <191fb4ca0806111539j1bb4fb57nde3dbf0740f8bfc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080607135219.GD18192@grulicueva.homelinux.net>
In-Reply-To: <20080607135219.GD18192@grulicueva.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcos,


> On Mon, Jun 09, 2008 at 10:02:44AM -0700, Juerg Haefliger wrote:
>> There seems to be something here. Can you run:
>> isadump -f 0x910
>
>    hmm, seems like a dead end:
>
> mdione@mustang:~/src/projects/twismtpy$ sudo isadump -f 0x910
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address range 0x900 to 0x9ff.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 0900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0910: 91 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0920: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0930: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0940: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0950: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0960: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0970: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0990: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 09a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 09b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 09c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 09d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 09e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 09f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


OK I'm fishing now. Can you try:
isadump 0x910 0x911

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

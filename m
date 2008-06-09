From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 09 Jun 2008 17:02:44 +0000
Subject: Re: [lm-sensors] sensors on dell inspiron 1420
Message-Id: <191fb4ca0806091002s7fffeef6pb4d301664797b8d3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080607135219.GD18192@grulicueva.homelinux.net>
In-Reply-To: <20080607135219.GD18192@grulicueva.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 7, 2008 at 9:08 PM, Marcos Dione <mdione@grulic.org.ar> wrote:
> On Sat, Jun 07, 2008 at 12:42:32PM -0700, Juerg Haefliger wrote:
>> Please run the following commands and send the output:
>> isadump -k 0x55 0x2e 0x2f 0x8
>> isadump -k 0x55 0x2e 0x2f 0x9
>> isadump -k 0x55 0x2e 0x2f 0xa
>
> mdione@mustang:~/src/system/kde4$ sudo isadump -k 0x55 0x2e 0x2f 0x8
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 8 using bank register 0x07.
> Continue? [Y/n] y
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 32 01 00 00 00 04 2e 00 00 00 00 00 00 00 00 00
> 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 62 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> mdione@mustang:~/src/system/kde4$ sudo isadump -k 0x55 0x2e 0x2f 0x9
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 9 using bank register 0x07.
> Continue? [Y/n]
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 32 01 00 00 00 04 2e 00 00 00 00 00 00 00 00 00
> 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 09 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

There seems to be something here. Can you run:
isadump -f 0x910

...juerg



> mdione@mustang:~/src/system/kde4$ sudo isadump -k 0x55 0x2e 0x2f 0xa
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 10 using bank register 0x07.
> Continue? [Y/n]
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 32 01 00 00 00 04 2e 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>> If you can run Windows on this machine, please run SpeedFan
>> (http://www.almico.com/sfdownload.php), it might tell us what chip
>> this is.
>
>    sorry, juerg, no windows here. I hope this is enough.
>
> --
> (Not so) Random fortune:
> I'm no longer the man I pretended to be.
>            -- http://www.unitedmedia.com/comics/arlonjanis/index.html
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

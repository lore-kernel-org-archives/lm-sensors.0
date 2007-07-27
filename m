From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 27 Jul 2007 01:53:37 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707261853y1c03e3c6ub77981cfbf2fcdd7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/26/07, cilly <cilly@cilly.mine.nu> wrote:
> On Jul 27, 2007, at 1:10 AM, Juerg Haefliger wrote:
>
> > can you send the output of 'isadump -y -f 0x6000 0x80'?
>
> isadump -y -f 0x6000 0x80
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08
> 6010: 03 10 0d bf 24 06 af 82 00 00 00 00 02 ff 00 6d
> 6020: 70 bf c1 78 bd c4 c9 7f 00 00 00 ce ba 7b 74 ce
> 6030: a9 d6 af d4 c0 72 07 14 7b ff 00 ff ff c9 b6 b0
> 6040: 01 00 00 ff ff e0 ff 50 2d 45 03 55 55 00 0f 00
> 6050: 01 00 00 00 00 00 ff ff ff ff ff ff 00 77 11 33
> 6060: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> This output is from a freshly bootet system.

Is this with a fan attached? It looks like it's not spinning. And what
does 'sensors' report?


...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

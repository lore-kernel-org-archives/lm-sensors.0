From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 26 Jul 2007 23:10:46 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707261610n7d0ce05cq99012078ec98d25a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Jul 27, 2007, at 12:00 AM, Juerg Haefliger wrote:
>
> > The fan is not spinning?
> > What if you bump the values to 255?
>
> no chance, fan is off
>

can you send the output of 'isadump -y -f 0x6000 0x80'?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, 11 Feb 2014 07:32:57 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,

You're likely to get better help by contacting the LM sensors mailing list
(cc'ed). I've been out of it for a bit.


> Dear Juerg,
>
> I keep getting Errors of this kind:
>
> Feb 10 09:51:09 wegc203094 kernel: [  156.372033] dme1737 1-002c: Read
> from register 0x6d failed! Please report to the driver maintainer.
> Feb 10 09:53:09 wegc203094 kernel: [  276.472043] dme1737 1-002c: Read
> from register 0x69 failed! Please report to the driver maintainer.

Can you post all messages from the driver from the time it was loaded?
What's the model of the machine you're using?
What do you get when running the sensors-detect script?

...Juerg


>
> uname -a
> Linux wegc203094 3.2.0-4-686-pae #1 SMP Debian 3.2.54-2 i686 GNU/Linux
>
> Best,
> J=FCrgen
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

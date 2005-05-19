From: ljubo108@vip.hr (Ljubomir Bozic Jr.)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <200309151951.45652.ljubo108@vip.hr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> My driver init code explicitely *stops* the chipset. No wonder you don't
> see the values changing... Stupid me. That's fixed in CVS, if you were
> kind enough to give it a try and tell me if it now works OK for you.
>

lm90 is working now:-))

Unfortunately I have new problems.
I cant execute sensors -s, I'm getting this:

[root@localhost etc]# sensors -s
it87-isa-0290: Can't access /proc file for writing;
Run as root?

I've never had problems with sensors -s before.

and the other possible problem is this:
sensors-detect advises to put adm1021 in modules, when I do that on boot it 
crashes my machine. Well, I exclude adm1021 from modules, it seems that I 
don't nedd it anyway but I wanted to report this because it did not hapenned 
before and I think I've had it before in my modules file.

If you need any other report from me I'm at your service.

Thank you very much for your work.

Best regards, Ljubo
Croatian LUG

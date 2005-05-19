From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: i2c-isa
Message-Id: <000501c33f0c$9b7ca320$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33f09$69546520$f265a8c0@gf01>
In-Reply-To: <000801c33f09$69546520$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



>
> > Hi, sorry for my questions but, i compiled and installed i2c-2.7.0 and
> > dont install i2c-isa.o....
> >
> > Thx
>
> It most probably has. Run "depmod -ae" (as root) to update your module
> dependencies, and your system will see the file again.


    no, when doing 'make;: make install' for i2c-2.7.0 dont compile any
i2c-isa, where i can get it?

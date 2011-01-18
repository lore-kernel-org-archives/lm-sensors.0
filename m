From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 18 Jan 2011 14:40:00 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <AANLkTi=DMGX1Jnt_C1JmjdBvGLr7kN3XiAnd3hT3b3y0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 17, 2011 at 9:17 PM, Joris Creyghton <jorisctn@gmail.com> wrote:
> It's working fine.

Excellent :) I'll send a patch upstream.

>
> I have looked into your source and would like to suggest to change the
> comment in line 33, which reads:
>
>     /* Old interface has broken fan monitoring */
>
> The main problem with the old interface was that it didn't communicate the
> MCH temperature.

Yes, it was a thinko on my part :-)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

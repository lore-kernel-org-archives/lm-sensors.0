From: Luca <kronos.it@gmail.com>
Date: Mon, 30 Jul 2007 13:22:45 +0000
Subject: Re: [lm-sensors] w83627dhg and coretemp temperature mismatch?
Message-Id: <68676e00707300622u2e75fc23y53cb91e108cb313a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1185800852.23876.91.camel@pancake>
In-Reply-To: <1185800852.23876.91.camel@pancake>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/30/07, Florian Echtler <echtler@in.tum.de> wrote:
> As I have a passively-cooled CPU, I am a bit nervous about temperatures,
> so I'm curious if somebody can explain the difference (and which one is
> closer to reality ;-).

The w83627dhg chip reads the temperature from a sensors which is put
somewhere near (under?) the socket of the CPU. coretemp reads the two
sensors inside the CPU.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

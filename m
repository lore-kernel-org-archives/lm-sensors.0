From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 29 Jan 2007 18:41:03 +0000
Subject: [lm-sensors] VT1211 at 0x4e/0x4f
Message-Id: <191fb4ca0701291041y4996a95asea35ae3b2d0a9f26@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070128202713.a60b89a0.khali@linux-fr.org>
In-Reply-To: <20070128202713.a60b89a0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Will do.

...juerg


On 1/28/07, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Juerg,
>
> As almost all Super-I/O chips, the VT1211 can live at two different
> address pairs, 0x2e/0x2f or 0x4e/0x4f. The vt1211 driver only supports
> the former at the moment. Some systems use the latter though:
> http://www.lm-sensors.org/ticket/2149
>
> Could you please add support for the second address? It shouldn't be
> too difficult, you can simply turn SIO_REG_{CIP,DIP} into global
> variables and run vt1211_find() twice, once with each possible address
> pair. The w83627hf, f71805f, pc87360 and pc87427 drivers do it that way
> already.
>
> Thanks,
> --
> Jean Delvare
>


From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Wed, 06 Jun 2007 18:39:52 +0000
Subject: Re: [lm-sensors] 2.6.22-rc4-mm1 -- ERROR:
Message-Id: <d120d5000706061139s6db7b872t188b5a5ed4de5bfb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
In-Reply-To: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/6/07, Miles Lane <miles.lane@gmail.com> wrote:
> # CONFIG_INPUT_MISC is not set

Doesn't kconfig select prerequesites of a "select"ed symbol? If it
does not I'd consider this a bug.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

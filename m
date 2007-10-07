From: "Yani Ioannou" <yani.ioannou@gmail.com>
Date: Sun, 07 Oct 2007 14:14:33 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <253818670710070714r1a7ee116ib1c2ba8008f70941@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/5/07, Jean Delvare <khali@linux-fr.org> wrote:

> Ah, yes. The sysfs interface standard in Linux 2.6 states that
> temperatures are exported in 10^-3 degrees C, while I seem to remember
> that the ipmisensors driver exports the values in 10-^2 degrees C (as
> was done in Linux 2.4). There was a hack in libsensors to deal with
> this deviation from the standard, which I removed while fixing the
> indexing issue. So ipmisensors will have to be fixed to stick to the
> standard interface.
Oops, good to know, I can change that. :)

Yani

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

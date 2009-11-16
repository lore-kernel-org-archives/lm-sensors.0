From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Nov 2009 09:23:55 +0000
Subject: Re: [lm-sensors] ASUS P6T, 2.6.31-14, no pwm devices
Message-Id: <20091116102355.7833ef3a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
In-Reply-To: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 15 Nov 2009 23:08:01 +0100, Reinhard Nissl wrote:
> Hi,
> 
> Am 15.11.2009 22:53, schrieb Jean Delvare:
> 
> >> Looks like gkrellm doesn't use libsensors so the location matters
> >> until it supports both locations too.
> > 
> > Recent versions of gkrellm (2.3.1 and later) do support libsensors, if
> > built properly.
> 
> openSUSE 11.2 provides 2.3.1. Changelog says, they upgraded to
> 2.3.1 about 2 years ago. But ldd /usr/gkrellm doesn't mention
> libsensors, although openSUSE 11.2 provides both v3 and v4.
> 
> So, looks like poor me is using a gkrellm without libsensors support.

Indeed. I've just tested with openSUSE 11.1 and I see the same, ldd
doesn't list libsensors and the sensor labels suggest libsensors isn't
used. It is odd that nobody noticed so far.

Would you please report this bug on bugzilla.novell.com?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

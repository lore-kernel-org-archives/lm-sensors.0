From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 07 Mar 2014 07:55:31 +0000
Subject: Re: [lm-sensors] Unsupported Mobo Driver
Message-Id: <20140307085531.3e52a07f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAPgPpwTJKhVA=p+pX_SrBKev4o=cjcEjV3=OS7jmRt-EY6txg@mail.gmail.com>
In-Reply-To: <CAAPgPpwTJKhVA=p+pX_SrBKev4o=cjcEjV3=OS7jmRt-EY6txg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Howard,

On Thu, 6 Mar 2014 17:27:05 -0800, Howard Nguyen wrote:
> Hi lm-sensors,
> 
> I have a Lenovo U410 and I'm trying to offset my CPU temperatures which I
> strongly believe to be much higher than reality. There is no mobo driver
> support for my vendor so I tried creating my own config in etc/sensors.d/
> following this guide:
> 
> https://wiki.archlinux.org/index.php/lm_sensors
> 
> Sadly it seems I have no idea what I'm doing since everything I do fails.
> It says "Parse error in chip name" (in reference to
> "pkg-temp-0-virtual-0").

Not your fault, this is a bug in that driver, which exposes a name that
does not stick to what libsensors expects. I have already sent patches
to the maintainers:
http://marc.info/?l=linux-pm&m9376915925089&w=2
http://marc.info/?l=linux-pm&m9377084225460&w=2

Unfortunately no feedback from the maintainers yet, I'll ping them.

In the meantime, just do not include any configuration statement for
that device in your libsensors configuration file. That device is
redundant with coretemp anyway, so it doesn't have any value as far as
hardware monitoring is concerned.

> Do you have any advice / guidance for me? Anything would be greatly
> appreciated! Thanks!

Well, it's hard to tell you what to change when we don't know exactly
what you think the problem is, nor what you tried so far. So please
provide:

* The output of "sensors -c /dev/null".
* The output of "sensors".
* The contents of your current custom confiration file.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

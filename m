From: Guillaume Millet <gmillet@crans.org>
Date: Mon, 14 May 2007 09:58:25 +0000
Subject: Re: [lm-sensors] w83627hf.c pwm frequency patch
Message-Id: <f29bs2$hp3$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <bj0b43lnno3l4t105008r2ou1uan2e4u5c@4ax.com>
In-Reply-To: <bj0b43lnno3l4t105008r2ou1uan2e4u5c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi

com.ea a =E9crit :
Does someone want to test it?

I tested with *sucess* your driver, compiled with 2.6.20-15-generic=20
kernel headers (ubuntu feisty), for my w83697hf chip.

Some remarks.
Under Windows, MSI proposes CoreCenter utility which has two modes,=20
either auto (maybe "thermal cruise" or "fan speed cruise" mode) either=20
fix with 8 levels. With SpeedFan, I noted pwm#_freq that CoreCenter=20
associates with a fix level and the range of fan rpm :

level pwm1_freq(kHz) fan rpm    pwm1
8/8   93.8           2678-2721  128-255
7/8   93.8           2596-2636  32-64
6/8   93.8           2481-2518  5-8
5/8   46.9           2250-2311  2
4/8   31.1           2163-2191  1
3/8   18.8           1939-2008  1
2/8   11.7           1776-1834  1
1/8   6.3                <1520  1

I wrote on the right the pwm on lm_sensors that gives about the same fan=20
rpm.
Lastly, under 1520 rpm, fan1_input is wrong (the same under Windows).

Regards,
Guillaume


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

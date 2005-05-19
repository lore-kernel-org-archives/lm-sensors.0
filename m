From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: LM83 driver
Message-Id: <3F19E82E.2080409@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
>>- You could have done one /proc callback function rather than 4
> 
> 
> Hm, how do I know who's calling me then? Using ctl_name and the
> LM83_SYSCTL_* constants defined earlier? I don't exactly see the
> interest yet. Though the functions are similar, most of the code really
> depend on the sensor, so I don't think we'll win in clarity nor code
> size. But maybe it's just me. Where could I look at a similar situation
> in our code?
> 


See w83781d_pwm() in w83781d.c which uses subtraction to convert the SYSCTL number
to PWM number, and the W83781D_REG_PWM macro which indexes into a static array of
register numbers.

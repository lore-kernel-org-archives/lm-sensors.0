From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 05 Mar 2010 16:19:03 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Get TjMax value from
Message-Id: <68676e01003050819s4e4ba683w25f7ef8b06f12151@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305153811.GB15945@owl>
In-Reply-To: <20100305153811.GB15945@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 5, 2010 at 4:38 PM, Huaxu Wan <huaxu.wan@linux.intel.com> wrote:
> The MSR IA32_TEMPERATURE_TARGET contains the TjMax value after the i series
> processers.
[...]
> +               printk_once(KERN_WARNING DRVNAME  " : Unable to read TjMax from CPU, an"
> +                       " assumption value is used! \n");
[...]
> +       } else {
> +               val = (eax >> 16 ) & 0xff;
> +               /* If the TjMax is not reasonable, an assumption value

Hi,
I'm not a native speaker but "assumption value" doesn't seem correct to me.
"assumed value" maybe? Or even better (IMHO) "default value"?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

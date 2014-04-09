From: "montjoie.mailing" <montjoie.mailing@gmail.com>
Date: Wed, 09 Apr 2014 13:28:40 +0000
Subject: Re: [lm-sensors] Allwinner A10/20 SOC
Message-Id: <53454B08.3020407@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <32540917-CC57-4956-8573-8E64F559486F@gmail.com>
In-Reply-To: <32540917-CC57-4956-8573-8E64F559486F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/09/14 11:38, Dawid van Wyngaard wrote:
> Hi,
>
> Maybe this is already on the table, but is there anything planned for the above mentioned chipset?
>
> Regards,
>
> Dawid van Wyngaard
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

You have two temperature sensor on the A20 SoC. (one in the AXP209 chip and one in the touchscreen controller).

For mainline kernel, you have to wait that the touchscreen driver and the axp20x driver would be merged.
You could get its from http://linux-sunxi.org/Linux_mainlining_effort

Regards,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

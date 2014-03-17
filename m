From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Mar 2014 00:36:13 +0000
Subject: Re: [lm-sensors] hp dc7900
Message-Id: <5326437D.9090807@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <53220AB5.8010809@sojka.co>
In-Reply-To: <53220AB5.8010809@sojka.co>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/16/2014 03:13 PM, Rudolf Marek wrote:
> Hi all,
>
> According to technical reference guide the SIO is responsible for temp monitoring and it is that WPCD376H chip. Also there is a mention of some BIOS call to get temp status (using real/prot mode call)
>
> http://static.highspeedbackbone.net/pdf/HP%20Compaq%20dc7900%20Series%20Business%20PC%20Service%20Hardware%20Reference%20Guide.pdf
>
> Possibly way would be to reverse engineer the call to see what is going on. But this is just a start of uncertain journey.
>

I asked Nuvoton for a datasheet. Worst case we won't get one,
so I thought it is at least worth a try.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

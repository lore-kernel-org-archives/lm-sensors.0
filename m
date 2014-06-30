From: Iain Paton <ipaton0@gmail.com>
Date: Mon, 30 Jun 2014 16:19:34 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (hih6130) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53B18E16.9020507@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404024354.10911.1.camel@phoenix>
In-Reply-To: <1404024354.10911.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 29/06/14 07:45, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Tested-by: Iain Paton <ipaton0@gmail.com>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

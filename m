From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Oct 2008 20:50:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/adm1029 Use mask for fan_div value
Message-Id: <20081013225029.2bf2cf7a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48F3A551.1050705@geomatys.fr>
In-Reply-To: <48F3A551.1050705@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Oct 2008 21:45:21 +0200, corentin.labbe wrote:
> Hello
> 
> This is my patch for testing correct values of fan div in adm1029 and
> prevent a division by 0 for some (unlikely) register values.
> 
> 
> Signed off by LABBE Corentin <corentin.labbe@geomatys.fr>

Patch applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

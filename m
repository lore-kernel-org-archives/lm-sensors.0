From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Jul 2007 16:47:41 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070719184741.69da8f9f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Vadim,

On Sat, 14 Jul 2007 16:23:16 +0200, Vadim Zeitlin wrote:
> # grep . temp?_input
> temp1_input:0
> temp2_input:228000
> temp3_input:59000
> temp4_input:54000
> temp5_input:226000
> temp6_input:228000
> temp7_input:58000
> temp8_input:54000
> temp9_input:49000

Thanks for this tip. I've always wondered how to easily list sysfs
files and their content all at once, and this grep trick works really
well :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

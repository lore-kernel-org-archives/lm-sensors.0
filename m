From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 25 May 2007 12:17:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon-vid: Don't spam the logs when VRM
Message-Id: <4656D3BF.6010907@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070525141552.694337fc@hyperion.delvare>
In-Reply-To: <20070525141552.694337fc@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> If we cannot guess which VRM version the CPU uses, we set it to 0 and
> log it. So we shouldn't spam the log each time vid_from_reg() is
> later called with vrm 0.
>   

Ack.

Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

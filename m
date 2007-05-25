From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 11:54:12 +0000
Subject: Re: [lm-sensors] [PATCH] hdaps - switch to using input-polldev
Message-Id: <20070525135412.3ea6e2e3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200705250038.35585.dtor@insightbb.com>
In-Reply-To: <200705250038.35585.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dmitry,

On Fri, 25 May 2007 00:38:34 -0400, Dmitry Torokhov wrote:
> Not tested - no hardware...

Neither do I. Please send these patches to the maintainers of the
affected drivers, I don't think they are reading the lm-sensors list
(which wasn't the best list for these patches anyway, as they affect
the input functions, not the hardware monitoring functions):

hdaps -> Robert Love
ams -> Stelian Pop
applesmc -> Nicolas Boichat

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

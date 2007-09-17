From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Sep 2007 11:25:53 +0000
Subject: Re: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <20070917132553.2aa33ead@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070906130600.028cf7f5@hyperion.delvare>
In-Reply-To: <20070906130600.028cf7f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sun, 9 Sep 2007 16:30:51 +0200, Krzysztof Helt wrote:
> The patch below adds support for the 2.6 thmc50 and adm1022 to the lmsensors.
> 
> Feel free to fix any shortcomings of the patch.

Patch applied, thanks for your contribution. I've dropped the printing
of the misc features as the new libsensors won't support that and I
don't want users to feel that this is a regression.

Krzysztof, can you please send me (in private) a dump of your chip (as
returned by i2cdump)? I'd like to add it to my collection so that I can
emulate this chip with i2c-stub.

Philippe, you can fetch the SVN head of lm-sensors and give it a try
now. It should display your temperatures nicely.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

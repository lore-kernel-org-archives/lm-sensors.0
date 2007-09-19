From: Philippe Michiels <philippe@michiels.nu>
Date: Wed, 19 Sep 2007 12:01:29 +0000
Subject: Re: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <d7de6f37bd582c489cc58a506ee265fb@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070906130600.028cf7f5@hyperion.delvare>
In-Reply-To: <20070906130600.028cf7f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org


Hey Jean, Krzysztof,



Isengard:~/lm-sensors-r4800-20070918# sensors

adm1022-i2c-0-2e

Adapter: SMBus I801 adapter at fc00

temp:        +22Â°C  (low  =  -128Â°C, high =  +127Â°C)  

remote_temp:

             +32Â°C  (low  =  -127Â°C, high =   +59Â°C)  

remote_temp2:

              +0Â°C  (low  =    +0Â°C, high =    +0Â°C)  



Isengard:~/lm-sensors-r4800-20070918# sensors -v

sensors version 2.10.4-SVN with libsensors version 2.10.4-SVN



Am I using the right version here ?



Regards,



Philippe



On Mon, 17 Sep 2007 13:25:53 +0200, Jean Delvare <khali@linux-fr.org>

wrote:

> Hi Krzysztof,

> 

> On Sun, 9 Sep 2007 16:30:51 +0200, Krzysztof Helt wrote:

>> The patch below adds support for the 2.6 thmc50 and adm1022 to the

> lmsensors.

>>

>> Feel free to fix any shortcomings of the patch.

> 

> Patch applied, thanks for your contribution. I've dropped the printing

> of the misc features as the new libsensors won't support that and I

> don't want users to feel that this is a regression.

> 

> Krzysztof, can you please send me (in private) a dump of your chip (as

> returned by i2cdump)? I'd like to add it to my collection so that I can

> emulate this chip with i2c-stub.

> 

> Philippe, you can fetch the SVN head of lm-sensors and give it a try

> now. It should display your temperatures nicely.

> 

> --

> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

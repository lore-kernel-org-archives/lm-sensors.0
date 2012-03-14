From: David Kremer <david.kremer.dk@gmail.com>
Date: Wed, 14 Mar 2012 14:23:26 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <4F60A9DE.6090002@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 14/03/2012 14:55, Guenter Roeck wrote:
> Most likely
>
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
>
Thank you guenter.

However, there is no clear explanation of how to fix this.

Indeed, I load the linux module asus_atk0110 and ran again sensors-detect.

The script ended up saying that the following modules was needed :

Driver `w83627ehf':
   * ISA bus, address 0x290
     Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)

Driver `coretemp':
   * Chip `Intel digital thermal sensor' (confidence: 9)

However, there is still no way to load w83627ehf as I read your link.

What do you think of this ?

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

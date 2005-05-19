From: pierre_aussaguel@yahoo.fr (Pierre AUSSAGUEL)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Problmem report
Message-Id: <3EECB538.5010109@yahoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EEB9F68.4040308@yahoo.fr>
In-Reply-To: <3EEB9F68.4040308@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>
> Should be, unless Mandrake used the patched-kernel possibility (in which
> case i2c is included in the kernel, so to say). Please make sure
> however, using the following command:
> rpm -qa | grep i2c
> (and you can also try the same for "sensors", just in case)
>
no answer for i2c

For sensors :
ksensors-0.7.2-4mdk
liblm_sensors1-2.7.0-2mdk
lm_sensors-2.7.0-2mdk


> You can also check from which package do i2cdump and i2cdetect come
> from, providing they're installed on your system.
> 
I do have i2cdump, i2cdetect, and i2cset.
package , they all come form lm_sensors

-- 
Pierre AUSSAGUEL
ACHROME photographies : http://www.geocities.com/pierre_aussaguel/

"Linux, cause rebooting is for adding new hardware"

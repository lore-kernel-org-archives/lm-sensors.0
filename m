From: "Frank Phillips" <frankalso@gmail.com>
Date: Tue, 15 Jul 2008 20:03:34 +0000
Subject: Re: [lm-sensors] temperature monitor
Message-Id: <78171f0a0807151303y4967ee48x75fc25f918cc60ef@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <487CCD71.8000909@GMail.COM>
In-Reply-To: <487CCD71.8000909@GMail.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 15, 2008 at 11:16 AM, Agile Aspect <agile.aspect@gmail.com> wrote:
> Hi - I'm new to lm_sensors and I'm trying to monitor the temperature on
> a 8 CPU (Intel Xeon CPU X5460  @ 3.16GHz) running CentOS 4.4
> (2.6.9-42.ELsmp.)

Most likely your lm_sensors package predates your motherboard and CPU.
A common problem for CentOS users.
Try running this:

http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

It should tell you you need coretemp, fb-dimm, and maybe ipmisensors.

Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

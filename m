From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 09:34:13 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] k8temp add support for family 10h
Message-Id: <20081118093413.GH12095@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F7B6.4000901@assembler.cz>
In-Reply-To: <48E3F7B6.4000901@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 10, 2008 at 10:34:10AM +0100, Jean Delvare wrote:
> On Thu, 02 Oct 2008 00:20:38 +0200, Rudolf Marek wrote:
> > What do you think?
> 
> Looking at your patch, there doesn't seem to be much in common between
> the family 0Fh and the family 10h. The temperature conversion formula
> is different, the registers are different... And I seem to understand
> that the family 10h has a single sensor? In the end your patch is
> larger than the k8temp driver itself. So I am wondering, does it really
> make sense to support both families with the same driver?

IMHO this makes sense. The user just needs to switch on
CONFIG_SENSORS_K8TEMP on a system with newer AMD CPUs (regardless
whether the CPU is family 0xf, 0x10 or 0x11) and the driver is able to
handle the CPU temperature sensor.

It's the same with powernow-k8. This cpufreq driver is used for all
newer AMD CPU families as well.


Regards,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Frank Phillips" <frankalso@gmail.com>
Date: Tue, 23 Oct 2007 22:42:53 +0000
Subject: Re: [lm-sensors] sensors report all zero readings on Dell PowerEdge
Message-Id: <78171f0a0710231542p75f4c13enee2ccbe31f4bc9d4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <471C8AA4.7090903@optusnet.com.au>
In-Reply-To: <471C8AA4.7090903@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/22/07, Greg Vickers <daehenoc@optusnet.com.au> wrote:
> Hi,
>
> I have installed lm-sensors v2.10.1-3 on a Dell PowerEdge 830 with
> Debian Etch (stable) installed on it.  (This version is the version of
> lm-sensors that is part of Debian Etch.)  sensors-detect works and
Try running a more recent version of the script:

http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?revI66&format=txt

By looking at the specs, the Poweredge 830 is an IPMI-controlled
machine. The Baseboard Management Controller controls all the sensors.
You will need support in your kernel for IPMI and ipmisensors. The
patch for ipmisensors is here if it is not already in your distro
kernel (CONFIG_SENSORS_IPMI):

http://bmcsensors-26.sourceforge.net/

> Thanks,
> Greg

Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

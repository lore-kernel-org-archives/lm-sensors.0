From: Greg Vickers <daehenoc@optusnet.com.au>
Date: Wed, 24 Oct 2007 10:29:19 +0000
Subject: Re: [lm-sensors] sensors report all zero readings on Dell PowerEdge
Message-Id: <471F1E7F.9070907@optusnet.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <471C8AA4.7090903@optusnet.com.au>
In-Reply-To: <471C8AA4.7090903@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Frank Phillips wrote:
> On 10/22/07, Greg Vickers <daehenoc@optusnet.com.au> wrote:
>> Hi,
>>
>> I have installed lm-sensors v2.10.1-3 on a Dell PowerEdge 830 with
>> Debian Etch (stable) installed on it.  (This version is the version of
>> lm-sensors that is part of Debian Etch.)  sensors-detect works and
> Try running a more recent version of the script:
> 
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?revI66&format=txt

I ran that script and it didn't detect any extra modules apart from the 
ones that I have already loaded.

> By looking at the specs, the Poweredge 830 is an IPMI-controlled
> machine. The Baseboard Management Controller controls all the sensors.
> You will need support in your kernel for IPMI and ipmisensors. The
> patch for ipmisensors is here if it is not already in your distro
> kernel (CONFIG_SENSORS_IPMI):

Huh, CONFIG_SENSORS_IPMI is not present in 2.6.18 on Debian.

> http://bmcsensors-26.sourceforge.net/

Ah, thanks.  In the meantime I've found ipmitool for Debian and 
check_ipmi_sensors.pl for Nagios, which hopefully will do what I want it 
to do.

Thanks,
Greg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 May 2010 19:47:50 +0000
Subject: Re: [lm-sensors] k10temp module not working with AMD X2 240 and
Message-Id: <20100529214750.15e18e79@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.vc07mfswopt8b6@localhost.localdomain>
In-Reply-To: <op.vc07mfswopt8b6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Larry,

On Thu, 20 May 2010 18:26:29 -0700, Larry Gagnon wrote:
> Using the Zotac GF-8200-C-E motherboard with an Athlon II X2 240 CPU.  
> 'sensors-detect' finds the k10temp chip and I have modprobed the "k10temp"  
> module successfully. I use the 2.6.33 kernel so k10temp is included.  
> However, on running "sensors" an error is thrown that do not have the  
> correct kernel modules loaded:
> 
> "No sensors found!
> Make sure you loaded all the kernl drivers you need...".
> 
> Any ideas greatly appreciated.

Which version of sensors-detect?

A number of family 10h CPU models have broken sensors, thus k10temp
will refuse to bind to them. I guess your CPU is one of these. Please
share the contents of /proc/cpuinfo.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

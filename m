From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Feb 2009 12:27:20 +0000
Subject: Re: [lm-sensors] how to set max temp for module coretemp?
Message-Id: <20090208132720.3f259c1a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1233717406.13045.2.camel@lap2.vince>
In-Reply-To: <1233717406.13045.2.camel@lap2.vince>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Vince,

On Tue, 03 Feb 2009 22:16:46 -0500, Vince Herried wrote:
> In my /etc/sensors3.conf file I have
> chip "coretemp-*"
> 
>  label temp1 "cpu0"
>  label temp2 "cpu1"
>  set temp1_max      40
>  set temp1_max_hyst 37
>  set temp2_max      52
>  set temp2_max_hyst 47
> 
> [root@lap2 bin]# sensors -s
> Error: Line 2455: Failed to set value
> Error: Line 2456: Unknown feature name
> Error: Line 2457: Unknown feature name
> Error: Line 2458: Unknown feature name
> coretemp-isa-0000: No such subfeature known
> Error: Line 2455: Failed to set value
> Error: Line 2456: Unknown feature name
> Error: Line 2457: Unknown feature name
> Error: Line 2458: Unknown feature name
> coretemp-isa-0001: No such subfeature known
> [root@lap2 bin]# 
> 
> I would like to be able to set the max temps
> but apparently the coretemp driver doesn't allow it?

I confirm that the coretemp driver doesn't allow it, for the simple
reason that these limits are hard limits returned by the CPU itself.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: 2.8.7 doesnt see sensors on my machine.
Message-Id: <20040619094114.5073c11f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406190250.i5J2oDgJ005370@orion.dwf.com>
In-Reply-To: <200406190250.i5J2oDgJ005370@orion.dwf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Reg,

> Sorry if there is a mailing list where this should be discussed, but
> I didnt see any reference on one on the WEB page.

This *is* the mailing list. I edited the web page to make it more clean
just yesterday. I may edit it further if that's not enough.

> On my machine, with a 2.4.x kernel I saw minimal information from
> LM-SENSORS(voltages, temperatures).
> 
> on the same machine with a 2.6.7 (and some previous,- probably all)
> kernel, prog/detect/sensors-detect says 'no sensors detected' as does
> running sensors.
> 
> However, if I load the two modules that I used to (in my 
> /etc/sysconfig/lm_sensors), namely i2c-viapro and w83781d, then
> 'sensors' gives output equivalent to running under 2.4.x
> 
> In any case thought you would like the report, if I can provide any
> additional useful information, let me know.

Interesting case for sure. Could you please provide the full output of
sensors-detect (after unloading any i2c driver) with the 2.6 kernel, and
with the 2.4 as well if possible?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 01 Jan 2006 22:36:27 +0000
Subject: [lm-sensors] Problem with viapro
Message-Id: <20060101233627.19e46fe0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY105-F339D1E6A30421492165B80CB2B0@phx.gbl>
In-Reply-To: <BAY105-F339D1E6A30421492165B80CB2B0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrik,

> I ran the "sensors-detect" script and found out that I should use 
> i2c-viapro, but the module is missing.
> I found it on your homepage, but what do I do with it then?
> 
> Want it to work :(

You need to provide more information about your system if you want us
to be able to help you. Which distribution is this? Which kernel are
you using? Is it a distribution or hand-compiled kernel? How did you
install the sensors-detect script (distribution package or manually)?
Which version of lm_sensors is it?

The i2c-viapro driver is not new, it's been around for a long time
now, so you really should have it if your system is properly installed.

The more details you give to us, the more likely we are to be able to
find out what your problem is.

-- 
Jean Delvare


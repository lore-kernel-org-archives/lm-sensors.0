From: gineera@aspect135.co.uk
Date: Tue, 11 Oct 2011 21:27:13 +0000
Subject: Re: [lm-sensors] Feature request: smsc47b397 (SCH5307-NS)
Message-Id: <201110112227.13235.gineera@aspect135.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTi=+PGMPhMWz9vQA3v90vBRFvrnnYg@mail.gmail.com>
In-Reply-To: <BANLkTi=+PGMPhMWz9vQA3v90vBRFvrnnYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

Picking up on your lm-sensors post in the archives, though not subscribed to 
that list, I also have an xw6400 workstation, and thought comparative info 
might be useful.

This unit is fitted with 2x 5140 2.33GHz dual-core CPU's.  If I run 4 
instances of glxgears to max all 4 cores the temps only rise to 44 deg C.  
(The output air is not particularly warm either).  The fan speeds do not 
change.  4 are reported in the range 1100 to 1500 rpm approx.

On an older xw6200 the fans definitely do vary with load, (and need to).

My reading of the manual you quoted would be that a fixed fan speed is 
selected depending on the hardware configuration (perhaps by BIOS?) rather 
than during running.  That doesn't seem to be happening correctly on your 
model.

My impression is that temp1 is CPU2, temp3 is case, temp4 is CPU1 - is that 
what you find?  Thus I have added this to /etc/sensors.conf:-

chip "smsc47b397-*"

# Custom chip in HP xw6400 workstation
    label temp1 "T1-CPU2"
    ignore temp2
    label temp3 "T3-Case"
    label temp4 "T4-CPU1"

Hope this is helpful (please cc me)

Regards

Alan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 23 Jan 2006 17:36:44 +0000
Subject: [lm-sensors] Asus P5P 800 SE VS sensors !!
Message-Id: <43D5142C.8010706@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1138018402.43d4c862afa36@imp1-g19.free.fr>
In-Reply-To: <1138018402.43d4c862afa36@imp1-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

wbreen at free.fr wrote:
> Dear,
> 
> Can you say me if sensors works with my Asus P5P 800 SE motherboard.
> Excuse me I am a newbie.

Yes we can help.

In short:

0) RTFM -> please read the INSTALL in lm-sensors package http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/QUICKSTART or http://secure.netroedge.com/~lm78/docs.html
1) get the lm_sensors package and install (or install it yourself) (see QUICKSTART or INSTALL file for details how to do that)
2) run "sensors-detect" program it will tell you what modules to load
3) load them using "modprobe" command
4) run "sensors" see results
5) edit /etc/sensors.conf to you needs


regards
Rudolf


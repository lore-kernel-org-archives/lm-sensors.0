From: mds@mds.gotdns.com (Mark Studebaker)
Date: Mon, 07 Nov 2005 23:46:33 +0000
Subject: [lm-sensors] Re:87431 further information
Message-Id: <436FD92B.5090001@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sch?fer Raumgestaltung wrote:
> Hi Mark,
> 
> a little Update:
> 
> registering bmcsensors.o seemed to be ok.... but
> 
> after ending up with message
> 
> -> registered 5 temp, 10 volt, 0 current, 5 fan sensors
> -> bmcsensors thread done
> 
> long time later !
> DMESG shows up
> 
> -> Error 0xcb on cmd 0x4/0x2d; state = 4; probably fatal
> 
> hth
> 
> Uli
> 

hmm that means "requested sensor, data, or record not present",
while reading the sensor value. Never seen that one before.
Actually it doesn't look like it would be fatal...
did the voltage readings continue to work?



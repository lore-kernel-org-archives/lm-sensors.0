From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: hello, i've got a problem with
Message-Id: <Pine.LNX.4.58.0412041305210.2569@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101907862.1886.19.camel@mi-msz>
In-Reply-To: <1101907862.1886.19.camel@mi-msz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Stop stop...
> There is something I don't get here above.
> If temp3 should be set to diode and temp1 to thermistor AFAIK these are
> the sensors.conf lines I have to add:
> set sensor1 2
> set sensor2 0
> set sensor3 3
>
> I'm really confused now ;-)

Oops I think I pasted wrong conf. section,because I was thinking numbers
are all same. (but it seems they dont)

# 2 = thermistor; 3 = thermal diode; 0 = unused

set sensor1 2
set sensor3 3

Yes just add these lines to the right section. (If you have already some,
just edit them) You can ommit "set sensor2 xx", instead you can ignore
temperature via

ignore temp2

Please don't forget to CC to the list.

And dont forget:
sensors -s ; sensors

I hope all is OK now.

Regards

Rudolf

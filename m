From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <20040430232958.3d8b0b1d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sandeep,

A few extra hints and requests.

I have been adding a preliminary pc87366 section to sensors.conf.eg.
Please manually copy to /etc/sensors.conf and test. There are a couple
ignore lines you should uncomment.

I have also been updating the driver so that it honors the "external
vref" configuration bit. Your voltages should report slightly higher
values now (+2%). Vsb and AVdd have supposedly a value of +3.3V and
that's what sensors should report.

Please try setting voltage limits (sensors -s should do for Vsb and
AVdd) and report how it works.

I'd also like you to run the following set of dumps and send me back the
output files, so that I can use this for reference while working on the
driver. I have a similar set for a second PC87366 owner (completely
different motherboard) and comparing results will be useful. Please dump
at a time your chipset is working at best.

isadump -f 0xecc0 16 > pc87366-fans.dump

isadump -f 0xecd0 16 0 > pc87366-in0.dump
isadump -f 0xecd0 16 1 > pc87366-in1.dump
isadump -f 0xecd0 16 2 > pc87366-in2.dump
isadump -f 0xecd0 16 3 > pc87366-in3.dump
isadump -f 0xecd0 16 4 > pc87366-in4.dump
isadump -f 0xecd0 16 5 > pc87366-in5.dump
isadump -f 0xecd0 16 6 > pc87366-in6.dump
isadump -f 0xecd0 16 7 > pc87366-in7.dump
isadump -f 0xecd0 16 8 > pc87366-in8.dump
isadump -f 0xecd0 16 9 > pc87366-in9.dump
isadump -f 0xecd0 16 10 > pc87366-in10.dump
isadump -f 0xecd0 16 11 > pc87366-in11.dump
isadump -f 0xecd0 16 12 > pc87366-in12.dump
isadump -f 0xecd0 16 13 > pc87366-in13.dump

isadump -f 0xecf0 16 0 > pc87366-temp1.dump
isadump -f 0xecf0 16 1 > pc87366-temp2.dump
isadump -f 0xecf0 16 2 > pc87366-temp3.dump

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
